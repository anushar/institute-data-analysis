fluTrain = read.csv("FluTrain.csv", header = T)
summary(fluTrain)
fluTrain$Week[which.max(fluTrain$ILI)]
fluTrain$Week[which.max(fluTrain$Queries)]
hist(fluTrain$ILI)
plot(log(fluTrain$ILI),fluTrain$Queries)

fluTrend1 =lm(log(fluTrain$ILI) ~ fluTrain$Queries , data = fluTrain)
summary(fluTrend1)
v=cor(log(fluTrain$ILI),fluTrain$Queries)
v^2

fluTest = read.csv("FluTest.csv",header = T)
PredTest1 = exp(predict(fluTrend1, newdata=fluTest))
which(fluTest$Week == "2012-03-11 - 2012-03-17")
fluTest$Week
PredTest1[11]=2.187383
ppr = (fluTest$ILI[11]- PredTest1[11])/fluTest$ILI[11]
nrow(fluTest$ILI)
sse = sum((PredTest1 - fluTest$ILI)^2)


install.packages("zoo")
library(zoo)
ILILag2 = lag(zoo(fluTrain$ILI), -2, na.pad=TRUE)
fluTrain$ILILag2 = coredata(ILILag2)
summary(fluTrain)
plot(log(ILILag2),log(fluTrain$ILI))

fluTrend2 = lm(log(fluTrain$ILI) ~ fluTrain$Queries + log(fluTrain$ILILag2))
summary(fluTrend2)

ILILagg =lag(zoo(fluTest$ILI),-2,na.pad = TRUE)
fluTest$ILILag2 = coredata(ILILagg)
summary(fluTest)

nrow(fluTrain)
fluTest$ILILag2[1] = fluTrain$ILILag2[416] = 1.852736
fluTest$ILILag2[2] = fluTrain$ILILag2[417] = 2.12413

predict2 = exp(predict(fluTrend2, newdata = fluTest))
