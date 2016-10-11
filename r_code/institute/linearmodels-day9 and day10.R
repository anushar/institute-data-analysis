### my learning 
# 1. Compute the coefficients from a sample data manually
# 2 . Understand the siginficance of categorical attributes
# 3. logistic regression need to shown as a plot (s shaped plot)
# 4. deriving the logistic regrssion from the regression data itself

# library(Deducer)
# JGR()
# 
form <- paste('Price ~',paste(names(car.test.frame)[-4],collapse="+"))
# form <- paste('Price ~',paste(names(car.test.frame),collapse="+"))
rm(list=ls(all=T))

library(rpart)
?car.test.frame
attach(car.test.frame)
summary(car.test.frame)
names(car.test.frame)
#plot(scale(Weight),scale(Price),xlim = c(-3,2),ylim = c(-2,3))
plot(Weight,Price)
cor(Weight,Price)
cor(Weight,Price)^2
model1 <- lm(Price~Weight)
summary(model1)
model2 <- lm(Price~.,data = car.test.frame)#data=nomissing)
summary(model2)
model2
### need to understand the standard error(is nothing but standard deviation) and how it is calculated
### understand the 1 one in the intercept

abline(-4147.042,5.779) #how did these numbers come?
model2 = lm(Price~Weight+Mileage)
summary(model2)

model.final = lm(Price~., data=car.test.frame)
result        <- predict(model.final,data=car.test.frame)
predict.value <- predict(model.final,data=car.test.frame)
test <- car.test.frame[1:10,]
library(DMwR)
regr.eval(test[,"Price"], predict.value, train.y = car.test.frame[,"Price"])
length(car.test.frame[,"Price"])
length(predict.value)
head(predict.value)
#write.csv(car.test.frame,"D:/INSOFE/ESIC/cars.csv",row.names=F)

### Look at the coefficeints for Weight and milege
### Larger the coefficient means need not be significant
### Look at the standard error , the less the error the better is the model

model2 = lm(Price~Weight+Mileage)
plot(Weight,Mileage)
cor(Price,Mileage)
cor(Price,Weight)

summary(model2)
summary(model1)

### 
model3 = lm(Price~Weight)
summary(model3)
plot(log(Price)~log(Weight),data=car.test.frame)
plot(Price~Weight,data=car.test.frame)

model4 = lm(log(Price)~log(Weight))
summary(model4)

model5 = lm(Price~(Weight)^2)
summary(model5)

### Regression with categorical variable
length(table(Type))
model6 = lm(Price~Type)
summary(model6)
### What happened to the level "Compact" in Type ? 
summary(Type)
# compact value has also been included in intercept by

### What is the price for Large Car ? 

### Deciding the base level in model building
cars.data <- within(car.test.frame, Type <- relevel(Type, ref = 4))
# change the base level to sporty instead of compact,that is to tell to include small
# valu in intercept rather than compact value
model7 = lm(cars.data$Price~cars.data$Type)
summary(model7)

predicitons <- predict(model7,cars.data)

### Do i reject the model ? 
model8 = lm(Price~Country)
summary(model8)
### The above model is insignificant
#### which means that the variable : Country 
### is not driver to predict the price

### 
### Significance helps to generalize the models interms of machine 
## learning concept - Adj R 2 also helps to choose a model with 
### less number of values given tha R 2 is same for the 2 models

##
### 
### http://ww2.coastal.edu/kingw/statistics/R-tutorials/formulae.html
# :  -  x : z	include the interaction between these variables
# *	 - x * z	include these variables and the interactions between them
library(car)
data(cars)
cars
names(cars)
nrow(cars)

plot(cars$speed,cars$dist)
cor(cars$speed,cars$dist)
model = lm(dist~speed,data=cars)
summary(model)
str(summary(model))

