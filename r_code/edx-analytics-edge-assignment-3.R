rm(list=ls(all=T))
song = read.csv("songs.csv",header = T)
str(song)
summary(song)
table(song$year)
table(song$artistname == "Michael Jackson",song$Top10)
mich = subset(song,song$artistname == "Michael Jackson")
summary(mich)
mich = subset(mich,mich$Top10 == 1)
mich$songtitle
table(song$timesignature)
song[which(song$tempo == max(song$tempo)),]

# splitting data into test and train based on year
songstest = song[which(song$year == 2010),]
songstrain = song[which(song$year != 2010),]

# removing column names from data set
nonvars = c("year","songtitle","artistname","songID","artistID")
songstrain = songstrain[,!names(songstrain) %in% nonvars]
songstest = songstest[,!names(songstest) %in% nonvars]

# building logistic regression model
model1 = glm('Top10 ~.',data = songstrain,family = "binomial")
summary(model1)

# correlation of variables
cor(songstrain$loudness,songstrain$energy)

# removing one of the corellated variables from the model
# subtracting variabled from the formula only works for numeric values but not categorical
# like airtistID etc
model2 = glm('Top10 ~ .-loudness',data = songstrain,family = "binomial")
model3 = glm('Top10 ~ .-energy',data = songstrain,family = "binomial")

summary(model2)
summary(model3)

# validating the model3 on test set
testpredict = predict(model3,newdata = songstest,type = "response")
table(songstest$Top10,testpredict > 0.45)

# accuracy = 
(19+309)/(19+309+5+40)

# baseline accuracy take ony zero values
(309+5)/(309+5+40+19)
#or
table(songstest$Top10)
# baseline accuracy = 314/314+59

#sensitivity
19/(19+40)
# specificity
(309/(309+314))

### part-2 ###################################################
paro = read.csv("parole.csv",header = T)
table(paro$violator)
summary(paro)
paro$state = as.factor(paro$state)
paro$crime = as.factor(paro$crime)

set.seed(144)
library(caTools)
split = sample.split(paro$violator,SplitRatio = 0.7)
partrain = subset(paro,split == TRUE)
partest = subset(paro,split == FALSE)

model4 = glm("violator ~.",data = partrain,family = "binomial")
summary(model4)

s1 = data.frame(male=1,race=1,age=50,state=1,time.served=3,max.sentence=12,multiple.offenses=0,crime=2,violator=1)
s1$state = as.factor(s1$state)
s1$crime = as.factor(s1$crime)
s1p = predict(model4,newdata = s1,type = "response")
# for odds
exp(s1p)

# predict on test set
ptest = predict(model4,newdata = partest,type = "response")
max(ptest)
table(partest$violator,ptest > 0.5)
#library("caret")
#conf.train = confusionMatrix(table(partest$violator,ptest > 0.5))
#accuracy
(167+12)/(167+12+12+11)
#sensitiviy
(12)/(12+11)
# specificity
167/(167+12)
# base acuuracy 
table(partest$violator)
(179)/(179+23)

library(ROCR)
# order of arguments changes the value, have a lokkk
ropred = prediction(ptest,partest$violator)
as.numeric(performance(ropred,"auc")@y.values)


#### part3 #####################################
loa = read.csv("loans.csv",header = T)
summary(loa)
table(loa$not.fully.paid)
# proportion
1533/(1533+8045)
library(mice)
set.seed(144)
vars.for.imputation = setdiff(names(loa), "not.fully.paid")
imputed = complete(mice(loa[vars.for.imputation]))
loa[vars.for.imputation] = imputed

set.seed(144)
library(caTools)
split = sample.split(loa$not.fully.paid,SplitRatio = 0.7)
loatrain = subset(loa,split == TRUE)
loatest = subset(loa,split == FALSE)

model5 = glm('not.fully.paid ~ .',data = loatrain,family = "binomial")
summary(model5)

predicted.risk = predict(model5,newdata = loatest,type = "response")
table(loatest$not.fully.paid,predicted.risk > 0.5)
#accuracy
2403/(2403+13+457)

# baseline
table(loatest$not.fully.paid)
2413/(2413+460)
