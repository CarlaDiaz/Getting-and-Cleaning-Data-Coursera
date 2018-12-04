###################################################################################################
########################################### READING DATA ##########################################
###################################################################################################

train<- read.table("train/X_train.txt")
View(train)
dim(train) # 7352 subjects, 561 variables

train_labels<- read.table("train/y_train.txt")
dim(train_labels) # 7352    1
colnames(train_labels) <- "activity"

train <- cbind(train_labels, train)
rm(train_labels) # We don't need it any more

test <- read.table("test/X_test.txt")
View(test)
dim(test) # 2947 subjects, 561 variables

test_labels<- read.table("test/y_test.txt")
dim(test_labels) # 2947    1
colnames(test_labels) <- "activity"

test <- cbind(test_labels, test)
rm(test_labels) # We don't need it any more

activities <- read.table("activity_labels.txt") # Labels for the activities
names <- read.table("features.txt")

### names is a data.frame which second column includes the names of the variables in train and 
### test. The first column in the position or the number of the column

###################################################################################################
#################################### OBTAINING A TIDY DATA SET ####################################
###################################################################################################

### Merging both data sets in one
complete <- rbind(train, test)

rm(train)
rm(test) # We don't need them anymore

### We are only interested in extracting the measurements on the mean and standard deviation for
### each measurement. To do that, we just have to look into the names of the variables to know
### which ones to pick

index <- grep("mean\\(", names[, 2]) # measurements on the mean 
index <- sort(c(index, grep("std\\(", names[, 2]))) # measurements on the mean and the standard 
# deviation ordered as originally

complete <- complete[, c(1, index + 1)] # We take only the measurements on the mean and the 
# standard deviation. As we have introduced the variable "activity" in the first column, we need
# to add 1 to all indexes to take the correct ones, and also take the first to mantein "activity"
# in the data set
dim(complete) # 10299 observations, 67 variables

names <- names[index, ] # We just take the corresponding names to the variables we have left

rm(index) # We don't need it anymore
### Using descriptive activity names to name the activities in the data set
### The names provided are already descriptive. We have to substitute the values for their labels
### in the data set
n <- dim(activities)[1]
for(i in 1:n){
  complete$activity <- sub(i, activities[i, 2], complete$activity)
}
rm(i)
rm(n) 
rm(activities) # We don't need them anymore

complete$activity <- factor(complete$activity) # We transform the variable into a factor

### Appropriately labeling the data set with descriptive variable names.
names[, 2] <- tolower(names[, 2]) # Removing Capital letters
names[, 2] <- sub("^t", "time", names[, 2]) # Explaining that the "t" stands for time
names[, 2] <- sub("acc", "acceleration", names[, 2]) # "acc" stands for acceleration
names[, 2] <- gsub("-", "", names[, 2]) # Removing "-"
names[, 2] <- gsub("\\(\\)", "", names[, 2]) # Removing "()"
names[, 2] <- sub("gyro", "angular", names[, 2]) # "gyro" stands for angular velocity
names[, 2] <- sub("^f", "fourier", names[, 2]) # Explaining that the "f" for Fast Fourier Transform
names[, 2] <- sub("bodybody", "body", names[, 2]) # Removing the repeated "body"

# Jerk to the beginnig of the name
index <- grep("jerk", names[, 2]) # Jerk signal derived from the measurement
names[, 2] <- sub("jerk", "", names[, 2])
names[index, 2] <- paste0("jerk", names[index, 2])

# magnitude to the beginnig of the name
index <- grep("mag", names[, 2]) # magnitude of the measurement
names[, 2] <- sub("mag", "", names[, 2])
names[index, 2] <- paste0("magnitude", names[index, 2])

# mean to the beginnig of the name
index <- grep("mean", names[, 2]) # mean of the measurements
names[, 2] <- sub("mean", "", names[, 2])
names[index, 2] <- paste0("mean", names[index, 2])

# std to the beginnig of the name
index <- grep("std", names[, 2]) # std of the measurements
names[, 2] <- sub("std", "", names[, 2])
names[index, 2] <- paste0("std", names[index, 2])

rm(index) # We don't need this anymore

### Once done this, the variable names are descriptive, even thougth they are very long. For 
### instance, "meanmagnitudejerkfourierbodyacceleration" stands for "mean of the magnitude of the 
### Jerk signal derived from the Fast Fourier Transformation of the body acceleration". 
### Another example is "stdtimebodyangulary", which stands for "standard deviation of the time of
### body angular velocity, y coordinate"

### Renaming the variables in the data set
names(complete)[-1] <- names[, 2] # We use names(complete)[-1] because the first variable already
### has an explanatory name which is not included in names ("activity")

rm(names) # We don't need this anymore

###################################################################################################
##################################### SAVING THE TIDY DATA SET ####################################
###################################################################################################

write.table(complete, "tidy_dataset.txt", row.names = F)
