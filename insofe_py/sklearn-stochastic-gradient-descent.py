# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 11:10:35 2015

@author: anusha
"""
#http://scikit-learn.org/stable/modules/sgd.html
#http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.SGDClassifier.html#sklearn.linear_model.SGDClassifier
#http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.SGDRegressor.html#sklearn.linear_model.SGDRegressor
## import stochastic gradient descent classifier type
from sklearn.linear_model import SGDClassifier,SGDRegressor
## stochastic gradient descent is very sensitive to feature scaling so it is highly recommended
# to scale the dta before building a model on it
from sklearn.preprocessing import StandardScaler
# metrics to know goodness of the model
from sklearn.metrics import classification_report
import mydata
import regrdata

# construct the training/testing split
(X_train, X_test, Y_train, Y_test) = mydata.split_data()

# standard scaler to scale the attributes and apply some transformations on them
scaler = StandardScaler()
scaler.fit(X_train)  # Don't cheat - fit only on training data
X_train = scaler.transform(X_train)
X_test = scaler.transform(X_test)  # apply same transformation to test data

## ideal number of iter value:n_iter = np.ceil(10**6 / n), where n is the size of the training set.
# instantiate stochastic gradient descent classifier
# parameters: loss = Defaults to ‘hinge’, which gives a linear SVM. The ‘log’ loss gives logistic regression, a probabilistic classifier
# The penalty (aka regularization term) to be used. Defaults to ‘l2’ which is the standard regularizer for linear SVM models.
# ‘l1’ and ‘elasticnet’ might bring sparsity to the model (feature selection) not achievable with ‘l2’.
# alpha:constant that multiplies to regularisation term,defaults to 0.0001
clf = SGDClassifier(loss="hinge", penalty="l2")
print clf.fit(X_train,Y_train)

print "coefficients of classification model:",clf.coef_
print "intercept of the model:",clf.intercept_
print "decision function of model:",clf.decision_function(X_test)

print("stachastic gradent descent classifier repoort:\n%s\n" % (classification_report(Y_test,clf.predict(X_test))))
##SGDClassifier supports averaged SGD (ASGD). Averaging can be enabled by setting `average=True`. 

#############################################################################################
# construct the training/testing split
(Xtrain, Xtest, Ytrain, Ytest) = regrdata.split_data()
# regression model using stochastic gradient descent using SGDRegressor function
# prameter: loss:sqaured loss to get ordinary lest squared value
clr = SGDRegressor(loss="squared_loss",penalty="l2").fit(Xtrain,Ytrain)
print clr
#The coefficient R^2 is defined as (1 - u/v), where u is the regression sum of squares ((y_true - y_pred) ** 2).sum() 
#and v is the residual sum of squares ((y_true - y_true.mean()) ** 2).sum().
#score function returns R^2 of self.predict(X) wrt. y.
print "coefficients of linear model:",clr.coef_
#print "R square value of the model on test data:",clr.score(Xtest,Ytest)
print "rmse value of the model:",regrdata.rmse(clr.predict(Xtest),Ytest)