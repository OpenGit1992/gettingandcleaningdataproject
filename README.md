# Getting and Cleaning Data - Course Project

This code is for the course project of the Getting and Cleaning Data Coursera course. Running the R script, run_analysis.R, will execute the following functions:

1. Creates a new directory "Project3" if there is no directory named such before downloading the zip file into this directory.
2. Unzips the file and saves the contents into the newly created directory.
3. Reads the test and train files into tables before combining the data into a single data frame (data_full), which also contains two columns named SUbject and Acitivity.
4. Reads the features file, getting only the columns that contain mean and std, before creating a subset of data_full (updating the data_full data frame itself) which contains those columns, as well as the Subject and Activity columns.
5. Reads the activity file before updating the Activity column of data_full with the values taken from the activity file.
6. Creates a dataset containing average of each variable for each subject and activity pair.