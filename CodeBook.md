---
title: "CodeBook"
author: "rjgrimaila"
date: "September 20, 2014"
---
*****  
This document **CodeBook.md** is a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data.  

I have chosen to use camelCase in naming variables.  

####Variables  
There are 561 variables itemized in the file **features.txt**  

In **run_analysis.R** I have created additional variables:
    
subjectTrain = raw data load from subject_train.txt dataset   
Xtrain = raw data load from X_train.txt dataset   
Ytrain = raw data load from Y_train.txt dataset   
subjectTest = raw data load from subject_test.txt dataset   
Xtest = raw data load from X_test.txt dataset   
Ytest = raw data load from Y_test.txt dataset   
    
trainingData = merged training datasets   
testData = merged test datasets   
combinedData = merged training + test datasets   
   
meanStdCols = column names where labels contain "mean()" or "std()"   
colNames = column names from combinedData, used to clean-up names   
   
tidy = subest of combinedData, manipulated and exported   
   
####Data  
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project was downloaded as the following [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  

That file was unzips a a directory labelled "UCI HAR Dataset".  That directory is at the same level as the project directory that this code is run from.  That is ...

.../dir/UCI HAR Dataset/
.../dir/GetAndCleanData/
   
   
From the README.txt contained within the zip file we find that ...  
The dataset includes the following files:  
=========================================  

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

####Transformations  
In step #1,   
combined training datasets with ...   
```trainingData = cbind(Ytrain,subjectTrain,Xtrain)```   
combined test datasets with ...   
```testData = cbind(Ytest,subjectTest,Xtest)```   
and then combined training and test datasets with ...   
```combinedData = rbind(trainingData,testData)```   
   
In step # 2
remove uneeded columns ...   
```
# select which columns contain "mean()" or "std()"
meanStdCols <- grepl("mean\\(\\)", names(combinedData)) |
    grepl("std\\(\\)", names(combinedData))
# keep subject and activity columns
meanStdCols[1:2] <- TRUE
# remove unneeded columns
combinedData <- combinedData[, meanStdCols]
```
   
In step #4, liberal use of gsub to change colnames labels ...   
```
#   First, grab the column names ...
colNames  = colnames(combinedData)
#   then clean up the colNames ...
for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\()","",colNames[i])
    colNames[i] = gsub("-std$","StdDev",colNames[i])
    colNames[i] = gsub("-std-","StdDev",colNames[i])
    colNames[i] = gsub("-mean","Mean",colNames[i])
    colNames[i] = gsub("^(t)","time",colNames[i])
    colNames[i] = gsub("^(f)","freq",colNames[i])
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] = gsub("Acc","Acceleration",colNames[i])
    colNames[i] = gsub("Mag","Magnitude",colNames[i])
}
#   and finally relabel column names. :-)
colnames(combinedData) = colNames
```
   


*****