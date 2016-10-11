# -*- coding: utf-8 -*-
"""
Created on Fri Jul 24 00:04:09 2015

@author: anusha
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Jul 23 17:57:39 2015

@author: anusha
"""
#http://www.pyimagesearch.com/2014/06/23/applying-deep-learning-rbm-mnist-using-python/
#https://github.com/scikit-learn/scikit-learn/blob/master/sklearn/neural_network/rbm.py
#http://scikit-learn.org/stable/auto_examples/neural_networks/plot_rbm_logistic_classification.html
# module used to slit data into test and train sets
from sklearn.cross_validation import train_test_split
# metrics to know goodness of the model
from sklearn.metrics import classification_report
# logiticc regression module
from sklearn.linear_model import LogisticRegression
# bernoulliRBM is the only neural network allgorithm in sklearn library
from sklearn.neural_network import BernoulliRBM
#Pipeline can be used to chain multiple estimators into one. This is useful as there is often a 
#fixed sequence of steps in processing the data
from sklearn.pipeline import Pipeline
# numpy is used for array processing
import numpy as np
# pandas is used for dataframe processing
import pandas as pd

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
# locate columns using both integers and strings
X = pd.concat([ub_data.ix[:,[1,2,3]], ub_data.ix[:,5:]],axis=1)
print X.head()

y=ub_data['Personal Loan']

# for bernoullirbm all values should be of float type
X = X.astype("float32")
#scale x values from 0-1
X = scale(X)

# construct the training/testing split
(trainX, testX, trainY, testY) = train_test_split(X, y,
	test_size = 0.3, random_state = 42)
 
# initialize the RBM + Logistic Regression pipeline
logistic = LogisticRegression()
# BernoulliRBM parameters,n_componets:int,number of binary hidden units;learning_rate:float,rate for weight updates
# n_iter : int, Number of iterations/sweeps over the training dataset to perform during training.
# verbose : int,verbosity level;verbose : int,A random number generator instance to define the state of the random permutations generator
rbm = BernoulliRBM(n_components=2,learning_rate=0.1,n_iter=10,\
            random_state=None,verbose=10)
classifier = Pipeline(steps=[('rbm', rbm), ('logistic', logistic)])
classifier.fit(trainX,trainY)
# Get parameters for this estimator.deep: boolean,If True, will return the parameters for this estimator and contained subobjects that are estimators.
print rbm.get_params(deep=True)

#Compute the pseudo-likelihood of argument.it computes a quantity called the free energy on X, then on a randomly corrupted version of X,
# and returns the log of the logistic function of the difference.
#print rbm.score_samples(trainX)
print("using RBM features:\n%s\n" % (classification_report(testY,classifier.predict(testX))))
