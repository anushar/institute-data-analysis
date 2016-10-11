# -*- coding: utf-8 -*-
"""
Created on Thu Jul 23 17:57:39 2015

@author: anusha
"""
#http://www.pyimagesearch.com/2014/06/23/applying-deep-learning-rbm-mnist-using-python/
from sklearn.cross_validation import train_test_split
from sklearn.metrics import classification_report
from sklearn.linear_model import LogisticRegression
from sklearn.neural_network import BernoulliRBM
from sklearn.grid_search import GridSearchCV
from sklearn.pipeline import Pipeline
import numpy as np
#import argparse
import time
import pandas as pd
#import cv2

#epsilon value is used to prevent divide by zero errors
def scale(X, eps = 0.001):
	# scale the data points s.t the columns of the feature space
	# (i.e the predictors) are within the range [0, 1]
	return (X - np.min(X, axis = 0)) / (np.max(X, axis = 0) + eps)
 
import os

# change the current working directory 
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")

# read UnivBank data as data frame in pandas
ub_data = pd.read_csv('UnivBank.csv')
print ub_data.head()
#print len(ub_data)

# remove Id and zipcode columns from the data
#ub_data.iloc[] is used to locate column numbers using integer values
# .loc[] is used to locate column numbers using column names,.ix[] is used to
# locate columns using both integers and strings
ub_data = pd.concat([ub_data.ix[:,[1,2,3]], ub_data.ix[:,5:]],axis=1)
#print ub_data.describe()

# prepare data for logistic regression by introducing dummy variables for categorical
# attributes
# convert education column as dummy variable
dummy_edu = pd.get_dummies(ub_data['Education'],prefix='edu')
#print dummy_edu.head()

# convert family column as dummy variable
dummy_family = pd.get_dummies(ub_data['Family'],prefix='family')


# construct data frame with required nd dummy variables
cols_reqd = ['Age','Experience','Income','Mortgage','Securities Account',
             'CD Account','CreditCard','Online']
X = ub_data[cols_reqd].join(dummy_edu.ix[:,'edu_2':]).join(dummy_family.ix[:,'family_2':])
print X.head()

y=ub_data['Personal Loan']

X = X.astype("float32")
#scale x values from 0-1
X = scale(X)

# construct the training/testing split
(trainX, testX, trainY, testY) = train_test_split(X, y,
	test_size = 0.2, random_state = 42)
 
# initialize the RBM + Logistic Regression pipeline
rbm = BernoulliRBM()
logistic = LogisticRegression()
classifier = Pipeline([("rbm", rbm), ("logistic", logistic)])
 
# perform a grid search on the learning rate, number of
# iterations, and number of components on the RBM and
# C for Logistic Regression
print "SEARCHING RBM + LOGISTIC REGRESSION"
params = {
	"rbm__learning_rate": [0.1, 1, 10],
	"rbm__n_iter": [20, 30, 40],
	"rbm__n_components": [5, 10, 15],
	"logistic__C": [1.0, 5.0, 10.0]}
 
# perform a grid search over the parameter
start = time.time()
gs = GridSearchCV(classifier, params, n_jobs = -1, verbose = 1)
gs.fit(trainX, trainY)
 
# print diagnostic information to the user and grab the
# best model
print "\ndone in %0.3fs" % (time.time() - start)
print "best score: %0.3f" % (gs.best_score_)
print "RBM + LOGISTIC REGRESSION PARAMETERS"
bestParams = gs.best_estimator_.get_params()
 
# loop over the parameters and print each of them out
# so they can be manually set
for p in sorted(params.keys()):
	print "\t %s: %f" % (p, bestParams[p])
 
# show a reminder message
#print "\nIMPORTANT"
#print "Now that your parameters have been searched, manually set"
#print "them and re-run this script with --search 0"

print classification_report(testY, gs.predict(testX))
