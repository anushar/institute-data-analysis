#python prog to  find LCM of numbers
def lcm(x,y):
	"""This function is returns lcm of two input numbers """
	if (x > y):
		greater = x
	else:
		greater = y
	
	while(True):
		if ((greater % x == 0) and (greater % y == 0)):
			lcm = greater
			break
		greater += 1
	return lcm

"""for i in range(1,greater+1):
		if ((x%i == 0) and (y%i == 0)):
			lcm = i
	return lcm
	"""

x = int(raw_input("enter first number"))
y = int(raw_input("enter second number"))
print "LCM of ",x,"and ",y,"is ",lcm(x,y)
	