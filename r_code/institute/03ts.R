rm(list=ls(all=TRUE))
setwd("C://Users//bharath//Desktop//insofe//R code")
kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat", 
              skip=3)
kings

kingstimeseries <- ts(kings)
kingstimeseries

#For monthly time series data, 
#you set frequency=12, 
#while for quarterly time series data, 
#you set frequency=4

#You can also specify the first 
#year that the data was collected, 
#and the first interval in that year 
#by using the 'start'
#parameter in the ts() function. For example, if the first data 
#point corresponds to the second quarter of 1986, you would set 
#start=c(1986,2).

#a data set of the number of births per 
#month in New York city, 
#from January 1946 to December 1959

births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
births

birthstimeseries <- ts(births, 
                       frequency=12, 
                       start=c(1946,1))
birthstimeseries

#Similarly, the file http://robjhyndman.com/
#tsdldata/data/fancy.dat 
#contains monthly sales for a souvenir 
#shop at a beach resort town 
#in Queensland, Australia, for January 
#1987-December 1993 (original 
#data from Wheelwright
#and Hyndman, 1998). We can read the data into R by typing:


#Plotting
plot(kingstimeseries)
plot(birthstimeseries)

#Simulated data to understand ACF & PACF

par(mfrow=c(1,1))
time <- c(1:100)
growth <- time
plot(growth~time)

par(mfrow=c(1,2))

growth <- ts(growth)
acf(growth)
pacf(growth)

par(mfrow=c(1,1))
time <- c(1:100)
growth <- sin(growth)
plot(growth~time, type="l")

par(mfrow=c(1,2))

growth <- ts(sin(growth))
acf(growth)
pacf(growth)

par(mfrow=c(1,1))
time <- c(1:100)
growth <- runif(100, min=0, max=1)
plot(growth~time, type="l")

par(mfrow=c(1,2))

growth <- ts(runif(growth))
acf(growth)
pacf(growth)

#kingsdecompose <- decompose(kingstimeseries)

#Decomposition

kingstimeseriescomponents <- 
  decompose(kingstimeseries)

plot(kingstimeseriescomponents)
kingstimeseriescomponents$seasonal
kingstimeseriescomponents$trend

kingstimeseriesSeasonally <- 
  kingstimeseries - kingstimeseriescomponents$seasonal

birthstimeseriescomponents <- 
  decompose(birthstimeseries)

plot(birthstimeseriescomponents)
birthstimeseriescomponents$seasonal
birthstimeseriescomponents$trend

birthstimeseriesSeasonally <- 
  birthstimeseries - birthstimeseriescomponents$seasonal


#ACF and PACF of real world data

par(mfrow=c(1,3))
plot.ts(kingstimeseries)
acf(kingstimeseries, lag.max=20)
pacf(kingstimeseries, lag.max=20)

plot(birthstimeseries)
acf(birthstimeseries, lag.max=20)
pacf(birthstimeseries, lag.max=20)

#ma <- birthstimeseriescomponents$random
#trend <- birthstimeseriescomponents$trend
#seas <- birthstimeseriescomponents$seasonal

#par(mfrow=c(2,2))
#plot(birthstimeseries)
#plot(trend)
#plot(seas)
#plot(ma)

#par(mfrow=c(3,2))
#acf(ma, na.action=na.pass)
#pacf(ma, lag.max=20, na.action=na.pass)
#acf(trend, na.action=na.pass)
#pacf(trend, lag.max=20, na.action=na.pass)
#acf(seas, na.action=na.pass)
#pacf(seas, lag.max=20, na.action=na.pass)

#Regression on time

par(mfrow=c(1,1))
births <- data.frame(births)
births$time <- seq(1:168)
edit(births)
plot(births$births, type="l")
lm1 <- lm(births$births ~ births$time)
lm2 <- lm(births$births ~ 
            poly(births$time, 2, raw=TRUE))
lm3 <- lm(births$births ~ 
            poly(births$time, 3, raw=TRUE))

points(births$time, predict(lm1), 
       type="l", col="red", lwd=2)
points(births$time, predict(lm2), 
       type="l", col="green", lwd=2)
points(births$time, predict(lm3), 
       type="l", col="blue", lwd=2)

births$seasonal <- as.factor(rep(c(1:12),14))
edit(births)

