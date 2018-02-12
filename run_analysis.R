

library(dplyr)
library(readr)
library(tidyr)
#The link where to get the data
URL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download the data
download.file(URL, destfile = "data.zip")
rm(URL)
#unzip
#unzip
unzip("data.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)
#Read the files
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")

#read the list with the variable names
features<-read.table("UCI HAR Dataset/features.txt")

#assign descriptive variable names
subject_test<-rename(subject_test,idvolunteer=V1)
subject_train<-rename(subject_train,idvolunteer=V1)
Y_test<-rename(Y_test,idactivity=V1)
Y_train<-rename(Y_train,idactivity=V1)
colnames(X_test)<-features$V2
colnames(X_train)<-features$V2

#create one dataset
IDvolunteer<-rbind(subject_test,subject_train)
IDactivity<-rbind(Y_test,Y_train)
ID<-cbind(IDvolunteer,IDactivity)
mydata<-rbind(X_test,X_train)

#make columnames valid and select colums with mean and std
names<-names(mydata)
valid_column_names <- make.names(names, unique=TRUE, allow_ = TRUE)
colnames(mydata)<-valid_column_names
extract_Data <- select(mydata,contains("mean"), contains("std"))

#finaly one dataset
extract_Data<-cbind(ID,extract_Data)

#read the list with activity_labels
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

#make colum with activitynames
extract_Data<-mutate(extract_Data,activitynames <- activity_labels$V2[extract_Data$idactivity])
names(extract_Data)[89]<-"activity"
#remove IDactivity and rearange colums
extract_Data<-select(extract_Data,(1),(89),(3:88))

#make columnnames more descriptive
descriptive_names<-tolower(names(extract_Data))
colnames(extract_Data)<-descriptive_names
descriptive_names<-sub("^t","time",names(extract_Data))
colnames(extract_Data)<-descriptive_names
descriptive_names<-sub("^f","freq",names(extract_Data))
colnames(extract_Data)<-descriptive_names

# group
mydataset<-group_by(extract_Data,idvolunteer,activity)%>%
  summarise_all(mean)%>%
  print()
#clean workspace
rm(activity_labels,features,ID,IDactivity,IDvolunteer,mydata,subject_test,subject_train,X_test,X_train,Y_test,Y_train,names,descriptive_names,valid_column_names, extract_Data)
 
