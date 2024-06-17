#http://archive.ics.uci.edu/ml/datasets/Spambase

#install.packages("kernlab")
library(kernlab)
data(spam)

str(spam)
dim(spam)
table(spam$type)



#create data set of 4601 random indexes utilizing sample function


#create 2/3 cut point, train on 2/3 test on 1/3

#create traindata and test data

randIndex <- sample(1:dim(spam)[1])
summary(randIndex)
length(randIndex)
#look at first few cases
head(randIndex)

#create 2/3 cut point
cutPoint2_3 <- floor(2* dim(spam)[1]/3)
#verify cut point
cutPoint2_3

#create training dataset
trainData <- spam[randIndex[1:cutPoint2_3],]

#create test data set
testData <- spam[randIndex[(cutPoint2_3+1):dim(spam)[1]],]


trainData

testData


svmOutPut <-ksvm(type~., data=trainData, kernel="rbfdot",kpar="automatic",C=5, cross=3,prob.model=TRUE)

svmOutPut

svmPred <- predict(svmOutPut, testData, type="votes")
compTable <- data.frame(testData[,58], svmPred[1,])
table(compTable)