# preidicting distance for a given speed
speed=15
distance= -17.559+3.932*speed
distance
# Let us understand what is the Multiple Rsquare value and 
# adj R squared values are
cor(cars$speed,cars$dist)
cor(cars$dist,fitted(model)) # observe that both this and above value is same
cor(cars$dist,fitted(model))^2
# understanding the adj multiple r squared value
MultipleR_squared <- summary(model)$r.squared 
1-((1-MultipleR_squared)*(nrow(cars)-1))/(nrow(cars)-ncol(cars))
# what happens if the number of columns are the same 
# as the number of rows a data ? 
# How does the adding a random varaible impacts
# the multiple r squared?
set.seed(20)
random.waiting = rnorm(50,0,1)
new = data.frame(cbind("speed"=cars$speed,"dist"=cars$dist,random.waiting))
dim(new)
model2 = lm(dist~speed+random.waiting,data=new)
summary(model2)
summary(model)
### standardzing the data
rm(list=ls(all=TRUE))
library(rpart)
names(car.test.frame)
str(car.test.frame)
numeric.data <- scale(car.test.frame[,which(sapply(car.test.frame,
                                                 is.numeric))])
cat.data <- data.frame((car.test.frame[,which(sapply(car.test.frame,is.factor))]))
final.data <- cbind(cat.data,numeric.data)
str(final.data)
model3 <- lm(Price~Weight+HP,data=final.data)
model4 <- lm(Price~Weight+Type+HP,data=final.data)
summary(model3)
summary(model4)

model1 <- lm(Price~Weight+HP,data=car.test.frame)
model2 <- lm(Price~Weight+Type+HP,data=car.test.frame)
summary(model1)
summary(model2)
# # model with 2 vars
# Multiple R-squared:  0.6511,  
# Adjusted R-squared:  0.6438
# 
# # model with 3 vars
# Multiple R-squared:  0.6534,  
# Adjusted R-squared:  0.6386 

# model with only intercept
model.intercpet = lm(dist~1,data=new)
summary(model.intercpet)

summary(new)
# model without intercept
model.wointercpet = lm(dist~speed+random.waiting-1,data=new)
summary(model.wointercpet)


### from extending the linear models with R 
#install.packages("faraway")
library(faraway)
data(gavote)
dim(gavote)
?gavote
names(gavote)
summary(gavote)
head(gavote)
attach(gavote)
undercount = ballots-votes


gavote$undercount <- (gavote$ballots-gavote$votes)/gavote$ballots
summary(gavote$undercount)
gavote$pergore = gavote$gore/gavote$votes
plot(undercount~equip,gavote,xlab="")

### which factors accout for undercount
cor(gavote[,c(3,10,11,12)])
lmod = lm(undercount~pergore+perAA,gavote)
summary(lmod)
coef(lmod)
predict(lmod)

# residuals
residuals(lmod)

#### Evaluating the model 
undercount_hat <- fitted(lmod) # predicted values
as.data.frame(undercount_hat)

# Evaluating the model
library(DMwR)
regr.eval(gavote[,"undercount"], undercount_hat, train.y = gavote[,"undercount"])
# regr.eval(test[,"undercount"], undercount.test_hat, train.y = gavote[,"undercount"])

## Not a great model and what constitutes a good values of 
### R^2 varies according to the application
### R^2 it can never decrease when you new precictor values
### This means , it favors add more variables
### Another way to think R^2 is 
cor(predict(lmod),gavote$undercount)^2
### Adj R^2 - Adding a predictor will only increase
### the value
?gavote
gavote$cpergore = gavote$pergore-mean(gavote$pergore)
gavote$cperAA = gavote$perAA-mean(gavote$perAA)

lmodi = lm(undercount~cperAA+cpergore+cpergore*rural+equip,gavote)
summary(lmodi)
names(gavote)
table(gavote$equip)

#writing the console ouput to a file
out<-capture.output(summary(lmodi))
cat(out,file="D:/INSOFE/Regression/out.csv",sep="\n",append=TRUE)
#cat(out,file="out.csv",sep="\n",append=TRUE)

### Diagnostic plots of model
plot(lmodi)
influencePlot(lmodi,id.method="identify", main="Influence Plot", sub="Circle size is proportial to Cook's Distance" )

