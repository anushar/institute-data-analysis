#import pandas library to 

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import statsmodels.api as sm

ts=pd.Series(np.random.randn(1000),index=pd.date_range('1/1/1990',periods=1000))
bd=pd.DataFrame(np.random.randn(1000, 6)**3, index=ts.index, columns=list('ABCDEF'))
#bd = bd.cumsum()
#plt.figure();#not necessary
#bd.plot();
#plt.show()
#print bd

kd = bd.loc[:,['A']]
kd = kd.resample('M',how='mean')
kd.plot()
plt.show() 

#print(kd.head())

fig = plt.figure(figsize=(12,8))
ax1 = fig.add_subplot(211)
fig = sm.graphics.tsa.plot_acf(kd, lags=25, ax=ax1)
ax2 = fig.add_subplot(212)
fig = sm.graphics.tsa.plot_pacf(kd, lags=25, ax=ax2)
plt.show()

kdd =kd.describe()
print kdd
kd.hist()
plt.show()
#print 'v = %f' %(kdd['std']/kdd['mean'])

#tst = sm.tsa.adfuller(kd)
#print 'prob value:', tst[1]

#model = sm.tsa.ARIMA(kd,order=(1,1,1),freq='M').fit(full_output=False,disp=0)
model = sm.tsa.ARIMA(kd,order=(2,1,2),freq='M').fit()
print model.summary()