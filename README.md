Getting and Cleaning Data Course Project

This repository hosts the R code and documentation files for the course "Getting and Cleaning data”.

Project Summary:

The run_analysis.R script should be run on the data and it will complete the following steps to transform the data into something that we are able to glean information out of:

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set.
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Repository files:

        1. CodeBook.md describes the how to use all this, variables, the data, and any transformations or work that was performed to clean up the data.
        2. ReadMe.md
        3. run_analysis.R contains all the code to perform the analyses described in the 5 steps. It can be launched in RStudio by just importing the file.
        4. tidydata.txt ,  output of the step 5.
        5. tidydatameans.txt,  output of the step 5. 

Steps to work on this project:

    1. Launch RStudio
    2. Import the file run_analysis.R 
    3. Run source ("run_analysis.R"), then it will be downloaded, unzipped the data sources and generated a new files tidydata.txt and tidydatameans.txt in your working directory.
