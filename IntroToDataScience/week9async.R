#install.packages("arules")
library("arules")
#install.packages("arulesViz")
library(arulesViz)



#############################
#EXPLORE THE GROCERIES DATA 
#############################

#Data set included within R
data("Groceries")
summary(Groceries)

groceries <- Groceries

#creates a sparse matrix
data <- groceries@data
means <- rowMeans(data)
str(means)
str(groceries@itemInfo)
groceries@itemInfo[1,]
groceries@itemInfo[,1]

labels <- groceries@itemInfo[,1]
labels[1:10]
levels <- groceries@itemInfo$level2
df <- data.frame(means, labels, levels)
#sort based on mean
df <- df[order(-df$means),]
#show items at occur 8% of the time
df[df$means > 0.08,]

#Here we say we want to see the items with a frequency in this case 10% of the time
itemFrequencyPlot(groceries, support=0.1)

#change the support level
itemFrequencyPlot(groceries, support=0.05, cex.names=0.5)

#use the apriori command to find rules CREATE THE RULES
# rules format, equation context: LHS (lefthand side), RHS (righthand side)
#RHS/LHS
#RHS one Item
#LHS multiple items


groceriesRules <- apriori(groceries, parameter=list(support=0.005,confidence=0.5))

groceriesRules <- apriori(groceries, parameter=list(support=0.01,confidence=0.5))
summary(groceriesRules)

#Here we're going to actually look at the rules
#We're just trying to see what happens, not figure out why they are buying items together
inspect(groceriesRules)

#why are there so many rules with milk?



groceriesRules <- apriori(groceries, parameter=list(support=0.005,confidence=0.35))

plot(groceriesRules)

#IDENTIFY THE GOOD RULES or the ones you actually want
goodrules <- groceriesRules[quality(groceriesRules)$lift > 3.5]
inspect(goodrules)
plot(goodrules)

beerRules <- apriori(groceries, parameter = list(support = .001, confidence=0.25))


beerRulesBest <- apriori(groceries, parameter = list(support = .001, confidence=0.8))
inspect(beerRulesBest)
plot(beerRulesBest)
plot(beerRules, method="graph", control=list(type="items"))
