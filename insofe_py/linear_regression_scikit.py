# -*- coding: utf-8 -*-
"""
Created on Thu Jul 09 14:27:41 2015

@author: Anusha
"""
import pandas as pd
import numpy as np
from sklearn.cross_validation import train_test_split
import matplotlib.pyplot as plt
from sklearn import linear_model
import os

# change the current working directory 
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")

#train, test = train_test_split(df, test_size = 0.2)
# load the CSV file as a numpy matrix
ub_data = pd.read_csv('UnivBank.csv')
print ub_data.head()

# remove Id and zipcode columns and personal loan from the data fraame
#ub_data.iloc[] is used to locate column numbers using integer values
# .loc[] is used to locate column numbers using column names,.ix[] is used to
# locate columns using both integers and strings
# consider dependent variable as separate array
loan_data = pd.DataFrame(ub_data.ix[:,9])
ub_data = pd.concat([ub_data.ix[:,[1,2,3,5,6,7,8]], ub_data.ix[:,10:]],axis=1)
print ub_data.describe()

# split data into test and train,80% as train data, remaining as test data
rnd = np.random.rand(len(loan_data)) < 0.8
train = ub_data[rnd]
test = ub_data[~rnd]
train_y = loan_data[rnd]
test_y = loan_data[~rnd]


# Create linear regression object
lin_regr = linear_model.LinearRegression()

# Train the model using the training sets
model = lin_regr.fit(train, train_y)
#print model.summary()

# The coefficients
print 'Coefficients: \n', lin_regr.coef_
# The mean square error
print "Residual sum of squares: %.2f" % np.mean((lin_regr.predict(test) - test_y) ** 2)
# Explained variance score: 1 is perfect prediction
print 'Variance score or R^2 value of model: %.2f' % lin_regr.score(test, test_y)

# Plot outputs
#plt.scatter(test, test_y,  color='red')
#plt.plot(test, lin_regr.predict(test), color='blue')
#plt.show()


