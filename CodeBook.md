##Codebook: 
##First the files are unzipped and download in the desired directory
setwd("~/2020/Especialización R/Curso 3-Getting and cleaning data/Week 4/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
##Then each desired dataset is stored as an object by the folowing codes:
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("features.txt", col.names = c("n","transformations"))
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$transformations)
y_train <- read.table("train/y_train.txt", col.names = "code")
x_test <- read.table("test/X_test.txt", col.names = features$transformations)
y_test <- read.table("test/y_test.txt", col.names = "code")
###Merging train and test data
##Generates the vector of subjects by joining the rows of train and test results of the subjects
subjects <- rbind(subject_train, subject_test)
##Generate the xdata by joining by rows the test and train results of x
xdata<-rbind(x_test,x_train)
##Generate the ydata by joining by rows the test and train results of y
ydata<-rbind(y_test,y_train)
### Then the merged dataset was created by joining subjects, ydata and xdata by columns using cbind that joins the columns
mergedataset<-cbind(subjects,ydata,xdata)
###Now we extract only the mean and standard deviations
nicedata <- mergedataset %>% select(subject, code, contains("mean"), contains("std"))
###Give the names of the activities according to the codes and assign it to the code column in nicedata dataset
nicedata$code <- activities[nicedata$code, 2]
nicedata
###Assigning descriptive variable names to the dataset. For this purpose gsub function was used to replace all the first arguments for the second
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
##average of each variable for each activity and each subject.cleanedata is created from nicedata by computing the mean of each variable for each activity and subject (after grouping by subject and by activity). Then the cleanedata is exported as a text file
cleanedata <- nicedata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(cleanedata, "cleanedata.txt", row.name=FALSE)
