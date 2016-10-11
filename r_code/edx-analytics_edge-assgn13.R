CPS = read.csv("CPSData.csv",header=T)
summary(CPS)
table(CPS$Industry)
sort(table(CPS$State))
table(CPS$Citizenship)
table(CPS$Hispanic,CPS$Race)
table(CPS$Race,CPS$Hispanic)
table(CPS$Region,is.na(CPS$Married))
table(CPS$Age,is.na(CPS$Married))
table(CPS$Sex,is.na(CPS$Married))
table(CPS$Citizenship,is.na(CPS$Married))
table(CPS$State,is.na(CPS$MetroAreaCode))
table(CPS$Region,is.na(CPS$MetroAreaCode))
###tapply(CPS$State,is.na(CPS$MetroAreaCode),mean)
sort(tapply(is.na(CPS$MetroAreaCode),CPS$State,mean))

MetroAreaMap = read.csv("MetroAreaCodes.csv",header =T)
CountryMap = read.csv("CountryCodes.csv",header = T)
###merging 2 tables
CPS = merge(CPS, MetroAreaMap, by.x="MetroAreaCode", by.y="Code", all.x=TRUE)
summary(CPS)
sort(table(CPS$MetroArea))
sort(tapply(CPS$Hispanic,CPS$MetroArea,mean))
##
sort(tapply(CPS$Race == "Asian", CPS$MetroArea, mean))

sort(tapply(CPS$Education == "No high school diploma", CPS$MetroArea, mean,na.rm=TRUE))

CPS = merge(CPS,CountryMap, by.x="CountryOfBirthCode", by.y="Code", all.x=TRUE)
summary(CPS)

sort(table(CPS$Country.x))

#sort(tapply(CPS$MetroArea == "New York-Northern New Jersey-Long Island, NY-NJ-PA",CPS$Country.x,mean,rm.na=TRUE))

table(CPS$MetroArea =="New York-Northern New Jersey-Long Island, NY-NJ-PA", CPS$Country.x != "United States")

sort(tapply(CPS$Country.x =="India",CPS$MetroArea,sum,rm.na=TRUE))
sort(tapply(CPS$Country.x =="Brazil",CPS$MetroArea,sum,rm.na=TRUE))
sort(tapply(CPS$Country.x =="Somalia",CPS$MetroArea,sum,rm.na=TRUE))

###another way###
which.max(table(CPS$MetroArea,CPS$Country.x == "Somalia" & !is.na(CPS$Country.x), exclude=FALSE))
#output of above command is 160
CPS$MetroArea[160]
###########
