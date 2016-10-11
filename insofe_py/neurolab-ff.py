# -*- coding: utf-8 -*-
"""
Created on Thu Jul 30 14:11:43 2015

@author: Anusha
"""
#https://github.com/kwecht/NeuroLab/blob/master/test_cee.py
#http://stackoverflow.com/questions/29280181/multilayer-perceptron-neurolab-python
import mydata
# neurolab library
import neurolab as nl
import pandas as pd

# import unnivbank dataset and print the dimensions of input data
(X,y) = mydata.data_parse()
print X.shape
#split the data into test and train
(trainx,testx,trainy,testy) = mydata.split_data(X,y)
# reshape the data to single column array
trainy = trainy.reshape(len(trainy),1)
testy = testy.reshape(len(testy),1)
#print "maximum values of x:\n",X.max(),"\n","minimum x values:\n",X.min()
print "range of X values:",X.max()-X.min()

#net = nl.net.newff([[23, 67], [-3, 43],], [39, 1])
# calculate min and max for each column of X
def minMax(x):
    return pd.Series(index=['min','max'],data=[x.min(),x.max()])

#make a list of min max values for all attributes of the data 
listvalues = X.apply(minMax).T.values.tolist()
# build the neurala network on all input variables with 5 hidden nodes and one output node
net = nl.net.newff(listvalues, [5, 1])
# train the data on our data with 100 iterations(epochs) and goal is to converge to 10^-10 and show
# first 100 iteration errors
netTrain= net.train(trainx, trainy,show=100,goal=1e-10,epochs=100)
print "errors fo each epoch:",netTrain

# 
net.errorf = nl.error.MSE()
print "mean sqaure error:",net.errorf(trainy,testy)
#print "mse:"nl.error.MSE(y,X).mean()

