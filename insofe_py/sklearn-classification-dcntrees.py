+# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 17:57:27 2015

@author: anusha
"""

# import metrics module to compute errors of the model
from sklearn import metrics
# train_test_split is used to split the dat into test and train sets
from sklearn.cross_validation import train_test_split
# import Decision Tree module from scikit learn,this is used for categorical target
from sklearn.tree import DecisionTreeClassifier
# import pandas to read csv file
import pandas as pd
# os is used to change working directory here
import os

# change the current working directory 
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")

# read UnivBank data as data frame in pandas
ub_data = pd.read_csv('UnivBank.csv')
print ub_data.head()
# locate columns using both integers and strings,combine all variables except ID,zipcode and personal
# loan into X
X = pd.concat([ub_data.ix[:,[1,2,3,5,6,7,8]], ub_data.ix[:,10:]],axis=1)
# y is our target attribute
y=ub_data['Personal Loan']

# construct the training/testing split
(trainX, testX, trainY, testY) = train_test_split(X, y,
	test_size = 0.3, random_state = 42)

#decision tree model for train data
# classifier is used for categorical data,regressor is used for numerical target
# parameters splitter='best'/'random' best is used for best split and random is used for best random split
# max_depth = int or none is max depth of the tree,class_weight = dict/list_of_dicts /auto/none
# Weights associated with classes in the form {class_label: weight}. If not given, all classes are supposed to have weight one. For multi-output problems, a list of dicts can be provided in the same order as the columns of y.
#The “auto” mode uses the values of y to automatically adjust weights inversely proportional to class frequencies in the input data
# random_state : int/none ,If int, random_state is the seed used by the random number generator; If RandomState instance, random_state is the random number generator; 
#If None, the random number generator is the RandomState instance used by np.random
model = DecisionTreeClassifier(random_state=0)
model.fit(trainX,trainY)
print(model)
# make predictions on test data
predicted = model.predict(testX)
# summarize the fit of the model
print(metrics.classification_report(testY, predicted))
print(metrics.confusion_matrix(testY, predicted))