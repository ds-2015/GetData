---
title: "README - Tidy Data for Human Activity Recognition Using Smartphones Data set"
author: "ds-2015"
date: "Monday, October 20, 2014"
output: html_document
---

The repo directory contains the following files: 

- "tidy_data.txt":     
The created tidy data, can be loaded in R 
read.table("tidy_data.txt",row.names=FALSE)

- "README.md":     
ReadMe file to describe the repo files and how the script works. 

- "CodeBook.md":     
The code book to describe each variable in the tidy data. 

- "run_analysis.R":         
The R script to create the tidy data from the original data package. 

To create a tidy data set, first set the working directory to the folder where the smartphone data is located, then run the R script file run_analysis.R. For example, if the data is automatically unzipped 
into "/myDir/UCI HAR Dataset", run the following commands in R  

```
setwd="/myDir/UCI HAR Dataset"
source('C:/_ds/03GetData/pa/run_analysis.R')
```

The following files from the original smart phone data package are loaded in run_analysis.R. 

- "train//X_train.txt":     
- "test//X_test.txt":   
- "train//y_train.txt":     
- "test//y_test.txt":    
- "train//subject_train.txt":     
- "test//subject_test.txt": 
- "features.txt":      
- "activity_labels.txt":         




