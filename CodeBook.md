---
title: "Project-Getting and Cleaning Data"
author: "Sabitha"
date: "8/4/2020"
output: html_document
---


## About the Project
       
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set .The goal is to prepare tidy data that can be used for later analysis. 

## Introduction about data 
        
The data is obtained from <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> for the entire description.
The data is about the experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


        
## Data Collection , Description and Processing
 
The raw data is collected from the following website:  
        
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
        
The file is downloaded and unzipped and cleaning process is carried out in 6 different steps.
        
# Step1: Downloading raw data
The raw data is downloaded and extracted from the zip file and stored in the folder called **UCI HAR Dataset**
which has the following files.

**File description:**
        
- 'features_info.txt': 

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units         'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files            for the Y and Z axis. 
        
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total                     acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units            are radians/second. 
        
The **run_analysis.R** script is executed to attain the process for this data.
        
# The following is the r script is for loading required libraries ,  downloading , unzipping data.
        
```{r}
# run_analysis.R
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

```
# Step2: The variables are assigned for each collected data. 

The data collected from the **activity_labels.txt**  are stored in 2 variables called
**activityno and activity** and assigned to the dataframe **activitylabel**.

**activityno -> 1 to 6**

**activity -> WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS,SITTING,STANDING,LAYING**
          
The data collected from **features.txt** are stored in varaibles called **featureno and featurefunction** 
and assigned to dataframe **functionalfeatures**.

The data collected from **subject_test.txt** are stored in varaibles called **subject** and assigned to
dataframe **subjecttest**.

The data collected from **X_test.txt** are stored in the variable **functionalfeatures** where the values are 
assigned from the **functionalfeatures ** and assigned to the dataframe **xtest**.

The data collected from **y_test.txt** are stored in the varaiable as **activityno** and assigned to the dataframe 
**ytest**.

The data collected from **subject_train.txt** are stored in varaibles called **subject** and assigned to
dataframe **subjecttrain**.

The data collected from **X_train.txt** are stored in the variable **functionalfeatures** where the values are 
assigned from the **functionalfeatures ** and assigned to the dataframe **xtrain**.

The data collected from **y_train.txt** are stored in the varaiable as **activityno** and assigned to the dataframe 
**ytrain**.
        
**The following code is executed:**
**Dataframe created for activitylable, features, subjecttest,xtest, ytest,subjecttrain, xtrain, ytrain **


```{r}
activitylabel <- read.table("UCI HAR DATASET/activity_labels.txt" , col.names = c("activityno", "activity"))
functionalfeatures <- read.table("UCI HAR DATASET/features.txt", col.names = c("featureno", "featurefunction"))
subjecttest <- read.table("UCI HAR DATASET/test/subject_test.txt", col.names = "subject")
xtest <- read.table("UCI HAR DATASET/test/X_test.txt", col.names = functionalfeatures$featurefunction)
ytest <- read.table("UCI HAR DATASET/test/y_test.txt", col.names = "activityno" )
subjecttrain <- read.table("UCI HAR DATASET/train/subject_train.txt", col.names = "subject")
xtrain <- read.table("UCI HAR DATASET/train/X_train.txt", col.names = functionalfeatures$featurefunction)
ytrain <- read.table("UCI HAR DATASET/train/y_train.txt", col.names = "activityno")


```

# Step3: Training and Test data sets are merged and created into one complete dataset
        
**mergedx:** mergedx is created using rbind function to merge xtrain and xtest dataset as shown below.

**mergedy:** mergedy is created using rbind function to merge ytrain and ytest data as shown below.

**mergedsubject:** mergedsubject is created using rbind function to merge subjecttrain and subjecttest as shown below.

**mergedset:** mergedset is the complete dataset which has merged values of variables mergedsubject, mergedy and mergedx
with the help of cbind function as follows.


**The following code is executed**
```{r}
# Merge the training and the test sets to create one data set
mergedx <- rbind(xtrain, xtest)
mergedy <- rbind(ytrain, ytest)
mergedsubject <- rbind(subjecttrain, subjecttest)
mergedset <- cbind(mergedsubject, mergedy, mergedx)

```
                     
# Step4: From the complete merged dataset, data is extracted only for the measurements mean and std varaiables.

The pipe operation is used here for passing mergedset as an input. only the columns with the mean and std function
are extracted and the subsetted data is stored in varaible **meanandextracted** as shown below. 

```{r}
#Extract only the measurements on the mean and standard deviation for each measurement.

meanandstdextracted <- mergedset %>% select(subject,activityno, contains("mean"), contains("std"))


```
# Step5: Usng descriptive activity names instead of activity number in the dataset. 

The activityno column is replaced by the corresponding activities from the activitylabel's activity variable using the 
code as shown below.


        
```{r}

#Uses descriptive activity names to name the activities in the data set
meanandstdextracted$activityno = activitylabel[meanandstdextracted$activityno,2]


```

# Step6: Assigning the descriptive variable names for the labels in the dataset.
        
All the periods from the variable names are removed.
activityno column is renamed to activity.
The variable that had acc is replaced with the word accelerator
The variable that had f, freq is replaced by frequency
The variable that had gyro is replaced by gyroscope
The Mean is replaced by mean 
The t is replaced by time
The body, bodydoby is replaced by body
The Jerk is replaced by jerk


```{r}
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


```
# Calculating Mean:
Mean is calculated for the variables in the tidydata set which is **meanandextracted** dataset
for each subject and each activity and the resulting dataset is assigned to **tidydata** table.
The opertion is carried out using following statemet. So the final resultant table is **tidydata** 
which has cleaned data with the average calculated for each measurement variable.
         

```{r}       
         tidydata <- meanandstdextracted %>% group_by(subject, activity) %>%
         summarise_each(funs(mean))
```

# Creating text file: 
The dataset tidydata is stored in the text file **tidydata.txt** using write.table function
as shown below.

```{r}

write.table(tidydata, "tidydata.txt", row.names = FALSE)



```

         

