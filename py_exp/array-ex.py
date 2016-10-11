from array import *
#import numpy

extend_a = array('i',[1,2,3,4,5])
print extend_a
a =array('i',[-1,0])
print a
c=[23,56]
b=a.extend(extend_a)
f=extend_a.fromlist(c)

print "extend exaple",f
