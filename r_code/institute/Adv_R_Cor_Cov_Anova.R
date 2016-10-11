setwd("C:\\Users\\bharath\\Desktop\\insofe\\R code")
#Importing data
Grade1 <-read.csv("Grade1.csv",header=T)
Grade2 <-read.csv("Grade2.csv",header=T)
Names <-read.csv("Names.csv",header=T)

-----------------------------------------------------------------------
# data split for train and test

train = sample(1:nrow(Grade1),10) # to take a random sample of  60% of the records for train data 
data_train = Grade1[train,] 
nrow(data_train)

data_test=test = Grade1[-train,] 
#data_test = Grade1[test,] 
nrow(data_test)  

# splitting data into test and train
set.seed(123)
num_Records = nrow(Grade1)
train_Index = sample(1:num_Records, round(num_Records * 0.8, digits = 0))
train_Data = Grade1[train_Index,] 
test_Data = Grade1[-train_Index,]   
----------------------------------------------------------------------
  ---------------------------------------------------------------------------  
  #for loop- Simple for loop examples
  A<-data.frame(0)
for(i in 1:10){
  A[i]<-2 *i
}
A
A<-data.frame(0)
for(i in 1:nrow(Grade1)){
  A[i]<-Grade1$Math1[i]
}
A[2]

V<-0
for (i in 1:ncol(A)){
  if(A[i]>=45){ 
    V[i]=2
  }
  else {
    V[i]=1
  }
}
A
length(V[V==1])

#While loop-Simple while loop examples
x<-1
while(x<10){
  x<-x+1
  print(x)
}

#Writing a function in R
# Writing custom functions
pow<-function(x,y)
{
  return(x^y)
}
pow(2,3)

square <- function(y) 
{
  x <- y^2
  return(x)
}
square(12)

fn = function(x) { s=sum(x)
                   return(s)  
}
#Calling a function
v1=c(1,2,3,4,5)
v2=c(11,12,13,12,13)
fn(v1)
fn(v2)

####################################################################################
#setwd("E:\\CPEE\\Deloitte\\Data")

#Using apply functions. Understand the usage of each function 

#setwd("E:\\CPEE\\Batch 12\\7315c\\Day 03\\Activity_20150621")

#Using apply functions. Understand the usage of each function 

data=data.frame(v1,v2)
data
#apply
apply(Grade1,1,sum) # to get the row wise sums  
apply(Grade1,2,sum) # to get the column wise sums
#Few other ways of invoking a function
apply(data,2,sum)
apply(data,2,function(x){sum(x)})
v1
#sapply
sapply(data,function(x) x^2) # applying on each element of the vector
#Applying a function on each of the columns of the entire data frame 
#Considering a subset of a data
Grade1<-read.csv("Grade1.csv",header=T,sep=",")
apply1<-apply(Grade1[,2:4],2, mean) #2 denotes by column  #apply works on array or matrix
apply1
apply1<-apply(Grade1[,2:4],1, mean) # 1 denotes by row
apply1
#tapply
str(mtcars)
tapply<-tapply(mtcars$mpg,mtcars$cyl,mean) # takes one function and gives the values and not a dataframe
tapply

# Observe that the outputs from all the above apply functions are values and not as data frames we can convert them to df
#Please go to the below resources 
#http://nsaunders.wordpress.com/2010/08/20/a-brief-introduction-to-apply-in-r/
#http://www.statmethods.net/management/index.html
# explore the plyr package and ddply 
#install.packages("plyr")
require(plyr)
dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  Gen = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54)
)
head(dfx)
ddply(dfx, .(Gen, group),  mean = round(mean(age), 2), sd = round(sd(age), 2), summarize)
?baseball
head(baseball)
ddply(baseball[1:50,], ~ year, nrow)
names(baseball)
dim(baseball)


###################################################################################
#Reshaping data
#install.packages("reshape")
library(reshape)
setwd("")
Grade1  =read.csv("Grade1.csv",header=T)
str(Grade1)
#expanding the data based on a particular variable. This is also called the long format.
meltdata<-melt(data=Grade1,id="Student.id")
head(meltdata)

