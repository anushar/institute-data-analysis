# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 14:21:04 2015

@author: anusha
"""
import numpy as np

## X is array of elements studyhrs,sleephrs
X = np.array(([3,5],[5,1],[10,2]),dtype = float)
# Y is array of marks obtaine din the exam
y = np.array(([75],[82],[93]),dtype= float)

## to standardize both the values divide by max value of the array
X = X/np.amax(X,axis=0)
y = y/100 #since 100 is ma marks obtained in the exam

## print the shape of both the arrays
print X.shape,y.shape

# define number of nodes in each layer
inputLayerSize = 2
outputLayerSize =1
hiddenLayerSize = 3
        
#Weights (parameters)
#generate random normal weights of array size given by arguments
W1 = np.random.randn(inputLayerSize, hiddenLayerSize)
W2 = np.random.randn(hiddenLayerSize, outputLayerSize)

def sigmoid(z):
    #Apply sigmoid activation function to scalar, vector, or matrix
    return 1/(1+np.exp(-z))
    
def forward(X):
    #propogate inputs through network
    z2 = np.dot(X, W1)
    a2 = sigmoid(z2)
    z3 = np.dot(a2,W2)
    yHat = sigmoid(z3) 
    return yHat
        
Out_y = forward(X)
print "expected results:\n",Out_y
print "Actual Results:\n",y

   
#testInput = np.arange(-6,6,0.01)
#plot(testInput, Neural_Network.sigmoid(testInput), linewidth= 2)
#grid(1)


#http://scikit-learn.org/stable/auto_examples/neural_networks/plot_rbm_logistic_classification.html
#http://rolisz.ro/2013/04/18/neural-networks-in-python/

import sklearn