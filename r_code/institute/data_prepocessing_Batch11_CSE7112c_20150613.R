##univerity of irvine use it to download data sets
rm(list=ls(all=TRUE))
setwd("C:/Users/bharath/Desktop/insofe/R code")

#Importing data
Grade1 <-read.csv("Grade1.csv",header=T)
Grade2 <-read.csv("Grade2.csv",header=T)
Names <-read.csv("Names.csv",header=T)

names(Names)
str(Grade1)

# Type conversion
Grade1$Student.id = as.factor(Grade1$Student.id)
Grade2$Student.id = as.factor(Grade2$Student.id)
Names$Student.id = as.factor(Names$Student.id)

# as.numeric, as.factor, as.character, as.date, etc are some of the type conversions
#use these to convert the data into required formats if we know that data type is not correctly read by R

#Undertanding data structure
str(Grade1)
str(Grade2)
names(Grade1)
names(Grade2)
summary(Grade1)
summary(Grade2)

#Merging two datasets
MergedData<-merge(Grade1,Grade2,by.x="Student.id",by.y="Student.id",all.x=TRUE) #left (outer) join #x is ist table and y is second table.
#collect the columns from y table and merge it with x(1st table)
Mergedgrade<-merge(MergedData,Names,by.x="Student.id",by.y="Student.id",all.y=TRUE) #right (outer) join
#other way round add columns from 1st table to second table
?merge

#exporting data
write.csv(Mergedgrade,"MergedData.csv",row.names=F)


#Subsetting data by row
Grade[rows,cols]
Grade1[,2]   #all rows, 2nd col
Grade1[1:5,] # rows from 1:5 and all cols

Data1<-Grade1[Grade1$OverallPct1>50,]
Data2<-Grade2[Grade2$OverallPct2>50,]
MergedSubData<-merge(Data1,Data2,by.x="Student.id",by.y="Student.id",all.x=TRUE) #left (outer) join

#if you want to subset data based on student ids
Studentdata<-Grade1[Grade1$Student.id == Grade1$Student.id[1:5],]
Studentdata<-Grade1[Grade1$Student.id != "1",]


#--------------------------------------------------------------------------
#removing special characters
symbols =read.csv("Symbols.csv", header =T)
names(symbols)
summary(symbols)
str(symbols)
symbols$salespct=gsub("[%]","",symbols$salespct) ##stripping of % symbol
symbols$salespct =as.numeric(symbols$salespct) ##convert characters to numerics

#gsub("[[:punct:]]","", "attributename") ##removes all kinds of punctuation marks
#gsub("[$]","",attributename)

#Missing values handling
data_mv<-read.csv("Cereals.csv",header=T)
sum(is.na(data_mv))#To check null values in data
summary(data_mv)

#Dropping the records with missing values,entire row is dropped
data_mv2<-na.omit(data_mv)

#To identify rows where more than 10% attributes are missing
library(DMwR)
manyNAs(data_mv,0.01) # row numbers where the condition is satisfied,
#returns row index values which met the condition
#in R only NA are recognied,blanks are not recognised so convert blanks to NA's

#Imputing missing values
library(DMwR) #package used for central imputation
data_mv_imputed<-centralImputation(data_mv) #Cenral Imputation
## in R central imputation means it will replace all NA values with median
summary(data_mv$vitamins)
median(data_mv$sodium, na.rm=T)
sum(is.na(data_mv_imputed))

data_mv_imputed2<-knnImputation(data_mv,k=5) #KNN Imputation
sum(is.na(data_mv_imputed))

rm(data)
data<-read.csv("Customer.csv",header=T)
names(data)
#Creating dummy variables and adding to original table
summary(data)
summary(data$ToyCategory)
#install.packages("dummies")
library(dummies)
EduDummyVars<-dummy(data$ToyCategory)
# dummy converts the data in 00000001,01000000 etc,1 is assigned for categorical
#variable which is present

head(EduDummyVars)
rm(Data)
Data<-data.frame(data[,-3],EduDummyVars)

# identify outlier in the data
stocks = read.csv("C:/Users/bharath/Desktop/insofe/R code/stocks.csv", header=T)
names(stocks)
str(stocks)
summary(stocks$Price1)
#compare data from median to check outliers

boxplot(stocks$Price1,col="green", outline=T) #outline is true to include outliers
#as well in the graph
#abline is used to compute mean and add in box plot
abline(h = mean(stocks$Price1), lty=2)
IQ = IQR(stocks$Price1)
Q1 = quantile(stocks$Price1,0.25)
Q3 = quantile(stocks$Price1,0.75)
lowerinnerfence =  Q1 - 1.5*IQ
upperinnerfence = Q3 + 1.5*IQ
lowerouterfence = Q1 - 3*IQ
upperouterfence = Q3 + 3*IQ
abline(h=lowerinnerfence,lty=4, col="red")
abline(h=upperinnerfence,lty=4, col="red")
abline(h=lowerouterfence,lty=4, col="blue")
abline(h=upperouterfence,lty=4, col="blue")

outlier = stocks[stocks$Price1>539,] #points > upper outerfence
outlier
----------------------------------------------------------------------------
data = read.csv("univComp.csv", header=T) #statasticsboard.com one more sit
names(data)
str(data)

#standardize the data using both range and z-score methods
#install.packages("vegan")
library(vegan)

Data_ccAvg1 <- decostand(data$ccAvg,"range") # using range method normalize data
colMeans(Data_ccAvg1)
var(Data_ccAvg1)

