def fact(x):    
    if x == 0:
   	 return 1
    else:
   	 return x * fact(x - 1)

x =int(raw_input("enter n value"))
print (fact(x))