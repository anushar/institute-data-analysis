
#####################################################################################
#####################################################################################

###Splitting Data
set.seed(88)
split = sample.split(finaldclean.13, SplitRatio = 0.90)
Train.13 = subset(finaldclean.13, split == TRUE)
Test.13 = subset(finaldclean.13, split == FALSE)

###################################################################################
###################################################################################
################Model Building

# ###Doing a Logistic Regression
Train.13$GROWTH_RATE_3YR_14 = as.factor(Train.13$GROWTH_RATE_3YR_14)
Test.13$GROWTH_RATE_3YR_14 = as.factor(Test.13$GROWTH_RATE_3YR_14)


logistic.13 <- multinom(Train.13$GROWTH_RATE_3YR_14 ~ ., data = Train.13)
pred.test.13 <- data.frame(predict(logistic.13, newdata = Test.13, "probs"))
pred.class.test.13 <- apply(pred.test.13,1,high.prob)
logi.test.13 = table(Test.13$GROWTH_RATE_3YR_14,pred.class.test.13)
pred.train.13 <- data.frame(predict(logistic.13, newdata = Train.13, "probs"))
pred.class.train.13 <- apply(pred.train.13,1,high.prob)
logi.train.13 = table(Train.13$GROWTH_RATE_3YR_14,pred.class.train.13)

sum(diag(logi.train.13))/nrow(as.data.frame(pred.class.train.13))
sum(diag(logi.test.13))/nrow(as.data.frame(pred.class.test.13))

########Decision Trees
fnComputeMetrics<-function(rulelhs,rulerhs,rulefull,dataset,actionableAttributes)
{
  
  isError=FALSE
  ErrorObj = NULL
  
  tryCatch(
{
  
  
  
  totalrow=nrow(dataset)
  
  # converting the rulelhs,rulerhs,rulefull to character
  rulelhs=as.character(rulelhs)  
  rulerhs=as.character(rulerhs)  
  rulefull=as.character(rulefull)
  
  ruleMetrics=data.frame(rulelhs,rulerhs,rulefull)
  
  ## function to calculate supported number of records of a rule
  fnsupport<-function(rule)
  {
    data.frame(rulelhs = nrow(dataset[with(dataset,eval(parse(text=as.character(rule[1])))),]),
               rulerhs = nrow(dataset[with(dataset,eval(parse(text=as.character(rule[2])))),]),
               rulefull = nrow(dataset[with(dataset,eval(parse(text=as.character(rule[3])))),]))       
  }
  
  ruleMetrics=do.call("rbind",apply(ruleMetrics,1,fnsupport))
  
  No_Of_Records_Supported = ruleMetrics[,3]
  support=round(ruleMetrics[,3]/totalrow,6)
  supportlhs=round(ruleMetrics[,1]/totalrow,6)
  supportrhs=round(ruleMetrics[,2]/totalrow ,6)  
  
  # computing the confidence of the rule
  confidence = round(support/supportlhs,6)
  
  # computing the lift of the rule
  lift = round(confidence/supportrhs ,6) 
  
  #computing harmonic mean
  
  HM_SCL=round(3*support*confidence*lift/(support*confidence+confidence*lift+support*lift),6)
  
  if(length(rulelhs)>1)
  {
    explicability=sapply(rulelhs,function(rule){
      ruleComp=str_split(rule,'%in%|&')[[1]]
      
      # getting the distinct attributes of the rule and trimming the white spaces
      ruleattributes=ruleComp[which((1:length(ruleComp))%%2!=0)]
      attributeCount=length(unique(sapply(ruleattributes,function(x){str_trim(x)})))
      #explicability = cos(attributeCount/2) - (attributeCount/3)^2
      explicability=round(1.1765 * exp(-0.163*attributeCount),6)
      return(explicability)
    })
  }else
  {
    # computing Explicability
    ruleComp=str_split(rulelhs,'%in%|&')[[1]]
    
    # getting the distinct attributes of the rule and trimming the white spaces
    ruleattributes=ruleComp[which((1:length(ruleComp))%%2!=0)]
    attributeCount=length(unique(sapply(ruleattributes,function(x){str_trim(x)})))
    #explicability = cos(attributeCount/2) - (attributeCount/3)^2
    explicability=round(1.1765 * exp(-0.163*attributeCount),6)
  }
  
  
  ############################
  fnActionability<-function(rules,actionableAttributes)
  {
    isError=FALSE
    tryCatch(
{
  
  fnAttributes <- function(rule,actionableAttributes){
    rule=as.character(rule)
    ruleAttr = str_trim(unlist(strsplit(rule,'%in%|&')))
    ruleAttr = ruleAttr[seq(1,length(ruleAttr),2)]
    score = length(ruleAttr[ruleAttr %in% actionableAttributes])/length(ruleAttr)
    return(score)
  }
  rules = as.character(rules)
  rulesScoreVec = unlist(lapply(rules,fnAttributes,actionableAttributes))
},
error=function(e)
{
  isError<<-TRUE
  message(paste("Function fnActionability: ",e,sep=""))
},
finally={
  if(isError)
  {
    return(TRUE)
  }else{
    return(rulesScoreVec)
  }
})
  }


Actionability=fnActionability(rulelhs,actionableAttributes)
Metrics=data.frame(No_Of_Records_Supported,round(support,5),round(confidence,5),round(lift,5),HM_SCL,explicability,round(Actionability,5))

names(Metrics)=c("No_Of_Records_Supported","Support","Confidence","Lift","HM_SCL","Explicability","Actionability")



},
error=function(e){
  
  ErrorObj <<- c("Error" = paste("Function fnComputeMetrics: ",e,sep=""))
  isError<<-TRUE
  
  
  
},
finally={
  if(isError)
  {
    return(ErrorObj)
  }else{
    
    rm(list=setdiff(ls(), "Metrics")) 
    
    return(Metrics)
  }
}    
  )  



}