outlierTest(lmodi) # to get outliers of the model
#other way to find outlier,outputs the index/row number of outlier
#identify(undercount,cperAA,cpergore,cpergore*rural,equip,row.names(gavote))
#we can update the previous model to remove the outlier by using the command
# update(lmodi,subset =-i) #where i is the index returned from previous identify command

### influencing points or outliers based on cooks distance
gavote[cooks.distance(lmodi)>0.1,]
plot(undercount~equip,gavote,xlab=" ")
halfnorm(influence(lmodi)$hat) #plotting outliers
# halfnorm(lmodi$residuals)
?gavote
summary(lmodi)
### two points are much higher leverage than the rest
### let us understand them a bit
gavote[influence(lmodi)$hat>0.3,] #0.3 is seen from the graph
# which(rownames(gavote) %in%  c("MONTGOMERY","TALIAFERRO"))
### these are the only two counties use a paper ballot
### so, they will be the only cases that determine the coefficients 
### the paper note that the counties are not identifed 
### as highly inflential
### Having high leverage alone not enough to be influential
termplot(lmodi,partial=TRUE,terms=1)
### Gives the snapshot of the marginal relatioship between
### this predictor and the response

####### Robust regression ######
### Least square works well when there are normal errors
### but performs poorly for long-tailed erros.
### Outilier also there
write.csv(gavote,"D:/INSOFE/Regression/gavote.csv",row.names=TRUE)

library(MASS)
rlmodi = rlm(undercount~cperAA+cpergore*rural+equip,gavote)
summary(rlmodi)
summary(lmodi)
# Robust reg : Residual se: 0.01722 on 150 df
# liner reg : Residual se: 0.02335 on 150 df

### look at the coefficients for equipOS-Paper
### robust fit reduced the effect of the two outlying
### counties

### Weighted least squares
### the proportion of undercounted votes to Gore 
### variable in smaller counties than the larger ones
?gavote
xx <-data.frame(table(gavote$ballots,gavote$rural))
xx$Var1 <- as.numeric(as.character(xx$Var1))
str(xx)

wlmodi = lm(undercount~cperAA+cpergore*rural+equip,gavote,weights=ballots)
summary(wlmodi)
summary(lmodi)
names(gavote)
summary(gavote$vote)

### Applying transformations on the regressors
plmodi = lm(undercount~poly(cperAA,4)+cpergore*rural+equip,gavote)
summary(plmodi)

### Variable selection - using AIC information
biglm = lm(undercount~(equip+econ+rural+atlanta)^2+(equip+econ+rural+atlanta)*(perAA+pergore),gavote)
step(biglm,trace=T)
# step function stops hen the AIC starts to increase when attributes are removed,optimal model
# to be considered is the last model when step function stops executing.here AIC starts with
#negative value and keeps on removing each variable from model equation and computes AIC
# - given for variable implies AIC computed by removing that variable


### the final model is 
finallm = lm(formula = undercount ~ equip + econ + rural + perAA + equip:econ + 
     equip:perAA + rural:perAA, data = gavote)
summary(finallm)

#### Variation inflation factors - multicollinearity
library(car)
fit <- lm(mpg~disp+hp+wt+drat, data=mtcars)
names(mtcars)
summary(fit)
1/(1-(0.8782)) #what is 0.8782?
vif(fit) # variance inflation factors 
sqrt(vif(fit)) > 2 # problem?
fit2 <- lm(mpg~hp+drat, data=mtcars)
summary(fit2)
fit2 <- lm(mpg~hp+drat-1, data=mtcars)
summary(fit2)

### Logistic Regression
data(orings)
?orings
names(orings)
### Proportion of number of rings damage,since damage has 6 value categories
plot(damage/6~temp,data=orings,xlim=c(25,85),ylim=c(0,1),xlab="Temparature",ylab="Prob of Damage")

### Naive Approach
lmod = lm(damage/6~temp,data=orings)
abline(lmod)
lmod$coefficients

### using the model for predictions
lmod$coefficients[1]+31*lmod$coefficients[2]
lmod$coefficients[1]+100*lmod$coefficients[2]

