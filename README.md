# getting-and-cleaning-data
Peer-graded Assignment: Getting and Cleaning Data Course Project
This repo contains:
- a script I wrote to get and clean data for the Peer-graded asignment of the Getting and Cleaning Data Course Project.
- a codebook
- a tidy dataset

To create the script I took the following steps:
- collect the given data
- read readme file and examined all files
- import and unzipp the necessary datafiles in R
- inspect all data files to `find the class and sizes, so I could figure out how to construct one dataset
- creat one dataset
- assign descriptive variable names and made sure all columnames were valid
- select collums with mean and std
- make a column with activitynames in stead of numbers
- make columnnames more descriptive by adding the description time en freq where necesarry and removing all capitals
- make groups on subject and activity and sumarise on the mean of each measurement
- clean the workspace
