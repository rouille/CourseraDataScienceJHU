library(data.table)

fileName <- "data.zip"
dirName <- "UCI HAR Dataset"

# Download the file if necessary
if( !file.exists(fileName) ) {
    FileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(FileURL, fileName, method = "curl")
}

# Decompress the file if necessary
if( !dir.exists(dirName) ) unzip(fileName)

# Get activity labels as well as the list of features
activities <- fread(paste0(dirName, "/activity_labels.txt"), col.names = c("label", "name"))
features <- fread(paste0(dirName, "/features.txt"), col.names = c("id", "name"))

# Select the relevant features
selectedFeatures <- features[grep("*.mean.*|*.std.*", features$name),]

# Rename the selected features
selectedFeatures$name <- gsub("-mean", "Mean", selectedFeatures$name)
selectedFeatures$name <- gsub("-std", "Std", selectedFeatures$name)
selectedFeatures$name <- gsub("[()-]", "", selectedFeatures$name)

# Read the test data sets
test <- fread(paste0(dirName, "/test/X_test.txt"), select = selectedFeatures$id, col.names = selectedFeatures$name)
testActivities <- fread(paste0(dirName, "/test/y_test.txt"), col.names = "activity")
testSubjects <- fread(paste0(dirName, "/test/subject_test.txt"), col.names = "subject")

# Read the train datasets
train <- fread(paste0(dirName, "/train/X_train.txt"), select = selectedFeatures$id, col.names = selectedFeatures$name)
trainActivities <- fread(paste0(dirName, "/train/y_train.txt"), col.names = "activity")
trainSubjects <- fread(paste0(dirName, "/train/subject_train.txt"), col.names = "subject")

# Combine data sets
data <- rbind(cbind(testSubjects, testActivities, test), cbind(trainSubjects, trainActivities, train))

# Use descriptive activity names
data$activity <- factor(data$activity, levels = activities$label, labels = activities$name)

# Reshape the dataset: wide to long
data.melted <- melt(data, id.vars = c("subject", "activity"), variable.name = "feature")

# Compute the average of each feature for each subject and each activity
data.mean <- dcast(data.melted, subject + activity ~ feature, mean)

# Write the dataset in a file
write.table(data.mean, "tidy_dataset.txt", row.names = FALSE, quote = FALSE)
