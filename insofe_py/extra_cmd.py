# -*- coding: utf-8 -*-
"""
Created on Sun Jul 12 21:50:02 2015

@author: bharath
"""
learn:
http://www.analyticsvidhya.com/blog/2015/04/pycon-montreal-2015-data-science-workshops/
https://www.kaggle.com/wiki/Tutorials
ggplot:
    https://mandymejia.wordpress.com/2013/11/13/10-reasons-to-switch-to-ggplot-7/
    
#import matplotlib.pyplot as plt
#from patsy import dmatrices
#from sklearn.linear_model import LogisticRegression
#from sklearn.cross_validation import train_test_split
#from sklearn import metrics
#from sklearn.cross_validation import cross_val_score

# extra code not required
#dummy_loan = pd.get_dummies(ub_data['Personal Loan'],prefix='loan')
#print dummy_loan.head()
#ub_data['Personal Loan'] = ub_data['Personal Loan'].astype('category')
#print ub_data.describe()
#dummy_securities = pd.get_dummies(ub_data['Securities Account'],prefix='securities')
#model_logit = sm.formula.glm(formula='Personal Loan ~ Age + Experience + Income + Mortgage\
#                Securities Account + CreditCard + Online',data=ub_data,\
#                family=sm.families.Binomial()).fit()
#logit_formula = ('Personal Loan~ Age + Experience + Income + Mortgage\
#                Securities Account + CreditCard + Online')
#model_logit = sm.GLM.from_formula(formula=logit_formula,data=ub_data,\
#                family=sm.families.Binomial()).fit()

tsa1

#model = sm.tsa.ARIMA(kd,order=(1,1,1),freq='M').fit(full_output=False,disp=0)
#model = sm.tsa.ARIMA(kd,order=(2,1,2),freq='M').fit()

#tst = sm.tsa.adfuller(kd)
#print 'prob value:', tst[1]

http://scikit-learn.org/stable/auto_examples/linear_model/plot_ols.html
http://blog.yhathq.com/posts/predicting-customer-churn-with-sklearn.html

http://nbviewer.ipython.org/gist/ChadFulton/5127108f4c7025ed2648
http://www.stata.com/manuals13/tsarima.pdf
http://stackoverflow.com/questions/25044165/python-arima-exogenous-variable-out-of-sample
http://www.statoek.wiso.uni-goettingen.de/veranstaltungen/zeitreihen/sommer03/ts_r_intro.pdf
https://a-little-book-of-r-for-time-series.readthedocs.org/en/latest/src/timeseries.html
