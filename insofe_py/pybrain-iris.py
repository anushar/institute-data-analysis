# -*- coding: utf-8 -*-
"""
Created on Mon Aug 03 11:59:28 2015

@author: Anusha
"""
from sklearn import datasets
iris = datasets.load_iris()
X,y = iris.data,iris.target

from pybrain.datasets.classification import ClassificationDataSet
from pybrain.utilities import percentError
from pybrain.tools.shortcuts import buildNetwork
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.structure.modules import SoftmaxLayer
#import numpy as np
import matplotlib.pyplot as pl

ds = ClassificationDataSet(4,1,nb_classes = 3)
for i in range(len(X)):
    ds.addSample(X[i],y[i])

# splitting data into train,test and valid data in 60/20/20 proportions
trndata,partdata = ds.splitWithProportion(0.60)
tstdata,validdata = partdata.splitWithProportion(0.50)

# to encode classes wwith one output neuron per class
trndata._convertToOneOfMany()
tstdata._convertToOneOfMany()
validdata._convertToOneOfMany()

# original target values are stored in class created by function to
#preserve the value
print trndata['class']
# new values of target after convertion
print trndata['target']

# check the dimensions of input(4types) and output(3 categories)
print trndata.indim,trndata.outdim,tstdata.indim,tstdata.outdim 

# building neural network with 3 layers input(4),hidden(3 nodes),output 3 nodes
net = buildNetwork(4,3,3,outclass = SoftmaxLayer)

# trainer for backpropogation algorithm
trainer = BackpropTrainer(net,dataset = trndata, momentum = 0.1, verbose = True, weightdecay = 0.01)
# train the model for 50 iterations and calculate the error
trnerr,valerr = trainer.trainUntilConvergence(dataset = trndata,maxEpochs =50)
pl.plot(trnerr,'b',valerr,'r')

#to model for 500 iterations use T.trainOnDataset(trndata,500)
# check how many times trainer was trained
print trainer.totalepochs

# activate is used to predict the output
# convert float values to single integer value using argmax function
out = net.activateOnDataset(tstdata) .argmax(axis = 1)
print "percentage error of model", percentError(out,tstdata['class'])
print "accuracy of model", (100 - percentError(out,tstdata['class']))

# to predict how well model performs
#np.array([net.activate(x) for x,_ in tstdata])
# or 
#out = net.activateOnDataset(tstdata)
# shape the neuron output to output class, so that highest output activation
#gives the class[0,1,2]
# out.argmax(axis=1)

# perform the same analysis on validation data
vl_out = net.activateOnDataset(validdata).argmax(axis=1)
print "percentage error on valid data",percentError(vl_out,validdata['class'])
print "accuracy on valid data",(100 - percentError(vl_out,validdata['class']))

# to further improve accuracy of the model build model with more number of hidden
# nodes and comput the accuracy of the model again 
