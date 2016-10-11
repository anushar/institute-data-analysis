import pandas as pd
import numpy as np
import csv
#from urllib import urlopen
import matplotlib.pyplot as plt

##use first column as row _names and parse them as dates
#stck = pd.read_csv("money-stock.csv", index_col=0, parse_dates = True)
#print stck

##working
#print(open('money-stock.csv').read())

#didn't work
#ts= pd.read_csv('money-stock.csv')
#print(ts.columns)

#page= urlopen("http://econpy.pythonanywhere.com/ex/NFL_1979.csv")
ts=pd.read_csv('NFL_1979.csv',index_col=0,parse_dates=True)
#print ts

### we can access required rows by giving indices using below command
#print(ts[1:3])

#we can print first 5 elements of data using head() command
#print(ts.head())

#we can just get the  required columns printed by giving their names instead of indices
#print(ts.loc[:,['Visitor Score','Home Score']])

bd=ts.loc[:,['Visitor Score','Home Score']]
bd=bd.T
print(bd.describe())

#bd.plot(x='Visitor Score',y='Home Score')
plt.plot([1,2,3,4],[1,4,9,16],'ro')
plt.axis([0,6,0,20])
plt.show()

