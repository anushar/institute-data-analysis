# vectors have variables of _one_ type
c(1, 2, "three")
# shorter arguments are recycled
(1:3) * 2
(1:4) * c(1, 2)
# warning! (why?)
(1:4) * (1:3)

(1:3)*(1:3)
####################################
x <- list(values=sin(1:3), ids=letters[1:3], sub=list(foo=42,bar=13))
x # print the list
x$values   # Get one element
x[["ids"]] # Another way to get an element
x$sub$foo  # Get sub elements
x[[c(3,2)]]  # Another way (gets 13)
str(x)  
x[c(3,2)] #gives 2 rows elements in the output
x[c(1,3)] #gives 1 and 3 row elemensts in the output
x[[2]] #just gives 2nd row elemnets as output
x[[c(1,3)]] ##gives 1st row 3rd column value
##x[[1,3]] is an error

