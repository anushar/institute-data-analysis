# Pandas library is used for data munging and preparation of data for analysis
# http://pandas-docs.github.io/pandas-docs-travis/
# matplotlib library is used for plotting graphs, pyplot is used to plot graphs
# similar to matlab.
# statsomodels library is used for modelling the data like linear,logistic etc
# Import os library to deal with local filesystem
# reference link: http://blog.yhathq.com/posts/logistic-regression-and-python.html

import numpy as np
import pandas as pd
import statsmodels.api as sm
import os

# change the current working directory 
os.chdir("C:\\Users\\bharath\\Desktop\\insofe-py")


# read_csv can be used for other than comma separated files as well using sep='tab
# space or other', by default header=0 is taken to read first row as column names
# header =int is used to specify row numbers to take as column names,we can specify
# different datatypes for columns using dtype=,
# read UnivBank data as data frame in pandas
ub_data = pd.read_csv('UnivBank.csv')
print ub_data.head()
print len(ub_data)

# remove Id and zipcode columns from the data
#ub_data.iloc[] is used to locate column numbers using integer values
# .loc[] is used to locate column numbers using column names,.ix[] is used to
# locate columns using both integers and strings
ub_data = pd.concat([ub_data.ix[:,[1,2,3]], ub_data.ix[:,5:]],axis=1)
print ub_data.describe()

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

# manually add intercept to the model
model_x['intercept']=1.0

loan_data = ub_data['Personal Loan']

# create a table of Loan
print "###  Personal Loan size  ###\n",ub_data.groupby('Personal Loan').size()

# build logistic model on data
# command syntax sm.Logit(depeddent variable, independent variable)
log_mod = sm.Logit(ub_data['Personal Loan'],model_x).fit()
print log_mod.summary()

# other way to perform logistic regression using statsmodels
model_logit = sm.GLM(loan_data,model_x,family=sm.families.Binomial()).fit()
print model_logit.summary()


# split data into test and train sets
# split data into test and train data. with 80% data as train data and 20% test
# data

rnd = np.random.rand(len(model_x)) < 0.8
train_data = model_x.ix[rnd]
test_data = model_x.ix[~rnd]
y_train = loan_data[rnd]
y_test = loan_data[~rnd]

# build logistic regression on train data
train_model = sm.GLM(y_train,train_data,family=sm.families.Binomial()).fit()
print train_model.summary()

# make predictions on train and test data
pred_train = train_model.predict()
pred_test = train_model.predict(test_data)

# create a dataframe
lt = pd.DataFrame({'trainpred':pred_train, 'Loan':y_train})
# use graoupby coand to create table of loan and trainppred
print lt.groupby('Loan')['trainpred'].mean()
# Confusion matrix on threshold 0.5

lt['yes'] = lt['trainpred'] >= 0.5
print "confusion matrix:\n",lt.groupby(['Loan','yes']).size()

# for accuracy we need to import scikit-learn metrics
from sklearn.metrics import roc_curve, auc, accuracy_score
# Calculate true positive rate,false positive rate and threshold values
fpr,tpr, thresholds = roc_curve(lt['Loan'] == 1,lt['trainpred'])
print "True positive rate:",tpr.mean()
print "False positive rate:",fpr.mean()
print "threshold value:",thresholds.mean()
#print "Accuracy of the model:",accuracy_score(y_test,pred_test)

# area under curve value
roc_auc_value = auc(fpr,tpr)

# for plotting ROC curve we need to import matplotlib
import matplotlib.pyplot as plt

plt.plot(fpr,tpr,label = 'ROC curve')
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')

plt.show()







