# Pandas library is used for data munging and preparation of data for analysis
# matplotlib library is used for plotting graphs, pyplot is used to plot graphs
# similar to matlab.
# statsomodels library is used for modelling the data like linear,logistic etc
# http://pandas-docs.github.io/pandas-docs-travis/

import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.formula.api as sm
import numpy as np
import os

# change the current working directory 
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")
# Read Toyota.csv as dataframe using pandas
data =pd.read_csv('Toyota.csv')
#print(data.head())

# Just read columns specified from the data frame
#tydata = data[:,['Age_06_15','Mfg_Year','Fuel_Type']]
#print(tydata.head())

# divide the plot into 3 subplots,1 row and 3 columns,sharey=true implies are the
# 3 graphs here share the same y-axis
fig, axs = plt.subplots(1, 3, sharey=True)
# plot the data as scatter plot with age on x-axis and price on y axis,figure
# size given width 16 inch, height 8 inch,plot as 1st graph out of 3
data.plot(kind='scatter', x='Age_06_15', y='Price', ax=axs[0], figsize=(16, 8))
# plot mfgyear vs price as scatter plot in second graph
data.plot(kind='scatter', x='Mfg_Year', y='Price', ax=axs[1])
# plot fuel-type vs price as histogram plot in third graph
data.plot(kind='hist', x='Fuel_Type', y='Price', ax=axs[2])
plt.show()

# linear regression model for data with Price asdependent varaiable and Age as
# independent variable, fit gives least sum of squares value
linm = sm.ols(formula='Price ~ Age_06_15',data=data).fit()

# .params fucntion gives coefficient values for intercept and age here for model
# generated in above command
print(linm.params)

# Predict the price for age of 40 years using elow command
P_pred = pd.DataFrame({'Age_06_15':[40]})
print(P_pred.head())
# compute yhat value for given P_pred array
pred =linm.predict(P_pred)

# print confidence intervals,probability values of independent attributes, R-square
# value and summary of linear regression model generated
print "confidence intervals\n",linm.conf_int()
print "Prob values\n",linm.pvalues
print "R-sqr value\n",linm.rsquared
print "model summary\n",linm.summary()

# Multi variate linear regression model with 2 independent variables and print 
# the summary of model generated
mulm = sm.ols(formula='Price ~ Age_06_15 + Mfg_Year',data=data).fit()
print "multi variate linear model summary\n",mulm.summary()

#remove unnecessary columns, split the data frame column wise
cols = data.columns[0:38]
data = data[cols]
#print data.head()

# split data into test and train data. with 80% data as train data and 20% test
# data
rnd = np.random.rand(len(data)) < 0.8
train_data = data[rnd]
test_data = data[~rnd]

# Build a linear regression model on train data
train_model = sm.ols(formula = 'Price ~ Age_06_15', data = train_data).fit()
print (train_model.summary())

# compute yhat value from the model built
train_predict = train_model.predict(train_data)

# make predictions on test data based on regression model
prediction = train_model.predict(test_data)
print "predicted values of test_data",prediction

# divide data to have only price column for error computations
price_col = train_data.columns[2]
test_col = test_data.columns[2]

# define rmse function
def rmse(prediction,target):
    return np.sqrt(((prediction - target)**2).mean())

# compute rmse for train data
train_rmse = rmse(train_predict,train_data[price_col])
print "train rmse value\n",train_rmse

# compute rme for test data
test_rmse = rmse(prediction,test_data[price_col])
print "test data rmse value\n", test_rmse