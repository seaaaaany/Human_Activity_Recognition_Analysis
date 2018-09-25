<p align="center"><img width=12.5% src="https://github.com/anfederico/Clairvoyant/blob/master/media/Logo.png?raw=true"></p>

# Human Activity Recognition Analysis  ![built with R](https://img.shields.io/badge/built%20with-R-blue.svg)

### Background

Using devices such as *Jawbone Up*, *Nike FuelBand*, and *Fitbit* it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how *much* of a particular activity they do, but they rarely quantify *how well they do it*. In this project, your goal will be to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the website here:<http://web.archive.org/web/20161224072740/http:/groupware.les.inf.puc-rio.br/har> (see the section on the Weight Lifting Exercise Dataset).



##### Dataset

Click here to download the [Training data](<https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv>) and [Test Data](<https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv>).

---



### Requirements

> Here are the R packages I've selected for this project.

```R
library(caret)
library(randomForest)
library(rpart)
library(rpart.plot)
```

---



### R Script

> You can find the entire code for this project below.

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

---



### Results

![result](https://github.com/yycyjqc/Human_Activity_Recognition_Analysis/blob/master/img/Rplot01.png?raw=true)

![decision_tree](https://github.com/yycyjqc/Human_Activity_Recognition_Analysis/blob/master/img/Rplot02.jpeg?raw=true)

You can always find the decision tree [here](https://github.com/yycyjqc/Human_Activity_Recognition_Analysis/blob/master/img/Rplot02.jpeg).



