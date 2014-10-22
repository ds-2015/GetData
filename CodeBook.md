---
title: "CodeBook - Tidy Data for Human Activity Recognition Using Smartphones Data set"
author: "ds-2015"
date: "Tuesday, October 21, 2014"
output: html_document
---

This tidy data is from Human Activity Recognition Using SmartPhones Data Set. 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Brief Summary of the Original Data  
To make this document self-contained, I include the data summary from the original package. If you are already familiar with the experiments and data processing described in the package, you can skip this session. 

"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data."

"The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

The features come from the accelerometer and gyroscope 3-axial raw signals. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.

## Input Data 
The following files from the original smart phone data package are loaded in run_analysis.R to complete the assignment. 

- "train//X_train.txt":     
Training set. Each row represents an observation and each column gives values for a feature variable.  

- "test//X_test.txt":   
Testing set. Each row represents an observation and each column gives values for a feature variable.  

- "train//y_train.txt":     
Training labels. These labels contribute to the values in the column variable "activity" of the required data.

- "test//y_test.txt":    
Testing labels. These labels contribute to the values in the column variable "activity" of the required data.

- "train//subject_train.txt":     
Subject numbers in the training set. Each row identifies the subject who performed the activity for each observation. Its range is from 1 to 30. 

- "test//subject_test.txt": 
Subject numbers in the testing set. Each row identifies the subject who performed the activity for each observation. Its range is from 1 to 30. 
 
Each row in the above six files represent an observation and correspond to each other. Therefore, 
merging, extracting, transforming, and summarizing by groups for these files will give the required tidy data. 

Two more files are also loaded. 

- "features.txt":      
List of all features. This provides the variable (feature) names to the columns in file 
"X_train.txt" and "X_test.txt"

- "activity_labels.txt":         
Links the class labels with their activity name. This provides the descriptive strings for the "activity"" variable. 


## Data Transformation and Clean Up

### 1. Merges the training and the test sets to create one data set.
Since the training and the test sets contains different observations, so I merge them using row binding ```rbind```. 
For easy manipulation, the training and the test sets are merged before adding "activity" and "subject" variable, that is, merging only the data frames from 
"train//X_train.txt" and "test//X_test.txt". 

### 2. Extracts only the measurements on the mean and standard deviation.
I assume we should extract the feature variables that are the means and the standard deviations estimated from the signals. Based on this assumption, I extracts the features containing sub-string "-mean()" and "-std()". This means, the features only containing the following sub-strings are EXCLUDED from extraction: 

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean

### 3. Uses descriptive activity names to name the activities in the data set.
File "activity_labels.txt" provides the correspondences of the activity names and the class labels in file "y_test(train).txt", therefore
I use ```sapply``` to replace each class label with its corresponding activity names. I do not use ```merge``` function here to avoid the possible re-ordering issues caused by merging the data frames from "activity_labels.txt" and "y_train(test).txt". 

### 4. Appropriately labels the data set with descriptive variable names.
File "features.txt" provides the base of descriptive names for the column variables. CamelCase is used to write compounding descriptive variable names such that each next word or abbreviation begins with a captial letter. I chose CamelCase representation because most variable names would be long in this data and CamelCase does not increase the length while still providing good readability. 

I apply the following steps to transform the original feature names to tidy and descriptive variable names in CamelCase. 

- To change the original feature names to CamelCase, I first replace sub-string "-mean()" and "-std()" with "Mean" and "Std", respectively. Then I also remove all the remaining minus signs "-". 

- By inspecting the original feature names, I found some variables names contain "BodyBody", such as "fBodyBodyGyroJerkMag". This is likely a typo, therefore I replace all "BodyBody" with "Body". 

- The first letter "t" or "f" in the original feature names are not descriptive, so I replace them with more descriptive "Time" and "Freq". 

### 5. Creates a tidy data set with the average for each activity and subject.
In this step, I first add the corresponding "activity" and "subject" variables to the extracted data in step 4. Then I create the required tidy data by summarizing (average) each variable for each activity and each subject (grouping by "activity" and "subject"). 

Finally I add "avg" at the beginning of each variable name in the tidy data because they are actually the average of original variables. 


## Output Tidy Data

### Common Sub-strings in the Variable Names
The values in this tidy data set are the average of each measurement for each activity and each subject. The measurements are the means and the standard deviations selected from the original large collection of measurements. The common sub-strings used in the variable names are explained here: 

- Prefix "avg":      
The average of each measurement for each activity and each subject. 

- "Time":      
The measurement is derived in time domain. 

- "Freq":      
The measurement is in frequency domain after applying a Fast Fourier Transform (FFT) to the signals. 

- "Mean":      
The means estimated from the signals. 

- "Std":       
The standard deviations estimated from the signals. 

### Sub-strings for Various Smartphone Signals
The means and the standard deviations listed above were estimated from the following smartphone signals.

- BodyAcc-XYZ:         
3-axial Body Acceleration signals in the X, Y and Z directions, separated from the accelerometer signals using a low pass Butterworth filter with a corner frequency of 0.3 Hz. 

- GravityAcc-XYZ:          
3-axial Gravity Acceleration signals in the X, Y and Z directions, separated from the accelerometer signals using a low pass Butterworth filter with a corner frequency of 0.3 Hz

- BodyAccJerk-XYZ:          
3-axial Body linear Acceleration Jerk signals in the X, Y and Z directions, derived in time. 

- BodyGyro-XYZ:       
3-axial angular velocity (Gyro) signals in the X, Y and Z directions from the gyroscope. 

- BodyGyroJerk-XYZ:        
3-axial angular velocity (Gyro) Jerk signals in the X, Y and Z directions, derived in time. 

- BodyAccMag:        
The Magnitude of the three-dimensional Body Acceleration signals, calculated using the Euclidean norm. 

- GravityAccMag:          
The Magnitude of the three-dimensional Gravity Acceleration signals, calculated using the Euclidean norm. 

- BodyAccJerkMag:       
The Magnitude of the three-dimensional Body Acceleration Jerk signals, calculated using the Euclidean norm. 

- BodyGyroMag:       
The Magnitude of the three-dimensional angular velocity (Gyro) signals, calculated using the Euclidean norm. 

- BodyGyroJerkMag:        
The Magnitude of the three-dimensional angular velocity (Gyro) Jerk signals, calculated using the Euclidean norm. 

### Units
- All the variables are normalized and bounded within [-1,1]. 