#aggregating the data based on subject and gender. This is also called the wide format.
data2<-cast(data=meltdata,Student.id~variable,value="value") 
data3<-cast(data=meltdata,variable~Student.id,value="value") #Observe the difference in data2 and data3

---------------------------------------------------------------------
#  setwd("E:\\CPEE\\Batch 12\\7315c\\Day 03\\Activity_20150621")
cereals = read.csv("Cereals.csv", header=T)
plot(cereals)
summary(cereals)
#install.packages("DMwR")
library(DMwR)
cereals_imputed<-centralImputation(cereals) #Cenral Imputation
str(cereals_imputed)
cerealsCor = cor(cereals_imputed[,-1])
write.csv(cerealsCor, "correlation.csv")
cerealscov = cov(cereals_imputed[,-1])
--------------------------------------------------------------------------------------------------------------------------------------------------
library(MASS)
?painters
names(painters)
dim(painters)
school= painters$School
table(school)
school.freq=table(school)
# count of painters from each school

barplot(school.freq) #apply the barplot function 
colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
# apply the barplot function 
barplot(school.freq, col=colors) 
barplot(school.freq, col = colors, main = "Count of painters from each school", legend=rownames(painters$School)) 
barplot(school.freq, col = heat.colors(10), main = "Count of painters from each school",
        legend.text = c("A", "B", "C", "D","E"),
        args.legend = list(x = "topright"), font.main = 16) 

#install.packages("ggplot2")
library(ggplot2)
attach(mtcars)
?mtcars
names(mtcars)
str(mtcars)
c <- ggplot(mtcars, aes(factor(cyl)))
c + geom_bar()
c+geom_bar(width=0.5)
c + geom_bar() +coord_flip()
#c + scale_fill_brewer()
c+geom_bar(fill="green", colour="darkgreen", width=0.5)

#stacked plots
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(vs))
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(gear))

attach(diamonds)
?diamonds
names(diamonds)
str(diamonds)
#grouped bar chart 
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar(position="dodge")
#Use facetting. clarity versus cut (when both are categorical type)
ggplot(diamonds, aes(clarity)) + geom_bar(fill="green", colour="darkgreen", width=0.5) + facet_wrap(~ cut)


data(ToothGrowth)
names(ToothGrowth)
summary(ToothGrowth)
#boxplot to compare Length versus the vitaminC dosage on a subset of data where the 
#subset is on supp = "VC"

