#############################################################################
# download and unzip data
#   method "curl" used because I'm running on a Mac
#   data is unzipped to a directory called "wearabledata"
#############################################################################

library(utils)
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile="../wearabledata.zip",method="curl")
unzip("../wearabledata.zip",exdir="../wearabledata")

#############################################################################
# Question 1: merge the training and the test sets to form one dataset
#############################################################################

# Read in test and training values and activities
testdata <- read.table("../wearabledata/UCI HAR Dataset/test/X_test.txt")
test.activities <- read.table("../wearabledata/UCI HAR Dataset/test/y_test.txt")
traindata <- read.table("../wearabledata/UCI HAR Dataset/train/X_train.txt")
train.activities <- read.table("../wearabledata/UCI HAR Dataset/train/y_train.txt")

# Read in activity labels
activity.labels <- read.table("../wearabledata/UCI HAR Dataset/activity_labels.txt")

# Read in subject IDs for test and training data
test.subjects <- read.table("../wearabledata/UCI HAR Dataset/test/subject_test.txt")
train.subjects <- read.table("../wearabledata/UCI HAR Dataset/train/subject_train.txt")

# merge test and training data, and add subject and activity variables
alldata <- rbind(testdata,traindata)
alldata$subject <- c(test.subjects$V1,train.subjects$V1)
alldata$activity <- factor(c(test.activities$V1,train.activities$V1),
                           levels=activity.labels$V1,labels=activity.labels$V2)

# Add a new variable "train" indicating training (0) or test (1) observation
alldata$train <- c(rep(0,nrow(testdata)),rep(1,nrow(traindata)))

#############################################################################
# Question 2: Extract only the measurements on the mean and standard
#             deviation for each measurement.
#############################################################################

features <- read.table("../wearabledata/UCI HAR Dataset/features.txt")
   # note: some of the features are repeated!
std.or.mean <- grep("std\\(\\)|mean\\(\\)",features$V2)
features$V2[std.or.mean]
features$V1[std.or.mean]
std.or.mean.names <- paste("V",as.character(features$V1)[std.or.mean],sep="")
std.or.mean.descriptive.names <- as.character(features$V2)[std.or.mean]
reduced <- alldata[,c(std.or.mean.names,"subject","activity","train")]

#############################################################################
# Question 3: Use descriptive activity names in the dataset
# This has already been done
#############################################################################

#############################################################################
# Question 4: Appropriately labels the data set with descriptive
#             variable names.
#############################################################################

names(reduced)[1:length(std.or.mean)] <- std.or.mean.descriptive.names

#############################################################################
# Question 5: creates a second, independent tidy data set with the average
#             of each variable for each activity and each subject.
#############################################################################

library(reshape2)

long.thin.data <- melt(reduced,id=c("activity","subject"),
                       measure.vars=std.or.mean.descriptive.names)

meanvalues.activity.subject <- with(long.thin.data,
                                    aggregate(value,
                                      list(activity=activity,subject=subject,
                                           variable=variable),
                                      mean))
names(meanvalues.activity.subject)[4] <- "meanvalue"

write.table(meanvalues.activity.subject,file="tidymeanvalues.txt")