fnExplicHM<-function()
{
  HM_SCL=round(3*support*confidence*lift/(support*confidence+confidence*lift+support*lift),4)
  
  # computing Explicability
  ruleComp=str_split(rulelhs,'%in%|&')[[1]]
  
  # getting the distinct attributes of the rule and trimming the white spaces
  ruleattributes=ruleComp[which((1:length(ruleComp))%%2!=0)]
  attributeCount=length(unique(sapply(ruleattributes,function(x){str_trim(x)})))
  #explicability = cos(attributeCount/2) - (attributeCount/3)^2
  explicability=round(1.1765 * exp(-0.163*attributeCount),2)
}

fnC50NoOfRulesSupported<-function(rulefull,dataset)
{
  rulefull = as.character(rulefull)
  rows=nrow(dataset)
  No_Of_Records_Supported=nrow(with(dataset,dataset[eval(parse(text=rulefull)),]))
  rm(list=setdiff(ls(), "No_Of_Records_Supported"))
  return (No_Of_Records_Supported)
}


###########################################################################################################
## Description:# Takes string representation of the C5.0 rule component and outputs Rule,class,support,lift
# and confidence
## arguments:  # rule-> string representation of the rule outputted by C5.0
## returns:    # A vector of Rule,Class,support,confidence and lift

