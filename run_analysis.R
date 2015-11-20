#R Script for Getting and Cleaning Data Project

# Step 1
setwd("UCI HAR Dataset")
features <- read.table("features.txt")

# read and process test data, activity and subjects
x_test <- read.table("test/X_test.txt")
subject_id <- read.table("test/subject_test.txt")
activity_code <- read.table("test/y_test.txt")

# set column names on tables - which accomplishes step 4
colnames(x_test) <- features$V2
colnames(subject_id) <- c("subjectid")
colnames(activity_code) <- c("activitycode")

# bind columns
x_test2 <- cbind(x_test, subject_id)
x_test3 <- cbind(x_test2, activity_code)

# setup a column for test=1
testType <- data.frame(c(1), c(1))
colnames(testType) <- c("index", "testORtrain")

# bind test type column
x_test4 <- cbind(x_test3, testType)


# read and process train data, activity and subjects
xa_train <- read.table("train/X_train.txt")
subject2_id <- read.table("train/subject_train.txt")
activity2_code <- read.table("train/y_train.txt")

# set column names on tables
colnames(xa_train) <- features$V2
colnames(subject2_id) <- c("subjectid")
colnames(activity2_code) <- c("activitycode")

# bind columns
xa_train2 <- cbind(xa_train, subject2_id)
xa_train3 <- cbind(xa_train2, activity2_code)

# setup a column for test=0
trainType <- data.frame(c(1), c(0))
colnames(trainType) <- c("index", "testORtrain")

# bind train type column
xa_train4 <- cbind(xa_train3, trainType)

# can now combine the test and train data
trainAndTest2 <- rbind(xa_train4, xa_test4)

# Step 2.
# subset the features.txt dataset to get mean and std
desiredFeatures <- features[grep("mean|std", features$V2), ]
# subset trainAndTest by the rows in the set we just created
justFeatures <- desiredFeatures $V2
meansAndDevs2 <- trainAndTest2[justFeatures]
meansAndDevs3 <- trainAndTest2[c(which(grepl( "mean" , names( trainAndTest2 ) )), 
   which(grepl( "std" , names( trainAndTest2 ) )),
   which(colnames(trainAndTest2)=="activitycode"))]

# Step 3.
activityLabels <- read.table(“activity_labels.txt”)
meansAndDevs$activitycode <- factor(meansAndDevs$activitycode)
levels(meansAndDevs$activitycode) <- activityLabels$V2

# Step 4
# done as part of step 1

# Step 5
# create tidy data set with avg of each activity and subject
# use summarize_each and/or group by
step5 <- group_by(meansAndDevs3, activitycode)
step5b <- summarise_each(step5, funs(mean))

