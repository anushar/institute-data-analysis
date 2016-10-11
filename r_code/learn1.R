air_data = read.csv("Airfares.csv")
summary(air_data)
str(air_data)
#names(air_data)
air_data = air_data[,-19]
#v=dim(air_data[,])
#v[2]
class(air_data)
for (x in colnames(air_data)){
  class(air_data$x)
}
head(air_data)
names(air_data)
tail(air_data)
col.class(air_data)
air_data$S_INCOME = gsub("[$,]","",air_data$S_INCOME)
##class(air_data$S_INCOME)
air_data$S_INCOME = as.numeric(air_data$S_INCOME)

###air_data = gsub("[$,.]","",air_data) not possible
###"$" %in% air_data$E_INCOME doesn't work

air_data[,c(11,18)] = as.numeric(gsub("[$,.]","",as.matrix(air_data[,c(11,18)])))
### above one worked

##other way of doing it
#air_data <- as.data.frame(sapply(air_data,gsub,pattern="[$,.]",replacement=""))
#we have to convert the tables into numeric form after ove command if required,as 
#above command converted everything into categorical data



