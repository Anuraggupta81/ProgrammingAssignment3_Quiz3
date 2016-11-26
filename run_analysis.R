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


#Reading Activity file, features and features Info txt file
activityLabels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

colNames <- data.frame(features[,2])
library(reshape)
colNames <-t(colNames)

#Merging X dataset together and Y dataset together Point 1
data <- rbind(xTrainDF,xTestDF)
yVar <- rbind(yTrainDF,yTestDF)

#Getting labels mapped to the outcome
labels <- merge(yVar,activityLabels,by=1)[,2]


#Dataset labelled against Descriptive activity Point 4
mergeyVar <- cbind(data,labels)


TrainSet <- cbind(data,yVar)

#Searching the Mean and Standard deviation column from the complete dataset Point 2
search <- grep("-mean|-std", colnames(mergeyVar))
data.mean.std <- mergeyVar[,c(1,2,search)]

activitySet <- cbind(labels,data.mean.std)


write.table(mergeyVar,file="merge.txt",row.names = FALSE)
write.table(data.mean.std,file="data.mean.std.txt",row.names = FALSE)
