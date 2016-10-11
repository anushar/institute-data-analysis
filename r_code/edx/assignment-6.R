kos = read.csv("dailykos.csv",header = T)
dista = dist(kos,method = "euclidean")
kos_cluster = hclust(dista,method = "ward.D")
plot(kos_cluster) # plot dendogram to find numbe rof optimal clusters
kosGroups = cutree(kos_cluster,k=7)
kos1 = subset(kos,kosGroups == 1)
kos2 = subset(kos,kosGroups == 2)
kos3 = subset(kos,kosGroups == 3)
kos4 = subset(kos,kosGroups == 4)
kos5 = subset(kos,kosGroups == 5)
kos6 = subset(kos,kosGroups == 6)
kos7 = subset(kos,kosGroups == 7)

table(kosGroups)
#for (k in seq(6,7,by = 1)){
#  kosk = subset(kos,kosGroups == k)}
## to find most frequent words
tail(sort(colMeans(kos1)))
tail(sort(colMeans(kos2)))
tail(sort(colMeans(kos7)))
tail(sort(colMeans(kos3)))
tail(sort(colMeans(kos4)))
tail(sort(colMeans(kos5)))
tail(sort(colMeans(kos6)))


## k-means
set.seed(1000)
kmkos = kmeans(kos,centers = 7)
table(kmkos$cluster)
tail(sort(colMeans(subset(kos,kmkos$cluster == 1))))
tail(sort(colMeans(subset(kos,kmkos$cluster == 2))))
tail(sort(colMeans(subset(kos,kmkos$cluster == 3))))
tail(sort(colMeans(subset(kos,kmkos$cluster == 4))))
tail(sort(colMeans(subset(kos,kmkos$cluster == 5))))
tail(sort(colMeans(subset(kos,kmkos$cluster == 6))))
tail(sort(colMeans(subset(kos,kmkos$cluster == 7))))

table(kosGroups,kmkos$cluster)


###### 2nd one ##########
setwd("C:\\Users\\bharath\\Desktop\\insofe\\R code\\edx")
airlines = read.csv("AirlinesCluster.csv",header = T)
summary(airlines)

# normalise the data
#install.packages("caret")
library(caret)
pairl = preProcess(airlines)
airnorm = predict(pairl,airlines)
summary(airnorm)
aird = dist(airnorm,method = "euclidean")
airg = hclust(aird,method = "ward.D")
plot(airg)
airgr = cutree(airg,k=5)
table(airgr)
tapply(airnorm$balance, airgr, mean)
