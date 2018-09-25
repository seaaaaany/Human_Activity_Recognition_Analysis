<img src="https://banner2.kisspng.com/20171209/74b/creative-letter-r-5a2c1bf5842364.1146196815128401815412.jpg" align="right" style="width:150px;height:130px;"/>

# Human Activity Recognition Analysis

![built with R](https://img.shields.io/badge/built%20with-R-blue.svg) 







```R
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)
```



```R
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

model1 <- rpart(classe ~ ., data=subTraining, method="class")

# Predicting
prediction1 <- predict(model1, subTesting, type = "class")

# Plot of the Decision Tree
rpart.plot(model1, main="Classification Tree", extra=102, under=TRUE, faclen=0)

# Test results on our subTesting data set
confusionMatrix(prediction1, subTesting$classe)

model2 <- randomForest(classe ~. , data=subTraining, method="class")

# Predicting
prediction2 <- predict(model2, subTesting, type = "class")

# Test results on subTesting data set
confusionMatrix(prediction2, subTesting$classe)

# predict outcome levels on the original Testing data set using Random Forest algorithm
predictfinal <- predict(model2, testingset, type="class")
predictfinal
```