### Assume 
### number of damages to be binomially distributes
### Errros are approx normal
### Variance of the binomial variable is not const
### may be good solution, even if we transformations
### weighting to correct the above problems
### 
logitmod = glm(cbind(damage,6-damage)~temp,family=binomial,data=orings)
logitmod
plot(damage/6~temp,data=orings,xlim=c(25,85),ylim=c(0,1),xlab="Temparature",ylab="Prob of Damage")
x = seq(25,85,1)
lines(x,ilogit(11.6630-0.2162*x))
## ilogit function gives you predicted values for your model

# probitmod =glm(cbind(damage,6-damage)~temp,family=binomial(link=probit),data=orings) 
# sumary(probitmod)
# lines(x,pnorm(5.591453-0.105804*x))

### predicting the proability - logistic regression
ilogit(11.6630-0.2162*31)
# ### predicting the proability - probit
# pnorm(5.591453-0.105804*100)

### Deviance --- how close a small model comes to perfection
### Null deviance is the deviance for a model with no predictors 
### and just an intercept term
### residual deviance is the deviance from the current model
### explain the null and alt hypothesis
pchisq(deviance(logitmod),df.residual(logitmod),lower=F)

### we can use deviance to compare two nested model(null deviance model and residual deviance model) also
pchisq(38.9-16.9,1,lower=F) #null deviance - residual deviance,degrees of freedom
### Effect of launch temparature is significant
confint(logitmod) #confidence interval for the model attributes

### baby food example
data(babyfood)
?babyfood
summary(babyfood)
nrow(babyfood)
# xtabs function to get aggregated result in R,xtabs is used to study relationship between
# two factor variables
xtabs(disease/(disease+nondisease)~sex+food,data=babyfood)

md1 = glm(cbind(disease,nondisease)~sex+food,
          family=binomial,data=babyfood)
summary(md1)
exp(coef(md1))

####### odds ratios and 95% CI
exp(cbind(OR = coef(md1), confint(md1)))

# For one unit increase in food supplment, 
### the odds of risk for getting a disess(Vs no disease)
# increases by 84%

# deviance residuals are a measure of model fit. 

### Question 
### is there a sex-by-food interaction
## a model with interaction effect would be saturated with 
## deviance and df = 0. 
### from the results, a deviance of 0.72 is not at all large
### so we may conclude that the there is no evidence of an interaction effect
### interpreting the coefficients
### the effect of breat feeding
### exp(-0.669)= 51.222%

### breast feedding the reduces the risk 
### of respiratory disese by 51.22%
### boys are vulnerable 
exp(-0.3126)= 73.154#% coefficient of sexgirl in the model

# predicting the proababilities
pred.result <- predict(md1, newdata = babyfood, type = "response") #type response 
#implies categorical vaiable
pred.result
plot(md1$fitted)
# attach(babyfood)
# cdplot(cbind(disease,nondisease)~ sex+food,data=babyfood)

### polynomial regression models
# relationship between the response vaariable and an 
# explantory variable is a higher order polynomial
year = seq(1981,1999)
deaths = c(339,1201,3153,6368,12044,19404,29105,36126,
           43499,49546,60573,79657,79879,73086,69984,
           61124,49379,43225,41356)
newyear = year-1980
model= lm(deaths~newyear+I(newyear^2)+I(newyear^3))
summary(model)
# splitting plots in proportions
par(mfrow=c(2,2))
plot(deaths~newyear+I(newyear^2)+I(newyear^3))
plot(year,deaths)
## plotting the graph based on the values preddicted in the model
lines(seq(1981,1999,0.1),predict(model,data.frame(newyear=seq(1,19,0.1))))
### Thus we modelled the average number of AIDS related deaths
### as the third degres polynomial

### regression with categorical variables
data(OrchardSprays)
?OrchardSprays
### About the data 
### An experiment was conducted to assess the potency of 
### various constituents of orchard sprays in 
### repelling honeybees, using a Latin square design.
head(OrchardSprays)
model = lm(decrease~treatment,data=OrchardSprays)
summary(model)

# Categorical variables(or Explanatory variables) are
# parameterized differently from the quantitative explanory
# variables in R output . 
# For Categorical variables, one of the levels is chosen
# to be the reference level and the other categories/levels
# are parameterized as differences or contrasts relative to 
# the reference level

