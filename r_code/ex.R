WHO=read.csv("WHO.csv")
str(WHO)
summary(WHO)
WHO_europe = subset(WHO, Region == "Europe")
write.csv(WHO_europe, "who_europe.csv")
plot(WHO$GNI, WHO$FertilityRate)
mean(WHO$Over60)
which.min(WHO$Over60)
#WHO$Country[183]
WHO$Country[which.min(WHO$Over60)]
WHO$Country[which.max(WHO$LiteracyRate)]
hist(WHO$CellularSubscribers)
boxplot(WHO$LifeExpectancy ~ WHO$Region, xlab="",ylab="Life Expectancy",main="life expectancy over region")
table(WHO$Region)
tapply(WHO$ChildMortality,WHO$Region,mean)
WHO$Population[match("Europe",WHO$Region)]
