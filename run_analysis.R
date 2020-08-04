# Getting And Cleaning Data Project


# required libraries
library(dplyr)


# Download the zip file if the file doesn't exist , unzip

if(!file.exists("samdataset.zip")){
        
        samdataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(samdataset_url, destfile = "samdataset.zip")
        if(!file.exists("UCI HAR Dataset")){
                unzip("samdataset.zip")
        }        
}

#Dataframe created for activitylable, features, subjecttest,xtest, ytest,
#subjecttrain, xtrain, ytrain

activitylabel <- read.table("UCI HAR DATASET/activity_labels.txt" , col.names = c("activityno", "activity"))
functionalfeatures <- read.table("UCI HAR DATASET/features.txt", col.names = c("featureno", "featurefunction"))
subjecttest <- read.table("UCI HAR DATASET/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR DATASET/test/X_test.txt", col.names = functionalfeatures$featurefunction)
ytest <- read.table("UCI HAR DATASET/test/y_test.txt", col.names = "activityno" )
subjecttrain <- read.table("UCI HAR DATASET/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR DATASET/train/X_train.txt", col.names = functionalfeatures$featurefunction)
ytrain <- read.table("UCI HAR DATASET/train/y_train.txt", col.names = "activityno")




# Merge the training and the test sets to create one data set

mergedx <- rbind(xtrain, xtest)
mergedy <- rbind(ytrain, ytest)
mergedsubject <- rbind(subjecttrain, subjecttest)
mergedset <- cbind(mergedsubject, mergedy, mergedx)

#Extract only the measurements on the mean and standard deviation for each measurement.

meanandstdextracted <- mergedset %>% select(subject,activityno, contains("mean"), contains("std"))

#Uses descriptive activity names to name the activities in the data set
meanandstdextracted$activityno = activitylabel[meanandstdextracted$activityno,2]


#Appropriately labels the data set with descriptive variable names
names(meanandstdextracted)[2] <- "activity"
names(meanandstdextracted) <- gsub("\\.","",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("^t","time",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("^f","frequency",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Body","body",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("bodybody","body",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Mag","magnitude",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Acc","accelerometer",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Gyro","gyroscope",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Freq","freq",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Jerk","jerk",names(meanandstdextracted))
names(meanandstdextracted) <- gsub("Mean","mean",names(meanandstdextracted))


#From the data set in step 4, creates a second, independent tidy data set with
#the average of each variable for each activity and each subject.

tidydata <- meanandstdextracted %>% group_by(subject, activity) %>%
            summarise_each(funs(mean))

# The final tidydata is written into the text file

write.table(tidydata, "tidydata.txt", row.names = FALSE)











