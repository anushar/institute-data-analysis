aList = [123, 'xyz', 'zara', 'abc', 123];
bList = [2009, 'manni'];
aList.extend(bList)

print "Extended List : ", aList ;

# Open a file
fo = open("foo.txt", "wb")
fo.write( "Python is a great language.\n Yeah its great!!\n");

# Close opend file
fo.close()

# Open a file
fo = open("foo.txt", "r+")
str = fo.read(20);
print "Read String is : ", str
# Close opend file
fo.close()

x=8
assert (x>6),"x values less than 6"
x=x+1
print " x values:",x