# Pandas library is used for data munging and preparation of data for analysis
# http://pandas-docs.github.io/pandas-docs-travis/
import pandas as pd

# Numpy Data is used for coputations involving arrays or matrices and also linear
# algebra
import numpy as np

# matplotlib library is used for plotting graphs, pyplot is used to plot graphs
# similar to matlab.
import matplotlib.pyplot as plt

# statsomodels library is used for modelling the data like linear,logistic etc
import statsmodels.api as sm

# create a data frame of 1000 rows of random normal variables with 6 columns each named A to F
# row names start with 1/1/1990 till 1000 days 
bd=pd.DataFrame(np.random.randn(1000, 6)**3, index=pd.date_range('1/1/1990',periods=1000), columns=list('ABCDEF'))

# To get cummulative sum of all elements of the column
#bd = bd.cumsum()
# To plot the graph of data frame use plot function and show to see the graph
#bd.plot();
#plt.show()

# split bd data frame and create kd frame with only A column and 1000 rows
kd = bd.loc[:,['A']]

# As kd data frame is dense recreate data again by computing mean of the data
# for each month frequency specified as M in command 
kd = kd.resample('M',how='mean')
print kd.head()
# To plot the graph of data frame use plot function and show to see the graph
kd.plot()
plt.show() 

# head function is used to print first 5 rows of the data frame
#print(kd.head())

# set the plot width and height in inches ,here 12 inch width and 8 inch height
# is given in the command below.
fig = plt.figure(figsize=(12,8))

# Plot is divided into subplots using add_subplot command
# 211 signify 2 rows, 1 coulumn and that this is first plot 
ax1 = fig.add_subplot(211)

# plot_acf function is used to plot acf graph of data frame for given number of
# lags and ax is subplot name
fig = sm.graphics.tsa.plot_acf(kd, lags=25, ax=ax1)

# plot pacf graph in subplot 2
ax2 = fig.add_subplot(212)
fig = sm.graphics.tsa.plot_pacf(kd, lags=25, ax=ax2)
plt.show()

# describe function gives you ummary of data frame like R
kdd =kd.describe()
print kdd

# hist function can be used to get histogram of the data
#kd.hist()
#plt.show()


# statistic model time series analyis arima use sm.tsa.ARIMA
# aruguments for ARIMA(dataframe/series/dependent variable,order=(p,d,q),exog=none
# (if no independent variables are present),dates=None(none if pandas object is 
# given date is expected to be indices/rows else array of dates is given),freq=(
# H[hour],D[day],M[month] etc))
# For ARIMAX we use .fit for the function has arguments start_params gives (p,q)
# ARMA._fit_start_params, trend = c/nc add constant or nno constant,method ={'css-mle'/
# 'mle'/'css'}  If “css-mle”, the conditional sum of squares likelihood is maximized 
# and its values are used as starting values for the computation of the exact likelihood 
# via the Kalman filter. If “mle”, the exact likelihood is maximized via the Kalman Filter.
# If “css” the conditional sum of squares likelihood is maximized.  

model = sm.tsa.ARIMA(kd,order=(2,1,2),freq='M',missing='none').fit()
print "ARIMA MODEL:\n",model.summary()
print "aic value of model:",model.aic

# Arimax model,for arimax we shouldn't include constant
# alpha is confidence interval,steps is number of out of sample forecasts from
# the end of sample.exog is the array of data.
# This command returns array of forecasts,stderror of forecasts and confidence
# interval of the forecast
#model_max = model._results.forecast(steps=1,exog=kd,alpha=0.05)


# ARMA model for same data
# inputs dataframe,(p,q) tuple and trend if present, we have to differentiate input
# before applying ARMA model to make data stationary
arma_model = sm.tsa.ARMA(kd,(2, 2))
arma_res = arma_model.fit(trend='nc')
print "ARMA MODEL RESULTS:\n",arma_res.summary()

# simple moving average of data can be calculated using rolling_mean function
# inputs dataframe/series, window size, min_periods=no of observations in window
# to have a value
sma = pd.rolling_mean(kd,4)
print "simple moving averages:\n",sma

# calculate exponential weighted moving average using ewma function
# inputs dataframe/series,span=float(specify decay in terms of span,alpha=2/(span+1))
# halflife=float(specify decay in terms of halflife, alpha = 1-exp(log(0.5))/halflife)
# min_periods=int(minimum number of observations in window required to have a value)
# ignore_na=True, to ignore missing values when calculation weights
# must pass one of com,san or halflife
exponential_ma = pd.ewma(kd,span = 2.0)
print "exponential weighted moving averages:\n",exponential_ma

# calculate weighted moving average
#"rolling mean with weight python"
#http://stackoverflow.com/questions/23898631/is-there-a-way-to-do-a-weight-average-rolling-sum-over-a-grouping

#avgbin[i] = np.average()