lm1s <- lm(births ~ ., data=births)
lm2s <- lm(births ~ poly(time, 2, raw=TRUE)+
            seasonal, data=births)
lm3s <- lm(births ~ poly(time, 3, raw=TRUE)+
             seasonal, data=births)

plot(births$births, type="l")
points(births$time, predict(lm1s), 
       type="l", col="red", lwd=2)
points(births$time, predict(lm2s), 
       type="l", col="blue", lwd=2)

plot(births$births, type="l")
points(births$time, predict(lm3s), 
       type="l", col="green", lwd=2)

#Another crude approach

births$mae <- births$births/predict(lm1)
##births$month <- rep(seq(1:12),14)
edit(births)
head(births)

seasonal <- tapply(births$mae, 
                   births$seasonal, mean)
seasonal

birthspr <- predict(lm1)*rep(seasonal,14)

plot(births$births, type="l")
points(births$time, birthspr, 
       type="l", col="red", lwd=2)


#Moving averages

library(TTR)

par(mfrow=c(1,1))
kingstimeseries
plot(kingstimeseries)

smaKings <- SMA(kingstimeseries, n=4)
smaKings

wmaKings <- WMA(kingstimeseries, n=4)
wmaKings

emaKings <- EMA(kingstimeseries, n=4)
emaKings

par(mfrow=c(1,1))
plot(kingstimeseries, type="l", col="red")
lines(smaKings, col="black", lwd=2)
lines(wmaKings, col="blue")
lines(emaKings, col="green")

errorSMA <- mean(abs(kingstimeseries[4:42]-smaKings[4:42]))
errorWMA <- mean(abs(kingstimeseries[4:42]-wmaKings[4:42]))
errorEMA <- mean(abs(kingstimeseries[4:42]-emaKings[4:42]))

#Effect of K

kingstimeseriesSMA3 <- 
  SMA(kingstimeseries,n=3)

kingstimeseriesSMA8 <- SMA(kingstimeseries,
                           n=8)

par(mfrow = c(1, 2))
plot.ts(kingstimeseriesSMA3)
plot.ts(kingstimeseriesSMA8)

par(mfrow = c(1, 1))

#Moving average with trend and seasonality
plot(birthstimeseries)

birthsforecast <- 
  HoltWinters(birthstimeseries, 
              beta=FALSE, 
              gamma=FALSE)

birthsforecast
birthsforecast$fitted

plot(birthsforecast)
birthsforecast$SSE

#Let us now 
#assume there is no 
#seasonality, but there 
#is trend

#We can specify the first 
#value and slope

#Additive, trend and seasonality models

birthsforecast <- 
  HoltWinters(birthstimeseries)
birthsforecast
birthsforecast$fitted

plot(birthsforecast)
birthsforecast$SSE

#install.packages("forecast")
library("forecast")

#it predicts seasonal peaks well
birthsforecast2 <- 
  forecast.HoltWinters(birthsforecast, h=8)
#not correct command birthsforecast2 <- forecast(HoltWinters(birthsforecast), h=8)

birthsforecast2

plot.forecast(birthsforecast2)
plot.forecast(birthsforecast2, 
              shadecols=terrain.colors(3))
plot.forecast(birthsforecast2,
              shadecols="oldstyle")


# forecast with NO trend and seasonality

birthsforecast <- 
  HoltWinters(birthstimeseries, 
              beta=FALSE, 
              gamma=FALSE)
birthsforecast <- 
  forecast.HoltWinters(birthsforecast,
                       h=8)
birthsforecast

plot.forecast(birthsforecast)
plot.forecast(birthsforecast, 
              shadecols=terrain.colors(3))
plot.forecast(birthsforecast,
              shadecols="oldstyle")

#ARIMA
plot(birthstimeseries)
birthstimeseriesdiff1 <- 
  diff(birthstimeseries, 
       differences=1)
plot.ts(birthstimeseriesdiff1)

birthstimeseriesdiff2 <- 
  diff(birthstimeseries, 
       differences=2)
plot.ts(birthstimeseriesdiff2)

auto.arima(birthstimeseries)

#Parsimonious models
birthstimeseries <- 
  auto.arima(birthstimeseries,
             ic='bic')
birthstimeseries
birthstimeseriesforecasts <- 
  forecast.Arima(birthstimeseries, 
                 h=5)
plot.forecast(birthstimeseriesforecasts)
dir()
