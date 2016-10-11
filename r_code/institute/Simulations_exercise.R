A company wants to decide whether they should outsource the product development 
or should build in-house.  The operations team estimated the following per 
component: 
If they want to produce in-house they can make 25,000 to 45,000 components in a year with the following:
raw material will cost between $4 to 10
labor will cost between $2 to 10.
maintenance cost will be between $15-20. 
They found a vendor who agreed to supply the component for $25.  
Help the company in taking the decision.
--------------------------------------------------------------------------
PVR Cinemas has 40 screens across India and the number of seats 
per screen vary from 75-125. All movie tickets are sold in advance 
and the manager notices that for any show 70% -100% of the buyers show up! 
Mr. A, chairman and MD, wants to take the advantage of this and wants to 
sell more tickets. How much revenue can he expect if the ticket 
value varies from Rs150-Rs 250? Assume that there will be 4-6 shows 
per day in all screens and works for 300-325 days in a year. 
----------------------------------------------------------------------------
  
rm(list=ls(all=TRUE))

maint = c(8,20)
lab= c(2,10)
rawMat = c(4,10)
prodLevel = c(25000,45000)
outSource = 25

?runif
##sample can be used instead of runif here because sample creates 
##integer values between the range whereas runif creates decimal
##values between the given range.

maint= runif(10000,maint[1], maint[2])
#maint = runif(5000,8,20)
lab= runif(10000,lab[1], lab[2])
#lab=runinf(10000,2,10)
#rawMat= runif(10000,rawMat[1], rawMat[2])
rawMat = runif(10000,4,10)
#prodLevel= runif(10000,prodLevel[1], prodLevel[2])
prodLevel = sample(prodLevel[1]:prodLevel[2],10000)
inHouseCost=(maint + lab + rawMat) * prodLevel
outSourceCost= prodLevel*outSource
difference = inHouseCost-outSourceCost
#negdiff indicates in how many instances the outsource cost is > inhouse cost
#count the number of instances difference is < 0
negdiff = length(difference[difference<0])
negdiff
mean(inHouseCost)
mean(outSourceCost)

#percentage
perc_mean=mean(outSourceCost)/mean(inHouseCost)*100
perc_mean
##since inhouse cost mean > outsource cost mean,its better to produce the product outside
#------------------------------------------------------------------------------------

###PVR cinemas solution######
rm(list=ls(all=TRUE))
nseats = c(75,125)
nturnup = c(0.7,1)
nnoturnup = c(0,0.3)
#ticket rice is either 150 or 250Rs
tkvallue= c(150,250)
nshow = c(4,6)
ndays = c(300,325)

nseats_r = sample(nseats[1]:nseats[2],10000,replace=TRUE)
#nseats_r =runif(10,nseats[1],nseats[2])
nseats_r
nturnup =runif(10000,nturnup[1],nturnup[2])
nnoturnup =runif(10000,nnoturnup[1],nnoturnup[2])
rand_tktp = sample(c(150,250),10000,replace = TRUE)
rand_tktp
nshow = sample(nshow[1]:nshow[2],10000,replace = TRUE)
#nshow
ndays = sample(ndays[1]:ndays[2],10000,replace = TRUE)

noturnup_no = nnoturnup*nseats_r
#noturnup_int = integer(noturnup_no)
turnup_revenue = nturnup*rand_tktp*nshow*ndays*40
mean(turnup_revenue)
noturnup_revenue = noturnup_no*rand_tktp*nshow*ndays*40 #multiply by number of screens
mean(noturnup_revenue)


diff_mean =(mean(noturnup_revenue)-mean(turnup_revenue))
y=(diff_mean/mean(turnup_revenue))
y





