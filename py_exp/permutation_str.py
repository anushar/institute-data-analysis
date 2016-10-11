#code to check if one string is permutation of the other
def compa(l,k):
	if (len(l) != len(k)):
		return "not permutation of the other"
	else:
		k2=''.join(sorted(k)) #as sorted function returns a list
		l2= ''.join(sorted(l))
		if (l2 != k2):
			return "not permutation of the other"
		return "permutation of the other"

x = raw_input("Enter 1 string: ")
y = raw_input("Enter 2 string: ")
print "strings x and y are",compa(x,y)