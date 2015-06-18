## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.Test <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep = " ")

library(data.table)
library(reshape2)

# Test Data - Load and Process
## Load the test x,y data and subject data
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
SubjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Read the Activity Labels and Features
ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
Features <- read.table("./UCI HAR Dataset/features.txt")[,2]

## Name the coloums in X_test, select only the features that contain 
## mean and standard deviation, reduce the X_test to just the columns with 
## mean and standard deviation
names(X_test) = Features
SubFeatures <- grepl("mean|std", Features)
X_test <- X_test[,SubFeatures]

# Load activity labels and label the test subjects
y_test[,2] = ActivityLabels[y_test[,1]]
names(y_test) = c("ActivityID", "ActivityLabel")
names(SubjectTest) = "Subject"

# Bind test data
TestData <- cbind(as.data.table(SubjectTest), y_test, X_test)

# Train Data - Load and Process
## Load the train x,y data and subject data
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
SubjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Name the coloums in X_train, reduce the X_train to just the columns with 
## mean and standard deviation
names(X_train) = Features
X_train <- X_train[,SubFeatures]

## Load activity labels and label the test subjects
y_train[,2] = ActivityLabels[y_train[,1]]
names(y_train) = c("ActivityID", "ActivityLabel")
names(SubjectTrain) = "Subject"

## Bind train data
TrainData <- cbind(as.data.table(SubjectTrain), y_train, X_train)

## Merge test and train data
FullData = rbind(TestData, TrainData)

## Create labels for the full dataset
IdLabels = c("Subject", "ActivityID", "ActivityLabel")
DataLabels = setdiff(colnames(FullData), IdLabels)
MeltData = melt(FullData, id = IdLabels, measure.vars = DataLabels)

# Apply mean function to the full data 
TidyData = dcast(MeltData, Subject + ActivityLabel ~ variable, mean)

write.table(TidyData, file = "./TidyData.txt", row.name = FALSE)