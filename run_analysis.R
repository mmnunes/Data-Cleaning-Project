## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Download the dataset and unzip folder

## Check if directory already exists
if(!file.exists("./projectData")){
  dir.create("./projectData")
}

setwd("./projectData")

Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"
download.file(Url, zipfile, mode = "wb")

if(file.exists(zipfile)) unzip(zipfile)


## 1. Merges the training and the test sets to create one data set.
## a. Read X_train, y_train data and subject_train.
trainData <- read.table("./UCI HAR Dataset/train/X_train.txt", header= FALSE)
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt", header= FALSE)
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header= FALSE)

## b. Read X_test, y_test data and subject_test.
testData <- read.table("./UCI HAR Dataset/test/X_test.txt", header= FALSE)
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt", header= FALSE)
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header= FALSE)

## c. Concatenate trainData/testData, trainLabel/testLabel and trainSubject/testSubject
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## a. Read features.txt
features <- read.table("./UCI HAR Dataset/features.txt")

## b.Extract measures mean and standard deviation
columnsWithMeanSTD <- grep("mean\\(\\)|std\\(\\)", features[, 2])
joinData <- joinData[, columnsWithMeanSTD]

## c. Clean column names and capitalize first letter of mean and std
names(joinData) <- gsub("\\(\\)", "", features[columnsWithMeanSTD, 2])
names(joinData) <- gsub("-", "", names(joinData)) 
names(joinData) <- gsub("mean", "Mean", names(joinData)) 
names(joinData) <- gsub("std", "Std", names(joinData)) 

## 3. Uses descriptive activity names to name the activities in the data set
## a. Read activity labels and Clean activity names in the second column
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))

## b. Transform joinLabel according to activityLabel
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

## 4. Appropriately labels the data set with descriptive activity names.
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
write.table(cleanedData, "tidydata.txt") 


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subjectLength <- length(table(joinSubject))
activityLength <- dim(activity)[1] 
columnLength <- dim(cleanedData)[2]

result <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength) 
result <- as.data.frame(result)

colnames(result) <- colnames(cleanedData)
row <- 1

for(i in 1:subjectLength) {
  for(j in 1:activityLength) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    flag1 <- i == cleanedData$subject
    flag2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLength] <- colMeans(cleanedData[flag1&flag2, 3:columnLength])
    row <- row + 1
  }
}
head(result)

write.table(result, "tidydatameans.txt",row.name=FALSE,quote = FALSE, sep = '\t') 
