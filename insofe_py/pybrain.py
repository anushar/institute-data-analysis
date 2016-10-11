# -*- coding: utf-8 -*-
"""
Created on Thu Jul 30 12:04:46 2015

@author: Anusha
"""
### ref ###
#http://corpocrat.com/2014/10/10/tutorial-pybrain-neural-network-for-classifying-olivetti-faces/
#http://www.360doc.com/content/14/1203/23/60849_430239390.shtml
###
import mydata
import pandas as pd
from pybrain.datasets.classification import ClassificationDataSet
#from pybrain.datasets import ClassificationDataSet
from pybrain.utilities           import percentError
from pybrain.tools.shortcuts     import buildNetwork
from pybrain.supervised.trainers import BackpropTrainer
from pybrain.structure.modules   import SoftmaxLayer

(X,y) = mydata.data_parse()
print X.shape
#basically to use addSample our input should be of type ndarray to convert we use below commands
X = pd.DataFrame.as_matrix(X)
y = pd.Series.as_matrix(y)
#print "datatypes",type(X),type(y)

ds = ClassificationDataSet(13,1,nb_classes = 2)
for i in range(len(X)):
    ds.addSample(X[i],y[i])

# since X has 13 columns our nput of nueral network are 13 nodes
#ds = pyd.ClassificationDataSet(13, 1 , nb_classes=2) #,class_labels=['yes','no'])
#print ds
# ravel is used for ordering and joining into 1-D array
#for i in range(len(X)):
#    ds.addSample(X[i],y[i])

# splitting data into test and train
tstdata, trndata = ds.splitWithProportion( 0.30 )
# converts one to 2 binary outputs,assign each output to one neuron
trndata._convertToOneOfMany( )
tstdata._convertToOneOfMany( )
print trndata['input'], trndata['target'], tstdata.indim, tstdata.outdim

# original target values are stored in class created by function to
#preserve the value
print trndata['class']
# new values of target after convertion
print trndata['target']


fnn = buildNetwork( trndata.indim, trndata.outdim, outclass=SoftmaxLayer )
#The learning rate gives the ratio of which parameters are changed into the direction of the gradient. The learning rate 
#decreases by lrdecay, which is used to to multiply the learning rate after each training step. The parameters are also adjusted
# with respect to momentum, which is the ratio by which the gradient of the last timestep is used.
#If batchlearning is set, the parameters are updated only at the end of each epoch. Default is False.
#weightdecay corresponds to the weightdecay rate, where 0 is no weight decay at all.
trainer = BackpropTrainer( fnn, dataset=trndata, momentum=0.1, learningrate=0.01 , verbose=True, weightdecay=0.01) 
trainer.trainEpochs (50)
print 'Percent Error on Test dataset: ' , percentError( trainer.testOnClassData (
           dataset=tstdata )
           , tstdata['class'] )