boxplot(len ~ dose, data = ToothGrowth,
        boxwex = 0.25, at = 1:3 - 0.2,
        subset = supp == "VC", col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")

# option "add" to add two types of box plots. comparing between two subsets "VC" and "OJ"
# the option "at" gives the location on the scale from where the box plots should be added.
boxplot(len ~ dose, data = ToothGrowth, add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")

summary(ToothGrowth)

library(ggplot2)
# compare the number of cyclers(cyl) and the miles per gallon(mpg)
#when cyl = 8, we note that there are outliers
names(mtcars)
summary(mtcars)
p <- ggplot(mtcars, aes(factor(cyl), mpg))
p + geom_boxplot()
# display the points on the plot
p + geom_boxplot() + geom_jitter()
p + geom_boxplot(outlier.colour = "green", outlier.size = 3) + geom_jitter()
p + geom_boxplot(aes(fill=cyl))
p + geom_boxplot(aes(fill=factor(cyl), stats="identity"))

-----------------------------------------------------------------------------------------
#Scatter plots
  
data(longley)
names(longley)  
head(longley)

#let us look at the correlation between the GNP and unemployed
cor(longley$GNP, longley$Unemployed)
cor(longley$GNP, longley$Employed)
cor(longley$Unemployed, longley$Employed)
#there is a positive correlation of 0.604 between GNP and Unemployed. We mean that the 
#GNP and Unemployed move together

plot(longley$GNP, longley$Unemployed)
plot(longley$GNP, longley$Unemployed, main = "relation between GNP and Unemployed")  
plot(longley$GNP, longley$Unemployed, main = "relation between GNP and Unemployed", xlab="GNP", ylab = "Unemployed")  
#to rotate the values of yaxis use las = 1
plot(longley$GNP, longley$Unemployed, main = "relation between GNP and Unemployed", xlab="GNP", ylab = "Unemployed", las=1)  
# pch to use diff shape on graph
plot(longley$GNP, longley$Unemployed, main = "relation between GNP and Unemployed", xlab="GNP", ylab = "Unemployed", las=1, pch=6,col=6)  

# let us look at the trend in the data
abline(lm(longley$GNP~longley$Unemployed), col=4)

#smooth the line using spline, add line type and line width
lines(smooth.spline(longley$GNP, longley$Unemployed))
lines(smooth.spline(longley$GNP, longley$Unemployed), lwd=5, lty=2)

# plot of correlation between all variables
#creating a scatter plot matrix to study the relationship between all the variables
pairs(~longley$GNP +longley$Unemployed+longley$Employed+longley$Armed.Forces+longley$Population)

#install.packages("gclus")
library(gclus)
dta <- mtcars[c(1,3,5,6)] # get data 
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
# reorder variables so those with highest correlation
# are closest to the diagonal
dta.o <- order.single(dta.r) 
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5,
       main="Variables Ordered and Colored by Correlation" )

# let us create a density scatter plot for a sample data
x <- rnorm(1000)
y <- rnorm(1000) 
plot(x,y, main="PDF Scatterplot Example", col=rgb(0,100,0,50,maxColorValue=255), pch=16)
#plot(longley$GNP, longley$Unemployed,col=rgb(0,100,0,50,maxColorValue=255), pch=16) 

#3D scatter plots
#install.packages("scatterplot3d")
library(scatterplot3d)
attach(mtcars)
scatterplot3d(wt,disp,mpg, main="3D Scatterplot")
#scatter plot with coloring and vertical drop lines
scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE,
              type="h", main="3D Scatterplot")
#scatter plot with coloring and vertical line on regression plane
s3d <-scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE,
                    type="h", main="3D Scatterplot")
fit <- lm(mpg ~ wt+disp) 
s3d$plane3d(fit)

#spinning the scatter plots
#install.packages("rgl")
library(rgl)
plot3d(wt, disp, mpg, col="red", size=3)


#Using ggplot2
#install.packages("ggplot2")
library(ggplot2)
p <- ggplot(mtcars, aes(wt, mpg))
p + geom_point()
p + geom_point(colour = "red", size = 4)
p + geom_point(aes(colour = qsec))
p + geom_point(aes(colour = factor(cyl)))
p + geom_point(aes(shape = factor(cyl)))
p + geom_point(aes(size = factor(cyl)))
# Change scales
p + geom_point(aes(colour = cyl)) + scale_colour_gradient(low = "blue")

#adding layer by color, shape and size

p + aes(shape = factor(cyl)) +
  geom_point(aes(colour = factor(cyl)), size = 4) +
  geom_point(colour="grey90", size = 1.5)

#connect points with line, #add regression line, #add vertical line
p1 <- ggplot(mtcars, aes(x = hp, y = mpg))
p1 + geom_point(color="blue") + geom_line()                           
p1 + geom_point(color="red") + geom_smooth(method = "lm", se = TRUE)  
p1 + geom_point() + geom_vline(xintercept = 100, color="red") 


#facetting
qplot(hp, mpg, data=mtcars, shape=as.factor(cyl), color=am, facets=gear~cyl, size=I(3),
      xlab="Horsepower", ylab="Miles per Gallon") 
----------------------------------------------------------------------------
  #LinePlots
  
  data(Orange)
dim(Orange)
names(Orange)
str(Orange)
#set the graphical parameters using "par"
# check various options in par using ?par or help(par)
par(pch =16, col="blue")
plot(Orange$age, Orange$circumference)
lines(Orange$age, Orange$circumference)

# convert factor to numeric for convenience 
Orange$Tree <- as.numeric(Orange$Tree) 
ntrees <- max(Orange$Tree)