###########################################################################################################
fnRulesTable<-function(rule,dataset,Target,actionableAttributes)
{
  
  rule = as.character(rule)
  # Extracting the confidence in the format [1.234] 
  confBrackets=str_locate_all(rule,"\\[")[[1]]
  confBracketsStart=confBrackets[dim(confBrackets)[1],1]
  confBrackets=str_locate_all(rule,"\\]")[[1]]
  confBracketsEnd=confBrackets[dim(confBrackets)[1],1]
  #confidence=as.numeric(substring(rule,confBracketsStart+1,confBracketsEnd-1))
  
  #   # Extracting the Lift in the format ' 1.234)'
  #   Lift=str_extract(rule,' [0-9\\.]+\\)')
  #   
  #   # Extracting the Lift from ' 1.234)' as 1.234
  #   Lift=as.numeric(substring(Lift,2,nchar(Lift)-1))
  #   
  # Splitting the rule string in the Rule and Class 
  #ruleClass=str_split(rule,'AND\\s+->\\s+class\\s+')[[1]] 
  ruleClass=str_split(rule,'\\s+->\\s+class\\s+')[[1]] 
  # Extracting the Class
  Class=str_split(ruleClass[2],'\\s+\\[')[[1]][1]
  
  # Extracting the Rule but not in the required logical expression format
  Rule=str_split(ruleClass,'\\((.)+\\)\\s+INTUCEORULE\\s+')[[1]][2]
  
  
  Rule = str_split(Rule, ' INTUCEORULE ')
  
  
  
  RulecompVec=sapply(Rule[[1]],function(ruleComp){
    
    ruleComp=str_replace_all(ruleComp,'( = )|(\\s+in\\s+)',' %in% ')
    if(str_count(ruleComp,'\\{')==0)
    {
      ruleComp=str_split(ruleComp,' %in% ')[[1]]
      ruleComp=paste(ruleComp[1],paste('{',ruleComp[2],'}',sep=""),sep=" %in% ")
    }
    # after '{'
    ruleComp=str_replace_all(ruleComp,'\\{','\\{\\"')
    #before ','
    ruleComp=str_replace_all(ruleComp,'\\,','\\"\\,')
    
    #after ', '
    ruleComp=str_replace_all(ruleComp,'\\,\\s+','\\, \\"')
    
    #before '}'
    ruleComp=str_replace_all(ruleComp,'\\}','\\"\\}')    
    
    #Replace '{' with 'c('
    ruleComp=str_replace_all(ruleComp,'\\{','c(')
    
    #Replace '}' with ')'
    ruleComp=str_replace_all(ruleComp,'\\}',')')
    ruleComp
  })
  names(RulecompVec)=NULL
  # joining all the components of the rule
  Rule=paste(sort(RulecompVec),collapse=" & ")    
  rulefull=paste(Rule," & ",Target, " ==",' \'',Class,'\'',sep="")
  rulerhs = paste(Target, " ==",' \'',Class,'\'',sep="") 
  Metrics = fnComputeMetrics(Rule,rulerhs,rulefull,dataset,actionableAttributes)
  
  No_Of_Records_Supported = Metrics$No_Of_Records_Supported
  # conputing support
  support = Metrics$Support
  confidence = Metrics$Confidence
  Lift = Metrics$Lift
  HM_SCL = Metrics$HM_SCL
  explicability = Metrics$Explicability
  Actionability = Metrics$Actionability
  as.vector(c(Rule,Class,No_Of_Records_Supported,support,confidence,Lift,HM_SCL,explicability,Actionability))
}


