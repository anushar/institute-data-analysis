setwd("C://Users//bharath//Desktop//insofe//R code")
toyota=read.csv("Toyota.csv")
summary(toyota)
summary(toyota$Model)
toyota1=toyota[,-(38:51)]
model1=lm(toyota$Price~ toyota$Mfg_Year + toyota$Fuel_Type ,data = toyota)
summary(model1)
model2 = lm(toyota1$Price ~.-toyota1$Id,data = toyota1)
summary(model2)
model3 =lm(Price ~ Age_06_15,data = toyota1)
summary(model3)
plot(toyota1$Price,toyota1$Age_06_15)
cor(toyota1$Price,toyota1$Age_06_15)
coefficients(model3)
#age_scaled = scale(toyota1$Age_06_15)
#age_scaled[which(toyota1$Age_06_15 == 66)]
as.numeric(coefficients(model3)[1]+coefficients(model3)[2]* 4.5)
testdata = data.frame('Age_06_15' =4.5)
testdata
predict(model3, testdata)
predict(model3, testdata, interval="confidence",level=0.95)
summary(model3)
Pred=data.frame(predict(model3, toyota1, interval="confidence" ,level=0.95))
plot(toyota1$Age_06_15, toyota1$Price,xlim=c(30,120),ylim = c(5000,30000))
points(toyota1$Age_06_15,Pred$fit,type="l", col="red", lwd=2)
points(toyota1$Age_06_15,Pred$lwr,pch="-", col="blue", lwd=6)
points(toyota1$Age_06_15,Pred$upr,pch="-", col="blue", lwd=6)

# residual plot of model
par(mfrow=c(2,2))
plot(model3)
#splitting data into test and train
rows=seq(1,nrow(toyota1),1)
set.seed(123)
trainRows=sample(rows,(70*nrow(toyota1))/100)
train = toyota1[trainRows,]
test = toyota1[-trainRows,]
library(DMwR)
regr.eval(train$Price, model3$fitted.values)
Pred<-predict(model3,test)
regr.eval(test$Price, Pred)

library(MASS)
model4 = stepAIC(model2,direction = "both",trace = FALSE)
summary(model4)
############################################################################
#####   ACTIVITY-2 #########################
###########################################
promot = read.csv("promotion.csv",header = TRUE)

lmmodel = lm(Market.Share ~ Detail.Voice,data = promot)
summary(lmmodel)
