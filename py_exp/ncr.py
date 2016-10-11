def fact(x):    
    if x == 0:
   	 return 1
    else:
   	 return x * fact(x - 1)

print "enter the numbers for which you need a factorial"
x =int(raw_input("enter n value"))
y =int(raw_input("enter r value"))
ncr_value = fact(x)/(fact(x-y)*fact(y))
print "n fact r value : ",ncr_value
#print fact(x)
