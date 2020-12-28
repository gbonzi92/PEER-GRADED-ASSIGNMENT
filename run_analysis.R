##1#Let's first prepare for merging train and test data
##Generate the vector of subjects
subjects <- rbind(subject_train, subject_test)
##Generate the xdata by joining by rows
xdata<-rbind(x_test,x_train)
##Generate the ydata by joining by rows
ydata<-rbind(y_test,y_train)
### Now we create the merged dataset by joining subjects, ydata and xdata by columns
mergedataset<-cbind(subjects,ydata,xdata)
##2#Now we extract only the mean and standard deviations
nicedata <- mergedataset %>% select(subject, code, contains("mean"), contains("std"))
##3#Give the names of the activities according to the codes and assign it to the code column in nicedata dataset
nicedata$code <- activities[nicedata$code, 2]
nicedata
##4#Assigning descriptive variable names to the dataset
names(nicedata)<-gsub("Gyro", "gyroscope", names(nicedata))
names(nicedata)<-gsub("Acc", "accelerometer", names(nicedata))
names(nicedata)<-gsub("BodyBody", "body", names(nicedata))
names(nicedata)<-gsub("-std()", "stdev", names(nicedata), ignore.case = TRUE)
names(nicedata)<-gsub("-freq()", "frequency", names(nicedata), ignore.case = TRUE)
names(nicedata)<-gsub("-mean()", "mean", names(nicedata), ignore.case = TRUE)
names(nicedata)[2] = "activity"
names(nicedata)<-gsub("Mag", "magnitude", names(nicedata))
names(nicedata)<-gsub("^t", "time", names(nicedata))
names(nicedata)<-gsub("^f", "frequency", names(nicedata))
names(nicedata)<-gsub("tBody", "timebody",names(nicedata))
#5#average of each variable for each activity and each subject.
cleanedata <- nicedata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(cleanedata, "cleanedata.txt", row.name=FALSE)
