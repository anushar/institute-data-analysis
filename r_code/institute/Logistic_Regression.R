rm(list=ls(all=TRUE))
setwd("C:\\Users\\bharath\\Desktop\\insofe\\R code")
cust_data = read.csv("CustomerData.csv",header=T)
names(cust_data)
cdata = cust_data[,c(-1)]
cdata$Churned <- as.factor(cdata$Churned)

summary(cdata)

#Split the data into train and test data sets
rows=seq(1,nrow(cdata),1)
set.seed(123)
trainRows=sample(rows,(70*nrow(cdata))/100)
train = cdata[trainRows,]
test = cdata[-trainRows,]
nrow(test)

summary(train)
#attach(cdata)
lr = glm(Churned~., data=train,family=binomial)
summary(lr)

pred.train <- predict(lr,newdata=train,type="response")
summary(pred.train)
pred.test <- predict(lr,newdata=test,type="response")
summary(pred.test)

train.classpred <- ifelse(pred.train>0.5,1,0)
test.classpred <- ifelse(pred.test>0.5,1,0)

install.packages("caret")
library(caret)
install.packages("e1071")
conf.train <- confusionMatrix(table(train$Churned,train.classpred))
conf.test <- confusionMatrix(table(test$Churned,test.classpred))
#print(conf.test)
#print(conf.train)
length(test.classpred)



install.packages("ROCR")
library(ROCR)

# to make an ROC curve one needs actual values and predicted values, both are given below.
# These functions will do the groupings on their own (p > 0.2, etc.) like we were doing above
# we need ROC curve to find out threshold value to segregate y probabilities as done in 28 and 29 lines
# use value from ROC curve instead of 0.5 to maximise the accuracy of model.
ROCRpred = prediction(pred.train, train$Churned)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")

# Plot ROC curve
plot(ROCRperf)

# Add colors
plot(ROCRperf, colorize=TRUE)

# Add threshold labels 
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))
