rm(list = ls(all = T))
setwd("/Users/kalyan/Documents/final_r_code/rcode")
#####Calling all the libraries used in this program

#Function to check the installation and loading required package
FnLoadPkg<-function(pkg){
  if(!require(pkg, character.only = TRUE)){
    install.packages(pkg)
    require(pkg,character.only = TRUE)
  }else {
    require(pkg,character.only = TRUE)
  }
}

FnLoadPkg("reshape")        ##Tweaking rows and columns in a dataframe
FnLoadPkg("reshape2")       ##Tweaking rows and columns in a dataframe
FnLoadPkg("sqldf")          ##Using SQL like functions
FnLoadPkg("caTools")        ##Splitting the data into Training and Testing
FnLoadPkg("nnet")           ##Logistic Regression
FnLoadPkg("C50")            ##Rule based decision Tree
FnLoadPkg("rpart")          ##Regression Trees
FnLoadPkg("randomForest")   ##Random Forest
FnLoadPkg("e1071")          ##Support Vector Machines
FnLoadPkg("ggplot2")        ##Plotting Graphs
FnLoadPkg("data.table")        ##Plotting Graphs

####################################################################################
###Loading the file that contains all the functions
source("Motorists_preprocess.R")
###reading AgencyData and pl_quotes for preprocessing
AgencyData <- read.csv(file = "../input/agency_final.csv",head=TRUE, sep = ",")
pl_quotes <- read.csv("../input/PL_Quotes.csv",header=TRUE,sep=",")
cl_quotes <- read.csv("../input/CL_Quotes.csv",header=TRUE,sep=",")

###Calling preprocess function that returns a dataframe contatining
###desired columns on 2013 data

finaldclean.13 = preprocess(AgencyData,pl_quotes,cl_quotes)
final.knn = finaldclean.13
final.knn$GROWTH_RATE_3YR_14 = as.factor(sapply(final.knn$GROWTH_RATE_3YR_14, FUN = binning.GROWTH))

rm(AgencyData,cl_quotes,pl_quotes)
####PLOTTING GRAPHS BEFORE BINNING#####
#######################################
Initial_visualizations
#######################################
hist(finaldclean.13$GROWTH_RATE_3YR_14, labels = T)
hist(finaldclean.13$RETENTION_RATIO_13, labels = T)
hist(finaldclean.13$LOSS_RATIO_13, labels = T)
hist(finaldclean.13$CL2013, labels = T)
hist(finaldclean.13$PL2013, labels = T)
hist(finaldclean.13$Number_of_years, labels = T , breaks = 80)
hist(finaldclean.13$Active_Producers, labels = T)
hist(finaldclean.13$Max_Age, labels = T)
hist(finaldclean.13$Min_Age, labels = T)
hist(finaldclean.13$PL_START_YEAR_CNT, labels = T)
hist(finaldclean.13$PL_END_YEAR_CNT, labels = T)
hist(finaldclean.13$COMMISIONS_START_YEAR_CNT, labels = T)
hist(finaldclean.13$COMMISIONS_END_YEAR_CNT, labels = T)
hist(finaldclean.13$CL_START_YEAR_CNT, labels = T)
hist(finaldclean.13$CL_END_YEAR_CNT, labels = T)
hist(finaldclean.13$ACTIVITY_NOTES_START_YEAR_CNT, labels = T)
hist(finaldclean.13$ACTIVITY_NOTES_END_YEAR_CNT, labels = T)
hist(finaldclean.13$APPLIED, labels = T)
hist(finaldclean.13$eQuote, labels = T)
hist(finaldclean.13$EZLYNX, labels = T)
hist(finaldclean.13$PLRATING, labels = T)
hist(finaldclean.13$TRANSACTNOW, labels = T)
######Applying functions to bin the numeric variables based on the visualizations###### 

finaldclean.13$RETENTION_RATIO_13 = as.factor(sapply(finaldclean.13$RETENTION_RATIO_13, FUN = binning.RETENTION))
finaldclean.13$LOSS_RATIO_13 = as.factor(sapply(finaldclean.13$LOSS_RATIO_13, FUN = binning.LOSS))
finaldclean.13$CL2013 = as.factor(sapply(finaldclean.13$CL2013, FUN = binning.CL2013))
finaldclean.13$PL2013 = as.factor(sapply(finaldclean.13$PL2013, FUN = binning.PL2013))
finaldclean.13$Number_of_years = as.factor(sapply(finaldclean.13$Number_of_years, FUN = binning.YEARS))
finaldclean.13$Active_Producers = as.factor(sapply(finaldclean.13$Active_Producers, FUN = binning.PRODUCERS))
finaldclean.13$Max_Age = as.factor(sapply(finaldclean.13$Max_Age, FUN = binning.MAX))
finaldclean.13$Min_Age = as.factor(sapply(finaldclean.13$Min_Age, FUN = binning.MIN))
finaldclean.13$PL_START_YEAR_CNT = as.factor(sapply(finaldclean.13$PL_START_YEAR_CNT, FUN = binning.PLSTART))
finaldclean.13$PL_END_YEAR_CNT = as.factor(sapply(finaldclean.13$PL_END_YEAR_CNT, FUN = binning.PLEND))
finaldclean.13$COMMISIONS_START_YEAR_CNT = as.factor(sapply(finaldclean.13$COMMISIONS_START_YEAR_CNT, FUN = binning.COMMSTART))
finaldclean.13$COMMISIONS_END_YEAR_CNT = as.factor(sapply(finaldclean.13$COMMISIONS_END_YEAR_CNT, FUN = binning.COMMEND))
finaldclean.13$CL_START_YEAR_CNT = as.factor(sapply(finaldclean.13$CL_START_YEAR_CNT, FUN = binning.CLSTART))
finaldclean.13$CL_END_YEAR_CNT = as.factor(sapply(finaldclean.13$CL_END_YEAR_CNT, FUN = binning.CLEND))
finaldclean.13$ACTIVITY_NOTES_START_YEAR_CNT = as.factor(sapply(finaldclean.13$ACTIVITY_NOTES_START_YEAR_CNT, FUN = binning.ACTSTART))
finaldclean.13$ACTIVITY_NOTES_END_YEAR_CNT = as.factor(sapply(finaldclean.13$ACTIVITY_NOTES_END_YEAR_CNT, FUN = binning.ACTEND))
finaldclean.13$APPLIED = as.factor(sapply(finaldclean.13$APPLIED, FUN = binning.HITRATIO))
finaldclean.13$eQuote = as.factor(sapply(finaldclean.13$eQuote, FUN = binning.HITRATIO))
finaldclean.13$EZLYNX = as.factor(sapply(finaldclean.13$EZLYNX, FUN = binning.HITRATIO))
finaldclean.13$PLRATING = as.factor(sapply(finaldclean.13$PLRATING, FUN = binning.HITRATIO))
finaldclean.13$TRANSACTNOW = as.factor(sapply(finaldclean.13$TRANSACTNOW, FUN = binning.HITRATIO))


###########dataframe with only numeric growth rate and rest categorical for visuals
visuals = finaldclean.13
finaldclean.13$GROWTH_RATE_3YR_14 = as.factor(sapply(finaldclean.13$GROWTH_RATE_3YR_14, FUN = binning.GROWTH))

source("model_building.R")

#######################
####Visualizations#####
#######################

finaldclean.13$Vend_Ind = as.numeric(finaldclean.13$Vend_Ind)
finaldclean.13$GROWTH_RATE_3YR_14 = as.numeric(finaldclean.13$GROWTH_RATE_3YR_14)
source("final_visualizations.R")