## The intercept term is the reference level of the treatment
## factor and it corresponds to treatment A . 
## The estimte listed for treatment B is the contrast to
## reference level. So, the average decrease for treatment B is : 
## 4.625 + 3.000
### the standard error corresponds to the difference between
### treatment B and treatment A 
### similar interpretation for t-test also. 
backward = drop1(model,test="F")
summary(backward)
### drop1 function is used to test each explanatory variable
### by removing the terms from the model formula and comparing 
### the fit to the original model

############ Multiple Regression model - interaction effects
#install.packages("isdals")
library(isdals)
### Objective : to test how to categorical explanatory variables
### infleunce the mean level of the response variable 
data(fev)
head(fev)
summary(fev)
fev$Gender = factor(fev$Gender,levels=c(0,1),labels=c("Female","Male"))
fev$Smoke = factor(fev$Smoke,levels=c(0,1),labels=c("No","Yes"))
summary(fev)
attach(fev)
interaction.plot(Gender,Smoke,FEV,fixed=TRUE)

### if there is no interaction,then the traces
### should be roughly parallel.
model = lm(FEV~Gender+Smoke+Gender*Smoke,data=fev)
summary(model)
### from the above model, we choose to 
model2 = lm(FEV~Gender+Smoke,data=fev)
drop1(model2,test="F")
summary(model2)
### Therefore the model is additive model only
### Boys on average have a forced expiratory volume 
### that is 0.39571 liters  higher than girls
### the persons exposed to smoking have a larger expiratory 
### volume than non-smokers !

### Modelling Interactions #######
### Multiple variables both categorical and numeric
### possible interactions may be present
data(fev)
?fev
fev$Gender = factor(fev$Gender,levels=c(0,1),labels=c("Female","Male"))
fev$Smoke = factor(fev$Smoke,levels=c(0,1),labels=c("No","Yes"))
### defined interactions
### smoke * Age
### smoke * gender
model = lm(FEV~Ht+I(Ht^2)+Smoke*Gender+Smoke*Age,data=fev)
drop1(model,test="F")
### both the linear and quadratic terms for height are 
### significant
### none of  the interactions are siginficant. 
### let us remove the interaction between smoke and gender
### and refit the model
model = lm(FEV~Ht+I(Ht^2)+Smoke+Gender+Age*Smoke,data=fev)
drop1(model,test="F")
### remove the insignificant interaction and fit
model = lm(FEV~Ht+I(Ht^2)+Smoke+Gender+Age,data=fev)
summary(model)
### forced expiratory volume increases 0.0695 lits per 
### per year(Age - Variable)
### boys have larger lung capacity than girls
### smoking reduces the lung capacity by 0.1332 litres
### can we have the interaction effects for numeric attributes?
### possible, but difficlut to interpret
### one solution is to convert into categorical and 
### then solve

#### 
### Multinomial logistic regression model #####
### response variable has more than two categories
### response is nominal (no order)
#install.packages("nnet")
library(nnet)
library(isdals)
data(alligator)
head(alligator)
table(alligator$food)
model = multinom(food~length,data=alligator)
null = multinom(food~1,data=alligator)

### comparing the two models
anova(null,model)
### the likelyhood ratio test for comparing 
### the model where the length is included to the 
### model to where length is not included
### look at the p -value , the alligator size is important 
### factor
summary(model)
table(alligator$food)

### the log-odds ratio of eating inver... relative to fish 
### change by -2.355 for one unit change in length 
len = seq(0.3,4,0.1)
# install.packages("grDevices")
# library(grDevices)
# matplot(len,predict(model,newdata=data.frame(length=len)))

### question 
# what is the odds ratio of an alligator of 2 mets length
# preferring "inv" to "others" ?
# (exp(4.079701-2*2.3553303-(-1.617713+2*0.1101012)))

