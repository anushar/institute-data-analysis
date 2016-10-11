# -*- coding: utf-8 -*-
"""
Created on Thu Jul 16 11:57:31 2015
"""


import pandas as pd
import matplotlib.pyplot as plt 
import statsmodels.formula.api as sm
import numpy as np
import os

# chnge current working directory
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")

# read the csv file as dataframe
tsdata = pd.read_csv('TSData.csv')
print tsdata.head()

#tdt = pd.to_datetime()
y = tsdata['quantity']
# simple moving average
sma1 = pd.rolling_mean(y,3)
sma2 = pd.rolling_mean(y,5)
sma3 = pd.rolling_mean(y,7)

# compute eponential weighted moving averages
expma1 = pd.ewma(y,span=7.0)
expma2 = pd.ewma(y,span=3.0)
expma3 = pd.ewma(y,span=5.0)

# construct dataframe from simple moving averages and exponential weighted moving averages arrays
df = pd.DataFrame({'sma1':sma1,'sma2':sma2,'sma3':sma3,'expma1':\
        expma1,'expma2':expma2,'expma3':expma3})
# concatenat dummy variables and moving averages as single dataframe
tsdata = pd.concat([tsdata,df],axis=1)
# remove first 6 rows to remove NA's rows
tsdata = tsdata.ix[6:]

# divide data into test and train
# put 2012,2013 and 2014 as train and 2015 as test data
train = tsdata[tsdata['year'] < 2015]
test = tsdata[tsdata['year'] == 2015]

#model1 = sm.ols(formula = 'quantity ~ time + expma1 + expma2 + expma3 + sma1 + sma2 + sma3',data =train).fit()
#model1 = sm.ols(formula = 'quantity ~ time',data =train).fit()
model1 = sm.ols(formula = 'quantity ~ expma1 + expma2 + expma3 + sma1 + sma2 + sma3',data =train).fit()

print model1.summary()

# compute yhat value from the model using predict function
train_predict = model1.predict(train)
test_predict = model1.predict(test)

# define rmse function
def rmse(prediction,target):
    return np.sqrt(((prediction - target)**2).mean())

# compute rmse for train data
train_rmse = rmse(train_predict,train['quantity'])
print "train rmse value\n",train_rmse

# compute rme for test data
test_rmse = rmse(test_predict,test['quantity'])
print "test data rmse value\n", test_rmse