# get the range for the x and y axis 
xrange <- range(Orange$age) 
yrange <- range(Orange$circumference) 

# set up the plot 
?plot.default
plot(xrange, yrange, type="n", xlab="Age (days)",ylab="Circumference (mm)" ) 
colors <- rainbow(ntrees) 
linetype <- c(1:ntrees) 
plotchar <- seq(18,18+ntrees,1)

# add lines 
for (i in 1:ntrees) { 
  tree <- subset(Orange, Tree==i) 
  lines(tree$age, tree$circumference, type="b", lwd=1.5,
        lty=linetype[i], col=colors[i], pch=plotchar[i]) 
} 

# add a title and subtitle 
title("Tree Growth", "example of line plot")

# add a legend 
legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,
       pch=plotchar, lty=linetype, title="Tree")

setwd("E:/UK classes")
stocks = read.csv("stocks.csv",  header=T, sep=",")
summary(stocks)
par(pch =16, col="blue")
plot(stocks$Week, stocks$Price1)
lines(stocks$Week, stocks$Price1)

par(pch =16, col="red")
plot(stocks$Week, stocks$Price2)
lines(stocks$Week, stocks$Price2)

qplot(stocks$Week, stocks$Price1, data=stocks, geom=c("point", "smooth"), 
      method="lm", formula=y~x,  
      main="Regression", 
      xlab="Weight", ylab="Miles per Gallon")

data(economics)
names(economics)
str(economics)
summary(economics)
qplot(date, pop, data=economics, geom="line")
qplot(date, pop, data=economics, geom="line", log="y")
qplot(date, pop, data=subset(economics, date > as.Date("2006-1-1")), geom="line")

#ggplot

c <- ggplot(economics, aes(x = date, y = pop))
# Arrow defaults to "last"
library(grid)
c + geom_line(arrow = arrow())
c + geom_line(arrow = arrow(angle = 15, ends = "both", type = "closed"))

# See scale_date for examples of plotting multiple times series on
# a single graph
#http://docs.ggplot2.org/current/geom_line.html

#install.packages("Deducer")
library(Deducer)
JGR()

# References
# http://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf
# http://www.stat.berkeley.edu/~s133/dates.html
# http://www.r-tutor.com/r-introduction/basic-data-types/character
# http://www3.nd.edu/~sjones20/JonesUND/BioStats_files/RstringManipulation_2-6-13.pdf
# http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf

----------------------------------------------------------------------------
Chi-square
#independence test between gender and game preference
tb<-matrix(c(200,150,50,250,300,50),c(2,3),byrow=T)
chisq.test(tb)

#Safety test
data <- data.frame(meanpress = c(643,655,702,469,427,525,484,456,402),method = factor(rep(c("M1","M2","M3"),c(3,3,3))))
model= aov(meanpress~method,data=data)
model

#Instructional methods test
data <- data.frame(scores = c(86,79,81,70,84,90,76,88,82,89,82,68,73,71,81),method = factor(rep(c("A1","A2","A3"),c(5,5,5))))
model= aov(scores~method,data=data)
summary(model)

setwd("E:\\CPEE\\Batch 12\\7315c\\Day 03\\Activity_20150621")
data = read.csv("Data(for qns 6).csv", header=T)
summary(data)
library(DMwR)
dataCI<-centralImputation(data) #Cenral Imputation
str(dataCI)
dataCor = cor(dataCI)
write.csv(dataCor, "correlation.csv")
datascov = cov(dataCI)
dta.col <- dmat.color(dataCor) # get colors
dta.o <- order.single(dataCor) 
cpairs(dataCI, dta.o, panel.colors=dta.col, gap=.5,
       main="Variables Ordered and Colored by Correlation" )

Ozone	Solar.R	Wind	Temp
Ozone	1	0.295472473	-0.529966851	0.589516474
Solar.R	0.295472473	1	-0.059317044	0.245013124
Wind	-0.529966851	-0.059317044	1	-0.409060957
Temp	0.589516474	0.245013124	-0.409060957	1


