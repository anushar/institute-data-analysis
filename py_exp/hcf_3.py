#define hcf of 3 numbers
def hcf(x,y,z):
	if((y>x) and (z>x)):
		smaller = x
	elif((x>y) and (z>y)):
		smaller = y
	else:
		smaller = z
	for i in range (1,smaller+1):
		if ((x%i==0)and(y%i==0)and(z%i==0)):
			hcf = i
	return hcf

x = int(raw_input("enter a number"))
y = int (raw_input("enter second number"))
z = int (raw_input("enter third number"))
print "HCF of",x,"and",y,"and",z,"is",hcf(x,y,z)
		