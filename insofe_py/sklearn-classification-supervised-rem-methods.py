# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 14:55:39 2015

@author: Anusha
"""
### ref ##
#http://scikit-learn.org/stable/modules/naive_bayes.html
### k-nearest neighbors #####
#http://scikit-learn.org/stable/auto_examples/neighbors/plot_classification.html#example-neighbors-plot-classification-py
#http://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html#sklearn.neighbors.KNeighborsClassifier
#http://scikit-learn.org/stable/modules/neighbors.html
### random forest and gradient boost 
#http://scikit-learn.org/stable/modules/ensemble.html
#http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html#sklearn.ensemble.RandomForestClassifier
#http://scikit-learn.org/stable/modules/generated/sklearn.ensemble.GradientBoostingClassifier.html#sklearn.ensemble.GradientBoostingClassifier
#########
# metrics to know goodness of the model
from sklearn.metrics import classification_report
#import  naive bayes library, k nearest neighbors library, support vector machines,
from sklearn import naive_bayes,neighbors,svm
# import random forest and gradient boost
from sklearn.ensemble import RandomForestClassifier,GradientBoostingClassifier
import mydata

(X_train,X_test,Y_train,Y_test) = mydata.split_data()

################ k-nearest neighbors ##############
#for weights in ['uniform', 'distance']:
    # we create an instance of Neighbours Classifier and fit the data.
## k nearest neighbour algorithm instance
# parameters: n_neighbors : number of neighbors to use,weights:weight function used in prediction
clf = neighbors.KNeighborsClassifier(15, weights='distance').fit(X_train,Y_train)
print clf
print "mean score:",clf.score(X_test,Y_test).mean()
# find neighbours and distances of test data baed on the model
distance,indices = clf.kneighbors(X_test)
print "indices of neighbors:",indices
print "distance of neighbors:",distance

# print report of the model
print("k nearest neighbor classifier repoort:\n%s\n" % (classification_report(Y_test,clf.predict(X_test))))

################ naive bayes #####################
# naives_bayes is of 3 types:GaussianNB(gaussian naive bayes method),MultinominalNB(naive bayes method for multinominal data),
# BernoulliNB(naive bayes method for bernoulli distributed data)
# parameters class_prior_ :probability of each class,theta_ :mean of each feature per class
gnb = naive_bayes.GaussianNB().fit(X_train,Y_train)
print "mean score:",gnb.score(X_test,Y_test).mean()
# print report of the model
print("Gaussian Naive Bayes method classifier repoort:\n%s\n" % (classification_report(Y_test,gnb.predict(X_test))))
################ support vector machines ##########
# SVC - support vector classification model
# SVR - support vector regression model
# in svm we have 3 types of models LinearSVC for linear kernels,SVC and NuSVC can be used for multiclass
#variables and different types of kernels
# parameters: C:Penalty parameter C of the error term,kernel:Specifies the kernel type to be used in the algorithm. It must be one of ‘linear’,
# ‘poly’, ‘rbf’, ‘sigmoid’, ‘precomputed’ or a callable. If none is given, ‘rbf’ will be used.
#
slf = svm.SVC().fit(X_train,Y_train)
print slf
print "mean score:",slf.score(X_test,Y_test).mean()
print "predictions from model:",slf.predict(X_test)
print "support vectors of the model:",slf.support_vectors_
print "indices of support vectors:",slf.support_
print "number of support vectors for each class",slf.n_support_

print("support vector machine classifier repoort:\n%s\n" % (classification_report(Y_test,slf.predict(X_test))))

################ random forests ##################
# optimal value max_features=sqrt(n_features) for classification tasks (where n_features is the number of features in the data).
# parameters: n_estimators:The number of trees in the forest,max_features :The number of features to consider when looking for the best split,
#max_depth:The maximum depth of the tree. If None, then nodes are expanded until all leaves are pure or until all leaves contain less than min_samples_split samples. 
rfc = RandomForestClassifier(n_estimators=10).fit(X_train,Y_train)
print rfc
print "mean score:",rfc.score(X_test,Y_test).mean()
print("random forest classifier repoort:\n%s\n" % (classification_report(Y_test,rfc.predict(X_test))))


############### Gradient Boosting ###############
#Classification with more than 2 classes requires the induction of n_classes regression trees at each at each iteration, thus, the total number of
#induced trees equals n_classes * n_estimators.for datasets with more number of classes for target variables random trees are better than gradient boosting technique
# parameters: n_estimators: number of boosting stages to perform,learning_rate :learning rate shrinks the contribution of each tree by learning_rate.
#max_depth :maximum depth of the individual regression estimators,min_samples_leaf :The minimum number of samples required to be at a leaf node.
gbc = GradientBoostingClassifier(n_estimators=100, learning_rate=1.0,
                                 max_depth=1, random_state=0).fit(X_train, Y_train)
print gbc
print "mean score:",gbc.score(X_test, Y_test).mean()
print("Gradient Boosting classifier repoort:\n%s\n" % (classification_report(Y_test,gbc.predict(X_test))))
        