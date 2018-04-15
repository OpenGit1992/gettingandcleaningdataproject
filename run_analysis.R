##Create new directory if necessary before downloading and unzipping file.
if(!file.exists("./Project3")){dir.create("./Project3")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Project3/UCIHARDataset.zip")
unzip(zipfile = "./Project3/UCIHARDataset.zip", exdir = "./Project3")
pathProj <- file.path("./Project3", "UCI HAR Dataset")

##Read test, train, subject, and features files and combine data into a single data frame named data_full
train_x <- read.table(file.path(pathProj, "train", "X_train.txt"),header = FALSE)
train_y <- read.table(file.path(pathProj, "train", "Y_train.txt"),header = FALSE)
train_sub <- read.table(file.path(pathProj, "train", "subject_train.txt"),header = FALSE)
test_x <- read.table(file.path(pathProj, "test", "X_test.txt"),header = FALSE)
test_y <- read.table(file.path(pathProj, "test", "Y_test.txt"),header = FALSE)
test_sub <- read.table(file.path(pathProj, "test", "subject_test.txt"),header = FALSE)
data_y <- rbind(train_y, test_y)
data_x <- rbind(train_x, test_x)
data_sub <- rbind(train_sub, test_sub)
featuresNames <- read.table(file.path(pathProj, "features.txt"),header = FALSE)
data_y <- rbind(train_y, test_y)
data_sub <- rbind(train_sub, test_sub)
data_x <- rbind(train_x, test_x)
names(data_sub) <- c("Subject")
names(data_y) <- c("Activity")
names(data_x) <- featuresNames$V2
data_combine <- cbind(data_sub, data_y)
data_full <- cbind(data_x, data_combine)

#Select only the features with mean and std before creating a subset of data_full with those values.
featuresWanted <- grep("(mean|std)\\(\\)", featuresNames$V2)
featuresWanted <- grep("(mean|std)\\(\\)", featuresNames$V2, value = TRUE)
subFeaturesNames <- featuresNames$V2[grep("mean\\(\\)|std\\(\\)", featuresNames$V2)]
wantedFeatures <- c(as.character(subFeaturesNames), "Subject", "Activity")
data_full <- subset(data_full, select = wantedFeatures)

#Read data from activity_labels file and update the values of the Activity column of the using the acitivity_labels data.
library(data.table)
activityName <- fread(file.path(pathProj, "activity_labels.txt"),col.names = c("Class Labels", "Activity Name"))
data_full[["Activity"]] <- factor(data_full[, "Activity"], levels = activityName[["Class Labels"]], labels = activityName[["Activity Name"]])

#Create a new dataset and save data as a text file named TidyData.txt
data_full2 <- aggregate(. ~Subject + Activity, data_full, mean)
data_full2<-data_full2[order(data_full2$Subject, data_full2$Activity),]
write.table(data_full2, file = "TidyData.txt", row.name = FALSE)
