#---
#title: "run_analysis.R"
#author: "rjgrimaila"
#date: "September 20, 2014"
#---
# Step 1: Merge the training and the test sets to create one data set.
#
# read files into dataframes, and add appropriate labels
#
features <- read.table("../UCI HAR Dataset/features.txt",header=FALSE)
#features
#
# training datasets
subjectTrain <- read.table("../UCI HAR Dataset/train/subject_train.txt",header=FALSE)
colnames(subjectTrain) = "subject"
Xtrain <- read.table("../UCI HAR Dataset/train/X_train.txt",header=FALSE)
colnames(Xtrain) = features[,2]
Ytrain <- read.table("../UCI HAR Dataset/train/Y_train.txt",header=FALSE)
colnames(Ytrain) = "activity"
#
# test datasets
subjectTest <- read.table("../UCI HAR Dataset/test/subject_test.txt",header=FALSE)
colnames(subjectTest) = "subject"
Xtest <- read.table("../UCI HAR Dataset/test/X_test.txt",header=FALSE)
colnames(Xtest) = features[,2]
Ytest <- read.table("../UCI HAR Dataset/test/Y_test.txt",header=FALSE)
colnames(Ytest) = "activity"
#
#
# merge training data
trainingData = cbind(Ytrain,subjectTrain,Xtrain)
# merge test data
testData = cbind(Ytest,subjectTest,Xtest)
# merge training + test data
combinedData = rbind(trainingData,testData)
#
#
# Step 2: Extract only the measurements on the mean and standard deviation for each measurement. 
#
# select which columns contain "mean()" or "std()"
meanStdCols <- grepl("mean\\(\\)", names(combinedData)) |
    grepl("std\\(\\)", names(combinedData))
# keep subject and activity columns
meanStdCols[1:2] <- TRUE
# remove unneeded columns
combinedData <- combinedData[, meanStdCols]
#
# Step 3: Use descriptive activity names to name the activities in the data set
#
# convert the activity column from integer to factor
combinedData$activity <- factor(combinedData$activity, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))
#
# Step 4: Appropriately label the data set with descriptive variable names. 
#
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
#   and finally relabel column names.
colnames(combinedData) = colNames
#colnames(combinedData) # to view the renamed column names
#
# Step 5: Create a second, independent tidy data set with the average  
#         of each variable for each activity and each subject.
#
combinedData$activity <- as.factor(combinedData$activity)
combinedData$subject <- as.factor(combinedData$subject)

tidy = aggregate(combinedData, by=list(activity = combinedData$activity, subject=combinedData$subject), mean)
# col 3&4 are now gibberish, so remove them
tidy <- subset(tidy[ ,c(-3,-4)])
# use write.table() using row.name=FALSE
write.table(tidy, file = "tidy.txt", sep = ",", row.name=FALSE)

