rm(list=ls(all=T))
corolla = read.csv("Toyota.csv",header = T)
library(outliers)
y=outlier(corolla$Price)
which(corolla$Price == y)

rm.outlier(corolla$Price)
names(corolla)
#corolla1 = subset(corolla,select = c("Price","Age_06_15","Fuel_Type","KM","HP","Met_Color","Automatic","cc","Doors","Quaterly_Tax","Weight"))
corolla1 = corolla[,c(3,4,8,7,9,10,12,13,14,17,18)]
names(corolla1)
cor(corolla1[,-c(1,3)])
plot(corolla1[,-c(1,3)])
# divide data int train and test data
set.seed(123)
rows=seq(1,nrow(corolla1),1)
trainRows=sample(rows,(70*nrow(corolla1))/100)
train = corolla1[trainRows,]
test = corolla1[-trainRows,]

lmmodel = lm("Price ~.",data = train)
summary(lmmodel)

# intercept is expected mean value of Y when all X=0
# http://stats.stackexchange.com/questions/5135/interpretation-of-rs-lm-output
library(DMwR)
regr.eval(corolla1$Price,fitted(lmmodel),train.y = train)

