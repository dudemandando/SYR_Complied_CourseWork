
oilChanges <- c(3,5,2,3,1,4,6,4,3,2,0,10,7,8)
repairs <- c(300,300,500,400,700,420,100,290,475,620,600,0,200,50)
miles <-c(20100,23200,19200,2210,18400,23400,17900,19900,20100,24100,18200,19600,20800,19700)

oil <- data.frame(oilChanges, repairs, miles)

#plot1 <- plot(oil$oilChanges,oil$repairs)

model1 <- lm(formula = repairs~oilChanges, data=oil)
summary(model1)
#abline(model1)

oil$oilChangeCost <- oil$oilChanges * 120
oil$totalCost <-oil$oilChangeCost + oil$repairs
m <- lm(formula=totalCost~oilChanges, data=oil)
plot(oil$oilChanges, oil$totalCost)
summary(m)
abline(m)

#using the linear model in R to predict the total cost
test = data.frame(oilChanges=0)
predict(m,test,type = "response")

test = data.frame(oilChanges=5)
predict(m,test,type = "response")

test = data.frame(oilChanges=10)
predict(m,test,type = "response")