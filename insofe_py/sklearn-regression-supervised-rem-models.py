# -*- coding: utf-8 -*-
"""
Created on Tue Jul 28 10:32:46 2015

@author: Anusha
"""
######## ref ########
#http://scikit-learn.org/stable/modules/neighbors.html#nearest-neighbors-regression
#http://scikit-learn.org/stable/modules/model_evaluation.html
#
import regrdata
#from sklearn.metrics import r2_score,
# import k nn neighbors, decision trees,support vector machines,random forests and gradient boosting
from sklearn import neighbors,tree,svm,ensemble

# construct the training/testing split
(X_train, X_test, Y_train, Y_test) = regrdata.split_data()

######## k nearest neighbors #####################
# regressor parameters: 15 is number of neighbors and weights is weight function used in prediction. 
knr = neighbors.KNeighborsRegressor(5,weights = "uniform").fit(X_train,Y_train)
print knr
distance,indices = knr.kneighbors(X_test)
print "indices of neighbors:",indices
print "distance of neighbors:",distance
#print "R square value of the model:",knr.score(X_test,Y_test)
#print "rmse value of the regression model:",regrdata.rmse(knr.predict(X_test),Y_test)

####### decision trees ###########################
# parameters: max_features: is the maximum number of features to be consideres for the analysis
dtr = tree.DecisionTreeRegressor(max_features='auto').fit(X_train,Y_train)
print dtr
print "R square value of decision tree regression model:",dtr.score(X_test,Y_test)
#print "r sqaure value:",r2_score(Y_test,dtr.predict(X_test))
print "rmse value of model:",regrdata.rmse(dtr.predict(X_test),Y_test)

######  support vector machines #################
## in svm we have 3 types of models LinearSVR for linear kernels,SVR and NuSVR can be used for multiclass
#variables and different types of kernels
# parameters: C:Penalty parameter C of the error term,kernel:Specifies the kernel type to be used in the algorithm. It must be one of ‘linear’,
# ‘poly’, ‘rbf’, ‘sigmoid’, ‘precomputed’ or a callable. If none is given, ‘rbf’ will be used.
svr = svm.SVR(kernel='poly',degree=4).fit(X_train,Y_train)
print svr
print "R square value of the svm regressor model:",svr.score(X_test,Y_test)
print "rmse value of the regression model:",regrdata.rmse(svr.predict(X_test),Y_test)

###### random forests ###########################
## optimal value max_features=sqrt(n_features) for classification tasks (where n_features is the number of features in the data).
# parameters: n_estimators:The number of trees in the forest,max_features :The number of features to consider when looking for the best split,
#max_depth:The maximum depth of the tree. If None, then nodes are expanded until all leaves are pure or until all leaves contain less than min_samples_split samples. 
rfr = ensemble.RandomForestRegressor(n_estimators=10).fit(X_train,Y_train)
print rfr
print "R square value of the rando forest regressor model:",rfr.score(X_test,Y_test)
print "rmse value of the regression model:",regrdata.rmse(rfr.predict(X_test),Y_test)

####### Gradient Boosting #######################
## parameters: n_estimators: number of boosting stages to perform,learning_rate :learning rate shrinks the contribution of each tree by learning_rate.
#max_depth :maximum depth of the individual regression estimators,min_samples_leaf :The minimum number of samples required to be at a leaf node.
gbr = ensemble.GradientBoostingRegressor(n_estimators=10, learning_rate=1.0,
                                 max_depth=1, random_state=0).fit(X_train, Y_train)
print gbr
print "R square value of the Gradient Boosting regressor model:",gbr.score(X_test,Y_test)
print "rmse value of the regression model:",regrdata.rmse(gbr.predict(X_test),Y_test)