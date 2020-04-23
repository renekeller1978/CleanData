## Script for Getting and Cleaning Data Course Project


##Download file to local drive
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="Dataset.zip")

##Unzip the file contents
unzip("Dataset.zip")

##Read Table of Features 9will be later used for column names
Features<-read.table("UCI HAR Dataset/features.txt")

##Read activity labels
ActivityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")

##Read Test Subjects
TestSubjects<-read.table("UCI HAR Dataset/test/subject_test.txt")

##Read Test X
TestX<-read.table("UCI HAR Dataset/test/X_test.txt")

##Read Test Y
TestY<-read.table("UCI HAR Dataset/test/Y_test.txt")

##Read Train Subjects
TrainSubjects<-read.table("UCI HAR Dataset/train/subject_train.txt")

##Read Train X
TrainX<-read.table("UCI HAR Dataset/train/X_train.txt")

##Read Train Y
TrainY<-read.table("UCI HAR Dataset/train/Y_train.txt")

##Combine Train and test Datasets - STEP 1
BigX<-rbind(TrainX,TestX)
BigY<-rbind(TrainY,TestY)
BigSubjects<-rbind(TrainSubjects,TestSubjects)

##name columns according to Features - STEP 4
colnames(BigX)<-Features[,2]

##catch mean() and std() columns - STEP 2
meanstd<-grepl("mean()",Features[,2],fixed=TRUE) | grepl("std()",Features[,2],fixed=TRUE) 
SmallX<-BigX[,meanstd]

##column names for Subjects and Measurements
colnames(BigSubjects)<-c("Subject")
colnames(BigY)<-c("MeasurementsRAW")

##Create Column with Measurement Description - STEP 3
install.packages("dplyr")
library(dplyr)
BigY<-mutate(BigY,MeasurementsText=ActivityLabels[MeasurementsRAW,2])

##take initial observations out
BigY<-select(BigY,-MeasurementsRAW)

##Combine into one big dataset
CombinedDS<-cbind(BigSubjects,BigY,SmallX)

##Save Dataset
write.table(CombinedDS,"CombinedDS.txt",row.name=FALSE)


##Do the second dataset - STEP 5
install.packages("reshape2")
library(reshape2)

##melt and keep subjects and measurements
meltedDS<-melt(CombinedDS,id=c("Subject","MeasurementsText"))
##Group
GoupedMelted<-group_by(meltedDS,Subject,MeasurementsText,variable)
##Summarize
Summarized<-summarize(GoupedMelted,value=mean(value))
##Cast Out
Casted<-dcast(Summarized,Subject+MeasurementsText~variable,sum)

##Save Dataset
write.table(Casted,"AverageDS.txt",row.name=FALSE)


