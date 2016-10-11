shampoo <- read.csv("ShampooSales.csv", header=T, sep=",")
shampoo
shampootimeseries <- ts(shampoo, 
                       frequency=12, 
                       start=c(1,1))
shampootimeseries
plot(shampootimeseries)
