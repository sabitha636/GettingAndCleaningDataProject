## Peer-Graded Assignment: Getting and Cleaning Data Course Project

This explains how the data from <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
and <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> is downloaded, cleaned and processed using the RScript **run_analysis.R**

This repo has following files:

# CodeBook.md 

This codebook give you the information about data downloaded, what files are read,what variables are used, what subset of data is extracted from the measurements varaiables, how the variables are assigned to the new names which are more tidy with lowercase, no periods and so on. It explains about the analysis performed and clean data is produced and wrriten in a text file as a final output.

# run_analysis.R 

libray"dplyr" is required to run the script .

Files required are : activity_labels.txt, features.txt,subject_test.txt,X_test.txt,y_test.txt,
subject_train.txt,X_train.txt,y_train.txt

Download the zip file if the file doesn't exist , unzip

Dataframe created for activitylable, features, subjecttest,xtest, ytest,
subjecttrain, xtrain, ytrain

Merge the training and the test sets to create one data set

Extract only the measurements on the mean and standard deviation for each measurement.

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names

From the data set in step 4, creates a second, independent tidy data set with
the average of each variable for each activity and each subject.

The final data produced that are tidy is written in the text file.





# tidydata.txt

tidydata.txt is a text file which has the ouput of final data produced by executing the rscript after all transformations.

# README.md

This file gives the overall information of the project and the steps carried out in getting and cleaning data process.




