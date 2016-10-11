data = read.csv("CustomerData.csv",header = TRUE)
#data_churn = read.csv("ChurnedInfo.csv",header = TRUE)

# do left outer join on both data sets
#data = merge(x= data,y= data_churn, by = "CustomerID",all = TRUE)

data = data[,-which(names(data) == "CustomerID")]
## or data[,-which(names(data) %in% c("CustomerID"))] or subset(data,select =-c("CustomerID"))
# data[,c("names you want to have")]
colnames(data)
data$City = as.factor(data$City)
data$Churned = as.factor(data$Churned)
#summary(data)

# divide data int train and test data
set.seed(123)
rows=seq(1,nrow(data),1)
trainRows=sample(rows,(70*nrow(data))/100)
train = data[trainRows,]
test = data[-trainRows,]

#apply logistic regression on entire data set
logreg = glm(Churned ~ .,data = data, family = binomial())
summary(logreg)

# make prediction on train and test data
trainreg = glm(Churned ~ .,data = data,family = binomial())
prob = predict(trainreg,newdata=train,type = "response")
#summary(prob) #all values hsould be +ve
pred_class = factor(ifelse(prob >0.5,1,0))


table(train$Churned,pred_class)

# on test data
prob_tst = predict(trainreg,newdata=test,type = "response")
summary(pred_tst)
pred_tst = factor(ifelse(prob_tst >0.5,1,0))
#test$Churned = as.factor(test$Churned)
table(test$Churned,pred_tst)

#install.packages("caret")
library("caret")
conf.train = confusionMatrix(table(train$Churned,pred_class))
# confidence interval accuracy = TP+TN/total
# sensitivity/recall precision = TP/TP+FN
# specificity = TN/FP+TN
# false positive rate = 1- specificity
# ROC curve is sentivity vs false positive rate gives area under curve(AUC)
