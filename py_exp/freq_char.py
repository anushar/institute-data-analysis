string = raw_input("Enter the string to search :")
cha = raw_input("Enter character to be searched :")
sub_str = raw_input("Enter substring :")
count = 0
for c in string:
	if(c==cha):
		count+= 1
if(count >= 1):
	print cha," is found in ",string," ",count," times"
else:
	print cha," is not found in ",string

print "occurance of substring ",string.count(sub_str)