#### Ordinal logistic regression
### proportional odds logistics regression
library(MASS)
data(survey)
survey1 = na.omit(survey)
resp = ordered(survey1$Exer,levels=c("None","Some","Freq"))
head(survey)
names(survey1)
attach(survey1)
model = polr(resp~survey1$Sex+survey1$Age+survey1$Smoke,data=survey1)
summary(model)
drop1(model,test="Chisq")
model2 = polr(resp~survey1$Sex+survey1$Smoke,data=survey1)
drop1(model2,test="Chisq")
model3 = polr(resp~survey1$Sex,data=survey1)
drop1(model3,test="Chisq")
### Age and smoke are both insignificant (from the p-values)
### They both are removed from the model after successiv
### tests, and only gender remains significant. 
### Let us look at the summary
summary(model3)

### The  estimates are split into 2 sections.
###for any given excercise group, we have that men 
### are more likely to have higher categories(more freq exercise)
### than women 0.4082 is positive.
### The odds beling placed in high freq exer group increases
### by a factor of 1.518(=exp(0.4082)) for men relative to men
### intercets gives intercepts for all except the final category
### so, the estimated proabability that a female student never 
### exercise is : exp(-1.99)/1+exp(-1.99)
exp(-1.99)/1+exp(-1.99)
### The estimated proabibility that a males student
### exercises some times. Note that we are modelling the 
### cumulative proabilities. So, we have to subtract 
### the prob of the first category (no exercise) from the prob of 
### "exercise some times or less" to obtain the proababilty 
### of "exercise sometimes" 
exp(0.1741-0.4082)/(1+exp(0.1741-0.4082))-
  exp(-2.2165-0.4082)/(1+exp(-2.2165-0.4082))
### recall that we are modelling the cumulative 
### probs, so an increase in the cum prob means
### that it is likely to observe a "lower" response category/score
### to predict the proabilities
head(predict(model3,type="prob"))
### The assumption : 
### relationship between each pair of outcome
### groups is same.The proportional odds assumption
### should be checked before the above model is used. 
### We will do this check by fitting the multinomial regression
### and then compare the devian differences between the two models
### Ho : The ordinal regression model is correct
library(nnet)
multi = multinom(Exer~Sex+Age,data=survey)
1-pchisq(deviance(model3)-deviance(multi),df=multi$edf-model3$edf)
### Hence we fail to reject Ho. 
### which means, we can use the proportinal odds model


### 
library(alr4)
xbar <- fmeans[1]
ybar <- fmeans[2]
SXX <- fcov[1,1]
SXY <- fcov[1,2]
SYY <- fcov[2,2]
betahat1 <- SXY/SXX
#betahat1 <- cor(Forbes1)[1,2]*SYY/SXX
betahat0 <- ybar - betahat1 * xbar
print(c(betahat0 = betahat0, betahat1 = betahat1),
      digits = 4)
# Estimating the variance
RSS <- SYY - SXY^2/SXX
sigmahat2 <- RSS/15
sigmahat <- sqrt(sigmahat2)
c(RSS=RSS, sigmahat2=sigmahat2, sigmahat=sigmahat)
vcov(m1)
### Extracting the stanrard erros
(ses <- sqrt(diag(vcov(m1))))
### Confidence intervals
(tval <- qt(1-.05/2, m1$df))
betahat <- c(betahat0, betahat1)
data.frame(Est = betahat,
           lower=betahat - tval * ses,
           upper=betahat + tval * ses)
confint(m1, level=.95)
### determining R^2 and the relation with
### correlation
SSreg <- SYY - RSS
print(R2 <- SSreg/SYY)
cor(Forbes1)[1,2]
cor(Forbes1)[1,2]^2
print(R2 <- SSreg/SYY)

### Predicting the values
betahat0 + betahat1 * Forbes$bp

### R function 
predict(m1, newdata=Forbes, se.fit = FALSE,
        interval = c("none", "confidence", "prediction"),
        level = 0.95)
predict(m1, newdata=Forbes, se.fit = FALSE,
        interval = "confidence",
        level = 0.95)
### adding a term to a simple linear regression model
m1 <- lm(lifeExpF ~ log(ppgdp), UN11)
r1 <- residuals(m1)
m2 <- lm(fertility ~ log(ppgdp), UN11)
r2 <- residuals(m2)

