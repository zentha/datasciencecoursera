# Getting and Cleaning Data Project John Hopkins Coursera
# Author: Delphine 

# Work to do / Instruction: 
  # 1. Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive variable names.
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# 0. Load Packages and get the Data
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip")) # output : Content type 'application/zip' length 62556944 bytes (59.7 MB) downloaded 59.7 MB
unzip(zipfile = "dataFiles.zip")

# 1. Merges the training and the test sets to create one data set.
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
dataset_combined <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# To be able to do that, I need to merge with the label first then I will be able to select the only the interesting measurements
# Load activity labels + features
activityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), col.names = c("classLabels", "activityName"))
featuresLabels <- fread(file.path(path, "UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))
colnames(dataset_combined) <- featuresLabels[, featureNames]

#Extracts only the measurements on the mean and standard deviation for each measurement.
dataset_combined_mean_std = dataset_combined %>% select(matches("mean|std"))
