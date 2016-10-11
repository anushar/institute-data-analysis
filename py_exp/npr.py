def fact(x):    
    if x == 0:
   	 return 1
    else:
   	 return x * fact(x - 1)

print "enter the numbers for which you need a factorial"
x =int(raw_input("enter n value"))
y =int(raw_input("enter r value"))
npr_value = fact(x)/(fact(x-y))
print "n parmut r value : npr_value"
#print fact(x)
