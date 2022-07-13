library(dplyr)
library(reshape2)

getwd()

##reading the given files and short examination

features <- read.table("./data/features.txt") 
head(features)
dim(features)

activity <- read.table("./data/activity_labels.txt")
head(features)
dim(features)


train.sub <- read.table("./data/train/subject_train.txt")
head(features)
dim(features)

train.x <- read.table("./data/train/X_train.txt")
head(features)
dim(features)

train.y <- read.table("./data/train/y_train.txt")
summarise(features)
head(features)
dim(features)


test.sub <- read.table("./data/test/subject_test.txt")
head(features)
dim(features)

test.x <- read.table("./data/test/X_test.txt")
head(features)
dim(features)

test.y <- read.table("./data/test/y_test.txt")
head(features)
dim(features)


##merging the sets
colnames (train.x) <- as.character(features$V2)
train <- cbind(train.y, train.sub, train.x)


colnames (test.x) <- as.character(features$V2)
test <- cbind(test.y, test.sub, test.x)

data.complete <- rbind(train, test)


##mean and standard deviation extraction
sd_cols <- grep("sd", colnames(data.complete))
mean_cols <- grep("mean", colnames(data.complete), ignore.case=TRUE)

data.plus <- data.complete[,c(1,2,sd_cols,mean_cols)]


##the big merge
data.merge <- (merge(activity, data.plus, by.x = "V1", all = TRUE))[,-1]


##labeling
data.labeled <- transform(data.merge, outcome = factor(outcome, 
                          levels=c(1,2,3,4,5,6),labels = activity$V2))


##final tidy data set with the average of each variable for each activity+subject
run_analysis <- dcast(data.merge, mean)

write.table(run_analysis)
