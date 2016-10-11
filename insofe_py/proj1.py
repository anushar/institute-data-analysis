# -*- coding: utf-8 -*-
"""
Created on Wed Jul 15 15:10:31 2015
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
#print tsdata.head()

tsdata.head()

# convert month ,year and day as dummys
dm_month = pd.get_dummies(tsdata['month'],prefix='mnt')
dm_year = pd.get_dummies(tsdata['year'],prefix='yr')
dm_day = pd.get_dummies(tsdata['day'],prefix='day')
dm_date = pd.get_dummies(tsdata['date'],prefix='dt')
# plot just the quntity data
y = tsdata['quantity']
y.plot()
plt.show()
# construct data frame with required attributes
# combine all dummy's to creeate a dataframe
x =pd.concat([(dm_date.ix[:,'dt_2':]),(dm_month.ix[:,'mnt_2':]),(dm_year.ix[:,'yr_2013':]),(dm_day.ix[:,'day_Monday':])],axis=1)
print x.head()

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
x = pd.concat([x,df],axis=1)
# remove first 6 rows to remove NA's rows
x = x.ix[6:]
# concatenate quantity and remaining columns
fulld = pd.concat([y[6:],x],axis=1)
print x.head()

# compute linear regression model on all the attributs of the whole data
linear_mod = sm.OLS(y[6:],x).fit()
#print linear_mod.summary()

# one more way of splitting data into train and test data
rd = fulld['yr_2015'] != 1
train_1 = fulld[rd]
test_1 = fulld[~rd]
print fulld.head()
# train x data frame removing quantity column
train_x =train_1.ix[:,1:]

# linear regression model on all attributes of train data
train_mod = sm.OLS(train_1['quantity'],train_x).fit()
#print train_mod.summary()

# build linear regression model again with significant attributes
model1 = sm.ols(formula = 'quantity ~ dt_13 + dt_31 + mnt_6 + mnt_9 + yr_2013 +\
            day_Tuesday + expma1 + expma2 + expma3 + sma1 + sma2 + sma3',data =train_1).fit()
print model1.summary()

# compute yhat value from the model using predict function
train_predict = model1.predict(train_1)
test_predict = model1.predict(test_1)

# define rmse function
def rmse(prediction,target):
    return np.sqrt(((prediction - target)**2).mean())

# compute rmse for train data
train_rmse = rmse(train_predict,train_1['quantity'])
print "train rmse value\n",train_rmse

# compute rme for test data
test_rmse = rmse(test_predict,test_1['quantity'])
print "test data rmse value\n", test_rmse

plt.plot(train_1['quantity'],train_predict)
plt.show()