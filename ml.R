library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)

set.seed(12345)
# Loading the training data set
# Replace all missing data with "NA"
trainingset <- read.csv("pml-training.csv", na.strings=c("NA","#DIV/0!", ""))
# Loading the testing data set 
testingset <- read.csv('pml-testing.csv', na.strings=c("NA","#DIV/0!", ""))

# Delete columns with missing values
trainingset<-trainingset[,colSums(is.na(trainingset)) == 0]
testingset <-testingset[,colSums(is.na(testingset)) == 0]

# Delete irrelevant variables.
trainingset   <-trainingset[,-c(1:7)]
testingset <-testingset[,-c(1:7)]

# Crate new data set
dim(trainingset)
dim(testingset)
head(trainingset)
head(testingset)

subsamples <- createDataPartition(y=trainingset$classe, p=0.75, list=FALSE)
subTraining <- trainingset[subsamples, ] 
subTesting <- trainingset[-subsamples, ]
dim(subTraining)
dim(subTesting)
head(subTraining)
head(subTesting)

# plot the results
plot(subTraining$classe, col="cadetblue2", main="The subTraining data set", xlab="classe levels", ylab="Frequency")