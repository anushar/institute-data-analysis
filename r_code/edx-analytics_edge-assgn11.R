mvt = read.csv("mvtWeek1.csv",header = T)
str(mvt)
summary(mvt)
mvt$Date[2]
DateConvert = as.Date(strptime(mvt$Date, "%m/%d/%y %H:%M"))
median(DateConvert)
mvt$Month = months(DateConvert)
mvt$Weekday = weekdays(DateConvert) #converts to what day it is
mvt$Date = DateConvert
which.min(table(mvt$Month))
which.max(table(mvt$Weekday))
(table(mvt$Month,mvt$Arrest))
hist(mvt$Date, breaks=100)
boxplot(mvt$Date ~ mvt$Arrest)
summary(mvt$Arrest)
table(mvt$Arrest,mvt$Year)
#Problem 3.3
///
  #For what proportion of motor vehicle thefts in 2001 was an arrest made?
  #If you create a table using the command table(mvt$Arrest, mvt$Year), the 
  #column for 2001 has 2152 observations with Arrest=TRUE and 18517 observations 
  #with Arrest=FALSE. The fraction of motor vehicle thefts in 2001 for which an 
  #arrest was made is thus 2152/(2152+18517) = 0.1041173.
///

  sort(table(mvt$LocationDescription))
#problem 4.2
Top5 = subset(mvt,mvt$LocationDescription == "STREET" | mvt$LocationDescription =="PARKING LOT/GARAGE(NON.RESID.)" |
                mvt$LocationDescription == "ALLEY" | mvt$LocationDescription=="GAS STATION" | mvt$LocationDescription == "DRIVEWAY - RESIDENTIAL")
str(Top5)
 #another way
  #TopLocations = c("STREET", "PARKING LOT/GARAGE(NON.RESID.)", "ALLEY", "GAS STATION", "DRIVEWAY - RESIDENTIAL")

#Top5 = subset(mvt, LocationDescription %in% TopLocations)
  
  table(Top5$LocationDescription)
str(Top5$LocationDescription)
Top5$LocationDescription = factor(Top5$LocationDescription)
Top5$LocationDescription
#Problem 4.4
top_gas = subset(Top5,Top5$LocationDescription == "GAS STATION")
sort(table(top_gas$Weekday))
 #another way to do
  #table(Top5$LocationDescription, Top5$Weekday)

  
