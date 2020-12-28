##load our library
library(dplyr)
##Store as objects each dataset
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("features.txt", col.names = c("n","transformations"))
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$transformations)
y_train <- read.table("train/y_train.txt", col.names = "code")
x_test <- read.table("test/X_test.txt", col.names = features$transformations)
y_test <- read.table("test/y_test.txt", col.names = "code")