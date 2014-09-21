---
title: "README"
author: "rjgrimaila"
date: "September 20, 2014"
---
####This is the course project for the Coursera course [Getting and Cleaning Data](https://class.coursera.org/getdata-007/)
by Jeff Leek, PhD, Roger D. Peng, PhD, Brian Caffo, PhD


This **README.md** document explains how all of the scripts in this repo work and how they are connected.

**CodeBook.md** is a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data. 

**run_analysis.R** is the R script that does the following:  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

mad props to [David's Project FAQ](https://class.coursera.org/getdata-007/forum/thread?thread_id=49)   


  
**tidyDataSet.csv** is the txt file described above, created with write.table() using row.name=FALSE  

*****