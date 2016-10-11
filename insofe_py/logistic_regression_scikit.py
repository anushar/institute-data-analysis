# referene link: http://nbviewer.ipython.org/github/justmarkham/gadsdc1/blob/master/logistic_assignment/kevin_logistic_sklearn.ipynb
# Pandas library is used for data munging and preparation of data for analysis
# http://pandas-docs.github.io/pandas-docs-travis/
# matplotlib library is used for plotting graphs, pyplot is used to plot graphs
# similar to matlab.
# statsomodels library is used for modelling the data like linear,logistic etc
# Import os library to deal with local filesystem
# import scikit-learn library to perform logistc regression and calculate other metrics of the model
import numpy as np
import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression
# train_test_split module is used to split data into test and train data sets
from sklearn.cross_validation import train_test_split
from sklearn import metrics
import os

# change the current working directory 
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")

# read UnivBank data as data frame in pandas
ub_data = pd.read_csv('UnivBank.csv')
print ub_data.head()
print len(ub_data)

# one way of converting categorical data into dummy variables
#from patsy import dmatrices
#y, x = dmatrices('Personal Loan ~ (Age + Experience + C(Family) + Mortgage \
#    + C(Education) + Securities Account + CreditCard + Online)',ub_data, \
#    return_type="dataframe")
#print x.columns

# remove Id and zipcode columns from the data
#ub_data.iloc[] is used to locate column numbers using integer values
# .loc[] is used to locate column numbers using column names,.ix[] is used to
# locate columns using both integers and strings
ub_data = pd.concat([ub_data.ix[:,[1,2,3]], ub_data.ix[:,5:]],axis=1)
print ub_data.describe()

# prepare data for logistic regression by introducing dummy variables for categorical
# attributes
# convert education column as dummy variable
dummy_edu = pd.get_dummies(ub_data['Education'],prefix='edu')
print dummy_edu.head()

# convert family column as dummy variable
dummy_family = pd.get_dummies(ub_data['Family'],prefix='family')


# construct data frame with required nd dummy variables
cols_reqd = ['Age','Experience','Income','Mortgage','Securities Account',
             'CD Account','CreditCard','Online']
model_x = ub_data[cols_reqd].join(dummy_edu.ix[:,'edu_2':]).join(dummy_family.ix[:,'family_2':])
print model_x.head()

# instantiate a logistic regression model, and fit with X and y
model = LogisticRegression()
model = model.fit(model_x, ub_data['Personal Loan'])

# store attribute of interest as y
y = ub_data['Personal Loan']

# check the accuracy on the training set
print "mean accuracy:",model.score(model_x,ub_data['Personal Loan'])

# coeeficients of model
coef = pd.DataFrame(zip(model_x.columns, np.transpose(model.coef_)))
print "coefficients of model",coef

# evaluate the model by splitting into train and test sets
model_x_train, model_x_test, y_train, y_test = train_test_split(model_x, y, test_size=0.2, random_state=0)
model2 = LogisticRegression()
# build logistic regression model on train data
print model2.fit(model_x_train, y_train)

# predictions for test set
pre = model2.predict(model_x_test)

# generate test probabilities
prob = model2.predict_proba(model_x_test)
print prob

# metrics of model
print "Accuracyof model:",metrics.accuracy_score(y_test, pre)
print metrics.roc_auc_score(y_test, prob[:, 1])

# confusion matrix and preciion,recall etc
print "confusion matrix",metrics.confusion_matrix(y_test, pre)
print "classification",metrics.classification_report(y_test, pre)