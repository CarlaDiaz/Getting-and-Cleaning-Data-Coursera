Tidying up data sets with data of Human Activity Recognition Using Smartphones Dataset
======================================================================================

The purpose of this project is to demonstrate students' ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

The following files are provided:
=================================

- 'README.md'

- 'tidy_dataset.txt': Tidy data set, the objective of this project

- 'CodeBook.md': Shows information about the variables of the tidy data set.

- 'run_analysis.R': R script which used to obtain "tidy_dataset.txt" from the data given.


"run_analysis.R"
================
 
 Provided that the Samsung data is in the user's working directory, the script goes like this:
 
 
### READING DATA:

#### The first step is reading all the files corresponding to the data set ("X_train.txt", "y_train.txt", "X_test.txt", "y_test.txt", "activity_labels.txt" and "features.txt").

train<- read.table("train/X_train.txt");
View(train);
dim(train) # 7352 subjects, 561 variables

train_labels<- read.table("train/y_train.txt");
dim(train_labels) # 7352    1

colnames(train_labels) <- "activity"

train <- cbind(train_labels, train);
rm(train_labels) # We don't need it any more

test <- read.table("test/X_test.txt");
View(test);
dim(test) # 2947 subjects, 561 variables

test_labels<- read.table("test/y_test.txt");
dim(test_labels) # 2947    1

colnames(test_labels) <- "activity"

test <- cbind(test_labels, test);
rm(test_labels) # We don't need it any more

#### We have already merge "X_train.txt" with "y_train.txt" and "X_test.txt", with "y_test.txt". In both cases, the variable for activity (y) was introduced in the big data set as the variable "activity".

activities <- read.table("activity_labels.txt") # Labels for the activities

names <- read.table("features.txt")

#### Here, names is a data.frame which second column includes the names of the variables in train and test. The first column in the position or the number of the column.

### OBTAINING A TIDY DATA SET 

#### To do that, we need to merg the two main data sets (train and test) in one, which we will call "complete". They have the same variables but for different subjects, so it is easy to do with the "rbind" command.

complete <- rbind(train, test)

rm(train);
rm(test) # We don't need them anymore

#### We are only interested in extracting only the measurements on the mean and standard deviation for each measurement. To do that, we just have to look into the names of the variables ("name" data set) to know which ones to pick.

index <- grep("mean\\(", names[, 2]) # measurements on the mean 

index <- sort(c(index, grep("std\\(", names[, 2]))) # measurements on the mean and the standard deviation ordered as originally

#### We take only the measurements on the mean and the standard deviation. As we have introduced the variable "activity" in the first column, we need to add 1 to all indexes to take the correct ones, and also take the first to mantein "activity" in the data set. 

complete <- complete[, c(1, index + 1)];
dim(complete) # 10299 observations, 67 variables

#### Now, we just take the corresponding names to the variables we have left.

names <- names[index, ] 

rm(index) # We don't need it anymore

#### After that, we will focus on the variable "activity". It is indicated by numbers from 1 to 6, so que want to have descriptive activity names instead. The names provided by the variable "activities" are already descriptive. We have to substitute the numeric values for their corresponding labels in the data set

n <- dim(activities)[1] # 6

for(i in 1:n){

  complete\$activity <- sub(i, activities[i, 2], complete\$activity)
  
}

rm(i);
rm(n);
rm(activities) # We don't need them anymore

#### We transform the variable into a factor

complete\$activity <- factor(complete\$activity) 

#### The last step before saving our tidy data set is appropriately labeling the data set with descriptive variable names. The current names of the variables are in the data set "name".

#### Removing Capital letters.

names[, 2] <- tolower(names[, 2]) 

#### Explaining that the "t" stands for time

names[, 2] <- sub("^t", "time", names[, 2]) 

#### "acc" stands for acceleration
names[, 2] <- sub("acc", "acceleration", names[, 2]) 

#### Removing "-" and "()"
names[, 2] <- gsub("-", "", names[, 2]) 

names[, 2] <- gsub("\\(\\)", "", names[, 2]) 

#### "gyro" stands for angular velocity

names[, 2] <- sub("gyro", "angular", names[, 2]) 

#### Explaining that the "f" for Fast Fourier Transform

names[, 2] <- sub("^f", "fourier", names[, 2]) 

#### Removing the repeated "body"
names[, 2] <- sub("bodybody", "body", names[, 2]) 

#### Now we are inverting the order of appearance of "Jerk", "mag" and "mean" or "std" and placing them in the beginnig of the name. We also change "mag" for "magnitude"

#### Jerk

index <- grep("jerk", names[, 2]) # Jerk signal derived from the measurement

names[, 2] <- sub("jerk", "", names[, 2])

names[index, 2] <- paste0("jerk", names[index, 2])

#### magnitude 

index <- grep("mag", names[, 2]) # magnitude of the measurement

names[, 2] <- sub("mag", "", names[, 2])

names[index, 2] <- paste0("magnitude", names[index, 2])

#### mean

index <- grep("mean", names[, 2]) # mean of the measurements

names[, 2] <- sub("mean", "", names[, 2])

names[index, 2] <- paste0("mean", names[index, 2])

#### std 

index <- grep("std", names[, 2]) # std of the measurements

names[, 2] <- sub("std", "", names[, 2])

names[index, 2] <- paste0("std", names[index, 2])

rm(index) # We don't need this anymore

#### Once changed, the variable names are descriptive, even thougth they are very long. For instance,

1."meanmagnitudejerkfourierbodyacceleration" stands for "mean of the magnitude of the Jerk signal derived from the Fast Fourier Transformation of the body acceleration". 

2."stdtimebodyangulary", which stands for "standard deviation of the time of body angular velocity, y coordinate".

#### At this point, we have to rename the variables in the data set. We use names(complete)[-1] because the first variable already has an explanatory name which is not included in names ("activity")

names(complete)[-1] <- names[, 2]  

rm(names) # We don't need this anymore

### SAVING THE TIDY DATA SET 

#### The final step is to save our tidy data set to an .txt file, which we will call "tidy_dataset.txt"

write.table(complete, "tidy_dataset.txt", row.names = F)