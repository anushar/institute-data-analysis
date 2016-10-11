# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 15:15:33 2015

@author: Anusha
"""

import pandas as pd
import os
# module used to slit data into test and train sets
from sklearn.cross_validation import train_test_split

def data_parse():
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
                 'CD Account','CreditCard','Online']
    X = ub_data[cols_reqd].join(dummy_edu.ix[:,'edu_2':]).join(dummy_family.ix[:,'family_2':])
    print X.head()
    return(X,ub_data['Personal Loan'])

def  split_data(X,y):


    # construct the training/testing split
    (X_train, X_test, Y_train, Y_test) = train_test_split(X,y,test_size = 0.5, random_state = 42)
    return(X_train,X_test,Y_train,Y_test)    
    #############################################
