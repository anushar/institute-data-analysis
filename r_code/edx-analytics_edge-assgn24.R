data(state)
statedata = cbind(data.frame(state.x77), state.abb, state.area, state.center,  state.division, state.name, state.region)
tapply(statedata$HS.Grad, statedata$state.region, mean)
boxplot(statedata$Murder ~ statedata$state.region)
substate = subset(statedata,statedata$state.region == "Northeast")
substate$state.abb[which.max(substate$Murder)]

