# 0. load data that are needed for the project
trainx<-read.table("train//X_train.txt")
testx<-read.table("test//X_test.txt")
trainy<-read.table("train//y_train.txt")
testy<-read.table("test//y_test.txt")

train_sub<-read.table("train//subject_train.txt")
test_sub<-read.table("test//subject_test.txt")
fea<-read.table("features.txt")
act_label<-read.table("activity_labels.txt")

# 1. merge training and testing data
all_data<-rbind(trainx, testx)

# 2. extracts only the measurements on the mean and standard deviation
# for each measurement
sel_fea<-filter(fea, grepl("-mean\\(\\)", V2) | grepl("-std\\(\\)", V2))
extracted_data<-select(all_data, sel_fea[,1])

# 3 use descriptive activity names to name the activities in the data set
# use the lowercase version of the original labels in activity_labels 
# since they are descritive enough. We use lowercase here for readability. 
trainy2 <- sapply(trainy, function(x) act_label[x,2])
testy2 <- sapply(testy, function(x) act_label[x,2])

# 4 appropriately label the data set with descriptive variable names

# replace "-mean()-" and "-std()-" with "Mean" and "Std" for CamelCase represetation
cnames <- sub("-mean\\(\\)","Mean",sel_fea[,2])
cnames <- sub("-std\\(\\)","Std",cnames)               

# remove the remaining "-" signs
cnames <- sub("-", "", cnames)

# also notice some variable names have "BodyBody" that should be a typo so fix it
cnames <- sub("BodyBody","Body", cnames)

# finally replace the beginning "t" with "time", and the beginning "f" with "freq" 
# for descriptive
# in the same operation we also add "avg" at the beginning since the next 
# step calculates group average, and we don't need transform variable names
# one more time for the next step
cnames <- sub("^t", "avgTime", sub("^f","avgFreq",cnames))
names(extracted_data)<-cnames

# 5. Create a second, independent tidy data set with the average of each
# variable for each activity and each subject

# add the corresponding activity and subject variables to extracted data
extracted_data$activity<-c(trainy2, testy2)
extracted_data$subject<-c(train_sub$V1, test_sub$V1)

# average by groups
tidy_data <- extracted_data %>% 
        group_by(subject, activity) %>% summarise_each(funs(mean))

# save the tidy data
write.table(tidy_data,file="tidy_data.txt",row.names=FALSE)


