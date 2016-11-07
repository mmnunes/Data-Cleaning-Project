Code Book

This document describes the code inside run_analysis.R.

The code is splitted (by comments) in some sections:

Loading and Extract data
Manipulating data
Writing data to CSV


Read dataset files from UCI HAR to given name and prefix. Know names are "train" and "test". Known prefixes are "X", "y" and "subject".

Examples:

UCI HAR Dataset/train/X_train.txt
UCI HAR Dataset/train/y_train.txt
UCI HAR Dataset/train/subject_train.txt

Loads data, labels and subjects from UCI HAR dataset to a data.frame. The returned data.frame contains a column Activity with labels integer codes, a column Subject with subjects integer codes and all other columns from data.

Constants


Reads the activity labels to activityLabels
Reads the column names of data (a.k.a. features) to features
Reads the test data.frame to testData
Reads the trainning data.frame to trainningData
Manipulating data

Merges test data and trainning data to Data
Indentifies the mean and std columns (plus Activity and Subject) to columnsWithMeanSTD

Transforms the column Activity into a factor.
Uses activityLabels to name levels of Activity factor.

Writing final data to CSV