fnExtractC50Rules<-function(dtc50,dataset,Target,actionableAttributes)
{
  isError=FALSE
  ErrorObj = NULL
  
  tryCatch(
{
  message("In Function fnExtractC50Rules")
  
  # loading the required libraries              
  require(C50)
  require(stringr)              
  #To track if an error has occured
  isError=FALSE 
  
  if (dtc50$size >0){
    
    rulesset = summary(dtc50)
    rulesset=toString(rulesset)
    rulesub=str_sub(rulesset,str_locate(rulesset,'\nRules:')[2]+1,str_locate(rulesset,'\n\nDefault class:')[1])
    rulesset = str_replace_all(rulesub,'\n\n',' ')
    rulesset = str_replace_all(rulesset,'\n\t->',' ->')
    rulesset = str_replace_all(rulesset,'\n\t',' INTUCEORULE ')   # each attribute condition is split with this word "INTUCEORULE"
    rulesset = str_replace_all(rulesset,'\n','')
    rulesset = str_replace_all(rulesset,'\t','')
    rule = str_split(rulesset,c('Rule +[[:digit:]]+: '),n=Inf)
    #   rule=str_split(str_replace_all(str_replace_all(str_replace_all(
    #     str_sub(rulesset,str_locate(rulesset,'\nRules:')[2]+1,str_locate(rulesset,'\n\nDefault class:')[1]),'\n\n',' ')
    #                                                  ,'\n',' '),'\t',' '),c('Rule +[[:digit:]]+: '),n=Inf)              
    rule=unlist(rule)
    rule=rule[-1]
    
    tryCatch(
{
  rulesdf = data.frame("","",0,0,0,0,0,0,0)
  names(rulesdf)=c('Rule','Class','No_Of_Records_Supported','Support','Confidence','Lift','HM_SCL','Explicability','Actionability')
  rulesdf=rulesdf[-1,]
  rulesdf=data.frame(t(sapply(rule,fnRulesTable,dataset,Target,actionableAttributes)))
},
error=function(e)
{
  message(paste("Function fnRulesTable: ",e,sep=""))
  isError<<-TRUE
  return(TRUE)
}
    )              

row.names(rulesdf)=NULL
names(rulesdf)=c('Rule','Class','No_Of_Records_Supported','Support','Confidence','Lift','HM_SCL','Explicability','Actionability')
rulesdf[,c("No_Of_Records_Supported","Support","Confidence","Lift","HM_SCL","Explicability","Actionability")]=data.frame(lapply(rulesdf[,c("No_Of_Records_Supported","Support","Confidence","Lift","HM_SCL","Explicability","Actionability")],function(x){as.numeric(as.character(x))}))  
#rulesdf = rulesdf[with(rulesdf,order(-Support,-Confidence,-Lift)),]

  }else{
    
    rulesdf = data.frame("","",0,0,0,0,0,0,0)
    names(rulesdf)=c('Rule','Class','No_Of_Records_Supported','Support','Confidence','Lift','HM_SCL','Explicability','Actionability')
    rulesdf=rulesdf[-1,]
    
  }

},
error=function(e){
  
  ErrorObj <<- c("Error" = paste("Function fnExtractC50Rules: ",e,sep=""))
  isError<<-TRUE
  
},
finally={
  if(isError)
  {
    
    return(ErrorObj)
  }else{
    return(rulesdf)
  }
  
}
  )
}


fnC50Model <- function(binnedData,Target){
  
  require(C50)
  formula=as.formula(paste(Target,"~.",sep=""))
  dtc50=C5.0(formula,data=binnedData,rules=TRUE)
  #dtc50=C5.0(formula,data=binnedData,rules=TRUE,control = C5.0Control(subset = F))
  rm(list=setdiff(ls(), "dtc50"))
  return(dtc50)
  
}

Train.13
summary(Train.13)
# Executing the functions
names(Train.13)
rm(binnedData)
binnedData = Train.13
names(binnedData)
Target = "GROWTH_RATE_3YR_14"
#binnedData$target = Train.13$GROWTH_RATE_3YR_14
actionableAttributes=as.character()
MainC50Rules1 <-
  data.frame(Rule = character(0),Class = character(0),No_Of_Records_Supported = numeric(0),
             Support = numeric(0),Confidence = numeric(0), Lift = numeric(0),HM_SCL = numeric(0),
             Explicability = numeric(0), Actionability = numeric(0))


C50Model = fnC50Model(binnedData,Target)
summary(C50Model)

MainC50Rules1 = fnExtractC50Rules(C50Model,binnedData,Target,actionableAttributes)
MainC50Rules2 = unique(MainC50Rules1)
MainC50Rules3 <- MainC50Rules2[with(MainC50Rules2,order(-HM_SCL)),]
MainC50Rules4 = subset(MainC50Rules3,Support > 0)

write.csv(MainC50Rules3,"../output/Allrules.csv",row.names=FALSE)

