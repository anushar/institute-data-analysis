x=[[12,7],[4,5],[3,8]]
res=[None]*(len(x[0]))
for i in range(len(x[0])):
	res[i]=[None]*len(x)
	for j in range(len(x)):
		res[i][j]=x[j][i]
print res