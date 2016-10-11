li=[45,36,89,234,5,90,3,67]
print "initial list",li
for i in range(len(li)):
	min=li[i]
	print min,li[i]
	for j in range(i+1,len(li)):
		if (min > li[j]):
			min = li[j]
			print min,li[j]
		li[j] = li[i]
		li[i] = min
	print min,li[j],li[i]
print "sorted list",li
	