m4 <- lm(resid(m1) ~ resid(m2))
summary(m4)

### Transformations
m1 <- lm(y ~ x1 + log(x2), mydata)
mydata <- transform(mydata, logx2=log(x2))
m2 <- lm(y ~ x1 + logx2, mydata)
m3 <- lm(I(1/y) ~ x1 + log(x2), mydata)

### Polynomial regression
m4 <- lm( y ~ x1 + I(x1^2) + I(x1^3), mydata)


### solving ordinary linear equations
f$Intercept <- rep(1, 51) # a column of ones added to f
X <- as.matrix(f[, c(6, 1, 2, 3, 4)]) # reorder and drop fuel
#X = as.matrix(c(6,1,3,4))
xtx <- t(X) %*% X
xtxinv <- solve(xtx)
xty <- t(X) %*% f$Fuel
print(xtxinv, digits=4)
xty <- t(X) %*% f$Fuel
betahat <- xtxinv %*% xty
betahat
### solving the same in R 
names(f)
m1 <- lm(formula = Fuel ~ Tax + Dlic + Income + FuelPerDriver,data = f)
summary(m1)

### visualization to Interpret Main Efects
fuel2001$Dlic <- 1000*fuel2001$Drivers/fuel2001$Pop
fuel2001$Fuel <- 1000*fuel2001$FuelC/fuel2001$Pop
fuel2001$Income <- fuel2001$Income/1000
fuel1 <- lm(formula = Fuel ~ Tax + Dlic + Income + log(Miles),
            data = fuel2001)
plot(Effect("Tax", fuel1))

### Visulizing the impact of the one variable
### when the rest of the variables are kept constant
### Influential variables- Added-variable plots
library(car)
data(Prestige)
summary(Prestige)
reg1 <- lm(prestige ~ education + income + type, data = Prestige)
avPlots(reg1, id.n=2, id.cex=0.7)

### ### Does the order of the variables matter
BGSgirls$DW9 <- BGSgirls$WT9-BGSgirls$WT2
BGSgirls$DW18 <- BGSgirls$WT18-BGSgirls$WT9
BGSgirls$DW218 <- BGSgirls$WT18-BGSgirls$WT2
m1 <- lm(BMI18 ~ WT2 + WT9 + WT18 + DW9 + DW18, BGSgirls)
m2 <- lm(BMI18 ~ WT2 + DW9 + DW18 + WT9 + WT18, BGSgirls)
m3 <- lm(BMI18 ~ WT2 + WT9 + WT18 + DW9 + DW18, BGSgirls)
summary(m3)
compareCoefs(m1, m2, m3, se=TRUE)
compareCoefs(m1, m2, m3, se=FALSE)

### stepwise regression - updating the model by adding the
### new variables to the existing model
### Adding the variables - Stepwise regression
library(alr4)
fuel2001 <- transform(fuel2001, Dlic=1000*Drivers/Pop,
                      Fuel=1000*FuelC/Pop, Income=Income/1000)
m0 <- lm(Fuel ~ 1, fuel2001)
m1 <- update(m0, ~ Tax)
m2 <- update(m1, ~ . + Dlic)
m3 <- update(m2, ~ . + Income + log(Miles))
m4 <- update(m3, ~ . - Income + log(Miles))
anova(m0,m3)
anova(m0,m4)
### updating the model after removing the outliers
library(car)
reg1 <- lm(prestige ~ education + income + type, data = Prestige)
influenceIndexPlot(reg1, id.n=3)
reg1a <- update(reg1, subset=rownames(Prestige) != "general.managers")
summary(reg1a)
summary(reg1)
reg1b <- update(reg1a, subset= !(rownames(Prestige) %in% c("general.managers","medical.technicians")))
summary(reg1a)
summary(reg1b)
### Testing for heteroskedasticity
library(car)
reg1 <- lm(prestige ~ education + income + type, data = Prestige)
ncvTest(reg1)

### Testing for multicolinearity
library(car)
reg1 <- lm(prestige ~ education + income + type, data = Prestige)
