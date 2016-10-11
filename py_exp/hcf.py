# python code to find hcf of two numbers
def hcf(x,y):
	if (x > y):
		smaller = y
	else:
		smaller = x
	for i in range(1,smaller+1):
		if ((x%i == 0) and (y%i == 0)):
			hcf = i
			
	return hcf

x = int(raw_input("enter a number"))
y = int (raw_input("enter second number"))
print "HCF of ",x,"and ",y,"is ",hcf(x,y)