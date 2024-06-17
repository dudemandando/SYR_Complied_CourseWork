#install.packages("arules")
#install.packages("arulesViz")

data("Groceries")

itemFrequencyPlot(Groceries, topN=20, type="absolute")
rules <- apriori(Groceries, parameter = list(supp = 0.001, conf = 0.8))

#show top 5
options(digits=2)
inspect(rules[1:5])

summary(rules)

#sort rules most relevant first
rules <- sort(rules, by="confidence", decreasing=TRUE)
inspect(rules[1:5])

#Here we specify the Right Hand Side as whol milk
rules <- apriori(data=Groceries, parameter=list(supp=0.001,conf=0.15, minlen=2),
                 appearance = list(default="lhs", rhs="whole milk"),
                 control= list(verbose=F))
rules <-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])

#if we want to target items to generate rules  with Whole Milk as the Left Hand Side

rules <- apriori(data=Groceries, parameter=list(supp=0.001,conf=0.15, minlen=2),
                 appearance = list(default="rhs", lhs="whole milk"),
                 control= list(verbose=F))
rules <-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules[1:5])



rulesPlot <- plot(rules, method="graph", engine="interactive", shading=NA)


rulesPlot










