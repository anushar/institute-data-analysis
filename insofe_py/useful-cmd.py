# -*- coding: utf-8 -*-
"""
Created on Tue Jul 14 10:43:20 2015
"""
# drop column based on na numbers
meat = meat.dropna(thresh=800, axis=1) # drop columns that have fewer than 800 observations
# set dates as row names
ts = meat.set_index(['date'])
# group data based on particular year and find sum of clumns on a year
the1940s = ts.groupby(ts.index.year).sum().ix['1940-01-01':'1949-12-31']

#################################################
'''
simple exponential smoothing
go back to last N values
y_t = a * y_t + a * (1-a)^1 * y_t-1 + a * (1-a)^2 * y_t-2 + ... + a*(1-a)^n * y_t-n
'''
from random import random,randint

def gen_weights(a,N):
    ws = list()
    for i in range(N):
        w = a * ((1-a)**i)
        ws.append(w)
    return ws

def weighted(data,ws):
    wt = list()
    for i,x in enumerate(data):
        wt.append(x*ws[i])
    return wt

N = 10
a = 0.5
ws = gen_weights(a,N)
data = [randint(0,100) for r in xrange(N)]
weighted_data = weighted(data,ws)
print 'data: ',data
print 'weights: ',ws
print 'weighted data: ',weighted_data
print 'weighted avg: ',sum(weighted_data)
#################################################################
# decompose time series data
import statsmodels.api as sm

dta = sm.datasets.co2.load_pandas().data
# deal with missing values. see issue
dta.co2.interpolate(inplace=True)

res = sm.tsa.seasonal_decompose(dta.co2)
resplot = res.plot()
#You can then recover the individual components of the decomposition from:

res.resid
res.seasonal
res.trend
#######################################
# divide data into test and train
# put 2012,2013 and 2014 as train and 2015 as test data
train = tsdata[tsdata['year'] < 2015]
test = tsdata[tsdata['year'] == 2015]
##################################################
#### forward prop neural net
class Neural_Network(object):
    def _init_(self):
        # define number of nodes in each layer
        self.inputLayerSize = 2
        self.outputLayerSize =1
        self.hiddenLayerSize = 3
        
        #Weights (parameters)
        #generate random normal weights of array size given by arguments
        self.W1 = np.random.randn(self.inputLayerSize, self.hiddenLayerSize)
        self.W2 = np.random.randn(self.hiddenLayerSize, self.outputLayerSize)
    
    def forward(self, X):
        #propogate inputs through network
        self.z2 = np.dot(X, self.W1)
        self.a2 = self.sigmoid(self.z2)
        self.z3 = np.dot(self.a2, self.W2)
        yHat = self.sigmoid(self.z3) 
        return yHat
        
    def sigmoid(self, z):
    #Apply sigmoid activation function to scalar, vector, or matrix
        return 1/(1+np.exp(-z))
#############################################################
        