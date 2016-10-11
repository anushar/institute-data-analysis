# -*- coding: utf-8 -*-
"""
Created on Tue Jul 28 15:53:11 2015

@author: anusha
"""
### ref #####
#http://scikit-learn.org/stable/auto_examples/cluster/plot_kmeans_digits.html#example-cluster-plot-kmeans-digits-py
#http://scikit-learn.org/stable/modules/clustering.html
#http://scikit-learn.org/stable/modules/decomposition.html
#http://scikit-learn.org/stable/modules/generated/sklearn.cluster.KMeans.html#sklearn.cluster.KMeans
#http://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html#sklearn.decomposition.PCA
#http://scikit-learn.org/stable/modules/generated/sklearn.cluster.MeanShift.html#sklearn.cluster.MeanShift
#http://scikit-learn.org/stable/auto_examples/cluster/plot_mean_shift.html#example-cluster-plot-mean-shift-py
#
#############
# import k means , mean shift and hierarchical clustering models
from sklearn.cluster import KMeans,MeanShift,AgglomerativeClustering
from sklearn.metrics import silhouette_score
from sklearn.decomposition import PCA
### splitting data####
import pandas as pd
from time import time
import numpy as np
import os
# module used to slit data into test and train sets
from sklearn.cross_validation import train_test_split

def  split_data():
    # change the current working directory 
    os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")

    ########### paring data frame ####
    # read UnivBank data as data frame in pandas
    ub_data = pd.read_csv('UnivBank.csv')
    print ub_data.head()
    print len(ub_data)

    dummy_edu = pd.get_dummies(ub_data['Education'],prefix='edu')
    print dummy_edu.head()

    # convert family column as dummy variable
    dummy_family = pd.get_dummies(ub_data['Family'],prefix='family')


    # construct data frame with required nd dummy variables
    cols_reqd = ['Age','Experience','Income','Mortgage','Securities Account',
                 'CD Account','CreditCard','Online','Personal Loan']
    X = ub_data[cols_reqd].join(dummy_edu.ix[:,'edu_2':]).join(dummy_family.ix[:,'family_2':])
    print X.head()


    # construct the training/testing split
    (X_train, X_test) = train_test_split(X,test_size = 0.3, random_state = 42)
    return(X_train,X_test)    

(X_train,X_test) = split_data()

######### k -means ############
# parameters:n_clusters:The number of clusters to form as well as the number of centroids to generate.
#init:Method for initialization, defaults to ‘k-means++’:
#‘k-means++’ : selects initial cluster centers for k-mean clustering in a smart way to speed up convergence
kmc = KMeans(init='k-means++',n_clusters=2).fit(X_train)
print kmc
print "transformed test data:",kmc.transform(X_test)
print "labels of data:",kmc.labels_
print "coordinates of custer centers:",kmc.cluster_centers_
#predict = kmc.predict(X_test)
print "silhoutte_score of the model:",silhouette_score(X_train,kmc.labels_,metric='euclidean')

########## apply PCA and k-means ##########
# parameters:n_components:Number of components to keep. if n_components is not set all components are kept:

pct = PCA(n_components=6).fit(X_train)
print pct
print "explained variance ratio r2 ratio:",pct.explained_variance_ratio_ 
kmp = KMeans(init='k-means++', n_clusters=2).fit(pct.transform(X_train))
print kmp
print "silhoutte score of pca model:",silhouette_score(X_train,kmp.labels_,metric='euclidean')
########## mean shift ###################
#parameters::bandwidth:Bandwidth used in the RBF kernel.If not given, the bandwidth is estimated using sklearn.cluster.estimate_bandwidth
#bin_seeding:If true, initial kernel locations are not locations of all points, but rather the location of the discretized version of points,
# where points are binned onto a grid whose coarseness corresponds to the bandwidth. Setting this option to True will speed up the algorithm because fewer seeds will be initialized. 
msc = MeanShift(bin_seeding=True).fit(X_train)
print msc
print "labels of mean shift model:",msc.labels_
print "cluster centers of model:",msc.cluster_centers_
print "number of estimated clusters:",len(np.unique(msc.labels_))
########## hierarchical clustering ########
#hirarachical clustering using 3 techniques,n_clusters: number of cluters to find,linkage :Which linkage criterion to use. The linkage criterion determines which distance to use between sets of observation. The algorithm will merge the pairs of cluster that minimize this criterion.
#ward minimizes the variance of the clusters being merged.
#average uses the average of the distances of each observation of the two sets.
#complete or maximum linkage uses the maximum distances between all observations of the two sets.
for linkage in ('ward', 'average', 'complete'):
    clustering = AgglomerativeClustering(linkage=linkage, n_clusters=2)
    t0 = time()
    clustering.fit(X_train)
    print("%s : %.2fs" % (linkage, time() - t0))
print "predictions of hierarchical clustering:",clustering.fit_predict(X_test)


