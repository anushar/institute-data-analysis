# -*- coding: utf-8 -*-
"""
Created on Wed Jul 29 16:14:59 2015

@author: Anusha
"""
import numpy as np
import neurolab as nl
# Create train samples
input = np.random.uniform(-0.5, 0.5, (10, 2))
print input
target = (input[:, 0] + input[:, 1]).reshape(10, 1)
# Create network with 2 inputs, 5 neurons in input/hidden layer and 1 in output layer
# input range for each input [-0.5 0.5],2 layers including hidden layer and output layer
net = nl.net.newff([[-0.5, 0.5], [-0.5, 0.5]], [5, 1])
print "number of input nodes:",net.ci
print "number of output nodes:",net.co
print "number of layers of the network:",len(net.layers)
# Train process
err = net.train(input, target, show=15)
print "error matrix",err
print "value of new data",net.sim([[0.2, 0.1]]) # 0.2 + 0.1