pTrain.13 = predict(C50Model, Train.13, type = "class")
accuracy.Train.13 = sum( pTrain.13 == Train.13$GROWTH_RATE_3YR_14 )/length(pTrain.13) 
accuracy.Train.13
p = predict(C50Model, Test.13, type = "class")
accuracy.Test.13 = sum( p == Test.13$GROWTH_RATE_3YR_14 )/length(p) 
accuracy.Test.13

###########RPART

set.seed(88)
rpartfit.13 <- rpart(GROWTH_RATE_3YR_14~., method = "class", data=Train.13)
summary(rpartfit.13)
p = predict(rpartfit.13, Test.13, type = "class")
rparttable.test.13 = table(p,Test.13$GROWTH_RATE_3YR_14)
ptrain = predict(rpartfit.13, Train.13, type = "class")
rparttable.train.13 =  table(ptrain,Train.13$GROWTH_RATE_3YR_14)
sum(diag(rparttable.train.13))/nrow(as.data.frame(ptrain))
sum(diag(rparttable.test.13))/nrow(as.data.frame(p))

################Random Forest
set.seed(88)
rf.fit.13 <- randomForest(GROWTH_RATE_3YR_14~.,data=Train.13, ntree=10)
predictedY.Test <- predict(rf.fit.13, Test.13)
rf.test.13 = table(Test.13$GROWTH_RATE_3YR_14,predictedY.Test)
predictedY.Train <- predict(rf.fit.13, Train.13)
rf.train.13 = table(Train.13$GROWTH_RATE_3YR_14,predictedY.Train)
sum(diag(rf.train.13))/nrow(as.data.frame(predictedY.Train))
sum(diag(rf.test.13))/nrow(as.data.frame(predictedY.Test))


########SVM

modelsvm.13 <- svm(GROWTH_RATE_3YR_14~.,Train.13)
predictedY.13 <- predict(modelsvm.13, Test.13)
svm.test.13 = table(Test.13$GROWTH_RATE_3YR_14,predictedY.13)


predictedYTrain.13  = predict(modelsvm.13, Train.13)
svm.train.13 = table(Train.13$GROWTH_RATE_3YR_14,predictedYTrain.13)

sum(diag(svm.train.13))/nrow(as.data.frame(predictedYTrain.13))
sum(diag(svm.test.13))/nrow(as.data.frame(predictedY.13))

#######create dummies for categorical data
library(dummies)
library(class)
library(vegan)
str(final.knn)
str(knn.ind)
statecount2013 = dummy(final.knn$statecount2013)
Vend_Ind = dummy(final.knn$Vend_Ind)
growthRate = final.knn$GROWTH_RATE_3YR_14
final.knn = subset(final.knn, select = -c(statecount2013,Vend_Ind,GROWTH_RATE_3YR_14))
final.knn = cbind(final.knn, Vend_Ind, statecount2013)

###split the data on this new set

final.knn = decostand(final.knn, "range")
set.seed(88)
nrow(final.knn)
split = sample.split(final.knn, SplitRatio = 0.90)
growthRate =
Train.13 = subset(final.knn, split == TRUE)
Test.13 = subset(final.knn, split == FALSE)
Train.y = subset(growthRate, split == TRUE)
Test.y = subset(growthRate, split == FALSE)
accu = numeric(0)
set.seed(100)
for(i in 1:40){
mod1=knn(Train.13, Test.13, Train.y, k = i)
cf=table(mod1,Test.y)
accu[i]= sum(diag(cf))/nrow(Test.13)
}
mod = knn(Train.13, Test.13, Train.y, k = 1)
# optimised k-value
fmodel = knn(Train.13,Test.13,Train.y,which.max(accu))
sum(diag(table(fmodel,Test.y)))/nrow(Test.13)
fmodel1 = knn(Train.13,Train.13,Train.y,which.max(accu))
sum(diag(table(fmodel1,Train.y)))/nrow(Train.13)
