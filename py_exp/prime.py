#!/usr/bin/python
n = int(raw_input("enter the number: "))
for i in range(2,n):
	if(n%i == 0):
		print n,"is not prime number"
		break
else:
	print n,"is prime number"

