#Setting up the working directory
setwd("C:/Users/Anurag_gupta11/Desktop/Secondary work stack/Data science/Quiz/Course 3 - Getting and cleaning data")


#Reading all the txt files in Train folder
xTrainDF <- read.table("train/X_train.txt")
yTrainDF <- read.table("train/Y_train.txt")
subjectTrainDF <- read.table("train/subject_train.txt")

#reading all the txt files in test folder
xTestDF <- read.table("test/X_test.txt")
yTestDF <- read.table("test/Y_test.txt")
subjectTestDF <- read.table("test/subject_test.txt")



#Merging X dataset together and Y dataset together Point 1
xdata <- rbind(xTrainDF,xTestDF)
ydata <- rbind(yTrainDF,yTestDF)
subject_data <- rbind(subjectTrainDF,subjectTestDF)


#Reading features files
features <- read.table("features.txt")
# Searchign for "Mean | std" col names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
xdata <- xdata[,mean_and_std_features]
names(xdata) <- features[mean_and_std_features,2]

#Reading Activity file, features and features Info txt file
activityLabels <- read.table("activity_labels.txt")
ydata[, 1] <- activityLabels[ydata[, 1], 2]

#Changing the column name
names(ydata) <- "activity"

names(subject_data) <- "subject"

#Getting labels mapped to the outcome

all_data <- cbind(xdata,ydata,subject_data)


################################33

#Step 5 creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)
