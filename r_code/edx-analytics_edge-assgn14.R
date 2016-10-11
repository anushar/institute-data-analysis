poll = read.csv("AnonymityPoll.csv",header=T)
summary(poll)
table(poll$Smartphone)
table(poll$State,poll$Region)
table(poll$Internet.Use,poll$Smartphone)

limited=subset(poll,(poll$Internet.Use == 1)|(poll$Smartphone == 1))
summary(limited)
mean(limited$Info.On.Internet,rm.na=TRUE)
table(limited$Info.On.Internet)
table(limited$Worry.About.Info)
hist(limited$Age)
max(table(limited$Age,limited$Info.On.Internet))
plot(limited$Age,limited$Info.On.Internet)
jitter(limited$Age,limited$Info.On.Internet)

plot(jitter(limited$Age), jitter(limited$Info.On.Internet),type='l')

smart = subset(limited,limited$Smartphone ==1)
mean(smart$Info.On.Internet)

nosmart = subset(limited,limited$Smartphone ==0)
mean(nosmart$Info.On.Internet)

tapply(limited$Tried.Masking.Identity, limited$Smartphone, table)
