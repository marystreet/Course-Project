# Getting and Cleaning Data

## Course Project

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps to work on this course project

1. Download the data source and put into a folder on local drive. The download will create a ```UCI HAR Dataset``` folder
2. Create ```run_analysis.R``` in the folder ```UCI HAR Dataset```
3. Set it as your working directory using ```setwd()``` function in RStudio
4. Run ```source("run_analysis.R")```
5. It will generate a new file ```TinyData.txt``` in the folder ```UCI HAR Dataset```

## Dependencies

```run_analysis.R``` requires the installation of packages ```reshape2``` and ```data.table``` but will handle the ```library``` of them