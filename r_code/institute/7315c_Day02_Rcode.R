####################
# 7315c_Day02_RCode
####################
#About Environment
# To check in which direcory we are presently in 
#clear console-Ctrl+l

#to load an R code use 
#setwd(location of R script needed)
#source("Rscriptname.R")

getwd()
# To set a directory
setwd("C:/Users/bharath/Desktop/insofe/R code/insofe") 

rm(list=ls(all=T)) #TO remove the objects stored in workspace

####################
#Creating a sample data
Gender = rep(c("M","F"),c(2500,3000))
sum(Gender=="M")
sum(Gender=="F")
Married = rep(c("N","Y","N","Y"),c(1200,1300,1800,1200))
Qualification =
  rep(c("Q1","Q2","Q3","Q4","Q1","Q2","Q3","Q4","Q1","Q2","Q3","Q4","Q1","Q2","Q3",
        "Q4"),
      c(264,327,227,286,650,145,577,301,221,420,396,328,663,302,260,133))
Data = data.frame(Gender,Married,Qualification)
#Understanding data
head(Data)
tail(Data)
summary(Data)
str(Data)
class(Data$Gender)
rownames(Data)
colnames(Data)
names(Data)
#output is columns names only here as rows have no names defined.
dim(Data)
#output is a vector containing number of rows and columns
levels(Data$Gender)
#output is different type of categorical elements present in gender column
##levels(Data) not acceptable command,out is NULL
##############################################################
### Lists
jalt <- list("Joe", 55000, T)
j <- list(name="Joe", salary=55000, union=T)
jalt[1]
names(j)
ulj <- unlist(j)#converts list into a char vector
class(ulj)

## Though one of the values was numeric, R was forced to make the vector of class character.
### It follows an order of precedenceof data types while doing so.logical < integer < real < complex < character< list < expression:

### Accessing List Elements
j
## [[ ]] returns a value, while [ ] returns a sublist
j[[2]]
j[2]
### Combining the lists
b <- list(u = 5, v = 12)
c <- list(w = 13)
a <- list(b,c)

## Adding/Deleting the List Elements
z <- NULL
z <- list(a="abc",b=12)
## Adding
z$c = 1
z$a <- NULL
z
### Difference between list and data frame ###
# lists can be seen as a collection of elements 
# without any restriction on the class, length or 
# structure of each element. The only thing you need to take care of, 
# is that you don't give two elements the same name. 
# That might cause a lot of confusion, 
# and R doesn't give errors for that:
X <- list(a=1,b=2,a=3)
#X["a"] output is 1 onle
X <- list(station="Vinadio", elev=1200, month=c("N","D","J"),
          snowdepth=c(6,21,44))

## Data frames are lists as well, but they have a few restrictions:
##you can't use the same name for two different variables
## all elements of a data frame are vectors
## all elements of a data frame have an equal length.
n = c(2, 3, 5) 
s = c("aa", "bb", "cc") 
b = c(TRUE, FALSE, TRUE) 
df = data.frame(n, s, b) 

### Referring the columns in the data frame
df$n

##########################################################################

# for loops 
x = c(3,4,5)
for (n in x)
{ print (n)}

############################################################################# 
# Functions

## operators are also functions
y <- c(12,5,13)
y+4

# Writing a simple function##
w = 52
adddone <- function(x) x <- x+1
dd <- adddone(w)

### Few more functions - Pay attention to what we are passing 
### to this function.
f <- function(elt,s) return(elt+s)
y <- c(1,2,4)
f(y,1)

### pre-defined functions 
### Any function
x <- 1:10
if (any(x > 8)) print("yes")
ifelse (any(x > 88),"yes","no")
mean(y)
sd(y)

# Writing a function to know number/count of odd numbers
# in a vector
oddcount <- function(x){
  k =0 
  for( n in x){
    if(n %%2 ==1) k = k+1
  }
  return(k)   
}
oddcount(x)
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


##########################################################################
##################### In-built data sets####################
data()

dataCo = longley
str(dataCo)

rm(list=ls(all=T))

#subsetting 
datasub <- dataCo[1:10,c(3,5)]
datasub1 <- dataCo[, c(1,4,7)]
datasub2 <- dataCo[1:10, ]
datasub3 <- dataCo[dataCo$Unemployed<300,]
datas = dataCo[which(dataCo$Unemployed<300),]
#just the less than condition fucntion returns a vector of TRUE or FALSE values,
#when we trying to get the subset of dataCo it just returns rows for which index there is true in
#the vector
#which(less than condition function) returns the vector of indices for which the
#condition is met and the subset wold be all rows for which condition is met
#both datas and datasub3 are equal
for (x in datas){if(all(datas == datasub3) && (length(datas[x,]) == length(datasub3[x,]))){print("both are equal")}}
datasub4 <-dataCo[which(dataCo$GNP.deflator>100),]
datas1 = dataCo[,which(dataCo$GNP.deflator>100)] #can't be performed becoz
#which always returns row index values but not column indexes and column is fixed here

datasub5 <-dataCo[,which(names(dataCo) == "GNP.deflator")]
#returns the value of the columns name GNP.deflator
datasub6 <- subset(x = dataCo, select = c("GNP","Year"))
#returns all rows with only 2 columns gnp nd year

##################Stat
#Understanding the distribution of data
V<-sample(1:10000,100) # To create a numeric vector with 100 numbers randomly

max(V)
min(V)
length(V)
mean(V)
median(V)
var(V)
sd(V)
range(V)
######### note name of function quantile and not quartile #########################
quantile(V) #outputs 0,25,75 and 100th quartile values of v
#sort v in ascending order and ,25th index =(n+1)/4
quantile(V,0.1)#10% quartile value
quantile(V, c(0.25, 0.75))
IQR(V)#7626-2706,75%-25% values)
summary(V)
boxplot(V)
hist(V)
V<- c(1,2,3,4,15,NA,30)
mean(V)
mean(V, na.rm=TRUE)
#Simulation
sample <- rnorm(n = 10000, mean = 55, sd = 4.5)
#Skewness and Kurtosis
#install.packages("moments")
library(moments)
plot(sample,type = "l")
kurtosis(sample)
#If kurtosis < 3 its platykurtic #negative kutosis
#If kurtosis~~3= indicates normal distribution #mesokurtic
#If kurtosis > 3 its leptokurtic #positive kurtosis
## kurtosis implementation
#kurtosis = function(x){n = length(x);z=(x-mean(x))/sd(x);kurt = (sum(z^4)/n) -3;
#            return(kurt)}

skewness(sample)
#+ve value indicates +skew,(data dist is towards left side of the mean) ; For +skewed data, mean comes at last
#-ve value indicates -ve skewness;(data dist is towards right side of the mean) ; For -skewed data, median comes at last
# skewness actual implementation
# skewness = function(x){n=length(x);z=(x-mean(x))/sd(x);sk = (sum(Z^3)/3);return(sk)}
##################
#Reading and Writing data to and from R

write.csv(mtcars,"mtcars.csv")
write.csv(mtcars, "mtcars.txt")
write.csv(mtcars,"mtcars.csv",row.names=T)
read.csv("mtcars.csv")
read.csv("mtcars.txt")

#Excel files
install.packages("XLConnect")
library(rJava)
require(XLConnect) #library(XLConnect) # To load an add-on package

writeWorksheetToFile(file = "carsdata.xls", data = mtcars, sheet = "Sheet1")

wb<-loadWorkbook("carsdata.xlsx")
data<-readWorksheet(wb,"Sheet1",header=T)

#################
#Excercises
#1. Create sample data of 100 points and write a fucntion to find sum of squares about mean
