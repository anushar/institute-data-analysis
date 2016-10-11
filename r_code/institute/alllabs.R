# chi square
tb =matrix(c(200,150,50,250,300,50),c(2,3),byrow = T)
chisq.test(tb)

mean(c(643,655,702,469,427,525,484,456,402))

# anova
data <- data.frame(scores = c(643,655,702,469,427,525,484,456,402),method = factor(rep(c("M1","M2","M3"),c(3,3,3))))
model= aov(scores~method,data=data)
summary(model)

data <- data.frame(scores = c(86,79,81,70,84,90,76,88,82,89,82,68,73,71,81),method = factor(rep(c("A1","A2","A3"),c(5,5,5))))
model= aov(scores~method,data=data)
summary(model)

### t test
reg = c(16, 20, 21, 22, 23, 22, 27, 25, 27, 28)
prem = c(19, 22, 24, 24, 25, 25, 26, 26, 28, 32)
t.test(reg,prem,paired = T)

## splitting data into test and train data sets,
################ only use this when dependent variable is categorical ##########
#install.packages("caTools")
library(caTools)
set.seed(88)
data-split = sample.split(data,SplitRatio = 0.70)
data_train = subset(data,data-split == TRUE)
data_test = subset(data,data-split == FALSE)