head(data$ccAvg)
head(Data_ccAvg1)
range = (data$ccAvg)/(max(data$ccAvg)-min(data$ccAvg))
head(range)
std = (data$ccAvg-mean(data$ccAvg))/sd(data$ccAvg)
Data_ccAvg2 <- decostand(data$ccAvg,"standardize") # Using Z score method standardize data
colMeans(Data_ccAvg2) #same as mean(Data_ccAvg2)
var(Data_ccAvg2)

NewData = data.frame(cbind(data$ccAvg,Data_ccAvg1, Data_ccAvg2 ))
colnames(NewData) = c("ccAvgOrginal", "ccAvgRange", "ccAvgStd")
names(NewData)

par(mfrow=c(1,3))
#used to divide graph into 1 row and 3 columns here

hist(NewData[,1])
hist(NewData[,2])
hist(NewData[,3])

# using scale function similar to decostand function,but used for z-score

scaledata = scale(data$ccAvg)
colMeans(scaledata)
var(scaledata)

-------------------------------------------------------------------------------------------
  
  #Discretizing/Binning the variable
#install.packages("infotheo")
    library(infotheo)
IncomeBin1 <- discretize(data$inc, disc="equalwidth",nbins=4)
colnames(IncomeBin1) = "Incomenew"
names(IncomeBin1)
table(IncomeBin1)
#plot(IncomeBin1)

IncomeBin2 <- discretize(data$inc, disc="equalfreq",nbins=4)
colnames(IncomeBin2) = "Incomenew"
names(IncomeBin2)
table(IncomeBin2)

----------------------------------------------------------------------------
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

?barplot
data()


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
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(vs))
#stacked bar graph with 3 attributes used y-ais=count,x-axis cyl and stacked on vs
qplot(factor(cyl), data=mtcars, geom="bar", fill=factor(gear))
#same bar graph stacked based on gear

attach(diamonds)
?diamonds
names(diamonds)
str(diamonds)
#grouped bar chart 
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar(position="dodge")
#Use facetting. clarity versus cut (when both are categorical type)
ggplot(diamonds, aes(clarity)) + geom_bar(fill="green", colour="darkgreen", width=0.5) + facet_wrap(~ cut)


attach(mtcars)
names(mtcars)
summary(mtcars)
dim(mtcars)
hist(mpg)
hist(mpg,col="brown")
hist(mpg,col="brown", breaks=10)
hist(mpg, breaks = c(10, 12, 14,18, 20, 22, 25, 28, 30,35 ), main ="distribution of mpg")
hist(mpg, freq=F)
hist(mpg, main="distribution of mgp", xlim = c(10,35), ylim = c(0,10),col="green")

library(ggplot2)
m <- ggplot(mtcars, aes(x=mpg))
m + geom_histogram(aes(weight = mpg))
m + geom_histogram(aes(y = ..count..))
m + geom_histogram(aes(y = ..density..)) +geom_density()
m + geom_histogram(aes(fill=..count..))

attach(movies)
mov = ggplot(movies, aes(x=votes))
mov + geom_histogram(aes(fill=..count..)) + scale_x_log10()

mov+geom_histogram(aes(fill=..count..)) + scale_fill_gradient("Count", low = "green", high = "red")
mov + geom_histogram(binwidth = 1) + scale_x_log10()
mov + geom_histogram(aes(fill=..count..),binwidth = 1) + scale_y_log10()
mov = ggplot(movies, aes(x=votes)) + geom_histogram(binwidth = 1)
mov + facet_grid(Action ~ Comedy)

--------------------------------------------------------------------------
  #boxplots
  # identify outlier in the data
  stocks = read.csv("stocks.csv", header=T)
names(stocks)
str(stocks)
summary(stocks$Price1)

boxplot(stocks$Price1)
abline(h = mean(stocks$Price1), lty=2)
IQ = IQR(stocks$Price1)
Q1 = quantile(stocks$Price1,0.25)
Q3 = quantile(stocks$Price1,0.75)
lowerinnerfence =  Q1 - 1.5*IQ
upperinnerfence = Q3 + 1.5*IQ
lowerouterfence = Q1 - 3*IQ
upperouterfence = Q3 + 3*IQ

outlier = stocks[stocks$Price1>539,]


data(mtcars)
names(mtcars)
attach(mtcars)
boxplot(mpg)
boxplot(mpg, outline=T, border=par("fg"), col="green")
boxplot(mpg, outline=T, border=par("fg"), col="green", 
        pars = list(boxwex = 0.8, staplewex = 0.5, outwex = 0.5))

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
plot(longley$GNP, longley$Unemployed, main = "relation between GNP and Unemployed", xlab="GNP", ylab = "Unemployed", las=1, pch=6,col=6)  

# let us look at the trend in the data
abline(lm(longley$GNP~longley$Unemployed), col=4)

#smooth the line using spline, add line type and line width
lines(smooth.spline(longley$GNP, longley$Unemployed))
lines(smooth.spline(longley$GNP, longley$Unemployed), lwd=5, lty=2)

#creating a scatter plot matrix to study the relationship between all the variables
pairs(~longley$GNP +longley$Unemployed+longley$Employed+longley$Armed.Forces+longley$Population)

#creat a matrix of scatter plot
library(car)
scatterplot.matrix(~mpg+disp+drat+wt|cyl, data=mtcars, main="Three Cylinder Options")

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
library(rgl)
plot3d(wt, disp, mpg, col="red", size=3)


#Using ggplot2
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


