library(arules)
library(arulesViz)

#import the Data
bankData = read.csv("C:\\Users\\danbu\\Desktop\\Applied Machine Learning\\Week Three\\bankdata_csv_all.csv")

str(bankData)


hist(bankData$income)
hist(bankData$children)
range(bankData$children)



#remove ID Col
bankData_New = bankData[,2:12]

str(bankData_New)

#Descritization
var_to_discretize <- c("age", "income")

bankData_New$age_grp <- discretize(bankData_New$age, method="frequency", breaks = 3,
                                   lables = c("low", "medium", "high"), order= T)
bankData_New$income_grp <- discretize(bankData_New$income, method="frequency", breaks = 10,
                                   lables = c("low", "medium", "high"), order= T)

boxplot(age ~age_grp, data=bankData_New)
boxplot(income ~income_grp, data=bankData_New)

#convert columns to Factors
bankData_New$sex <- as.factor(bankData_New$sex)
bankData_New$region <- as.factor(bankData_New$region)
bankData_New$married <- as.factor(bankData_New$married)
bankData_New$children <- as.factor(bankData_New$children)
bankData_New$car <- as.factor(bankData_New$car)
bankData_New$save_act <- as.factor(bankData_New$save_act)
bankData_New$current_act <- as.factor(bankData_New$current_act)
bankData_New$mortgage <- as.factor(bankData_New$mortgage)
bankData_New$pep <- as.factor(bankData_New$pep)

#Generate Rules
rules_bank <- apriori(bankData_New[,sapply(bankData_New, is.factor)],)

summary(rules_bank)
length(rules_bank)

rules_bank <- apriori(bankData_New[,sapply(bankData_New, is.factor)],
                      parameter = list(support=0.12, confidence=0.79,minlen=4 ))

summary(rules_bank)
length(rules_bank)



inspect(head(rules_bank, 5))
length(rules_bank)

#Adjusting Support and confidence

top.support <- sort(rules_bank, decreasing = TRUE, na.last = NA, by = "lift")

inspect(top.support)


#Convert Record Data to Transaction Table

#Prepare Transaction Dataset

trans_bankData <- as(bankData_New[,c(2,3,5,6,7,8,9,10,11)], "transactions")

rules_transactions <- apriori(trans_bankData,
                              parameter = list(support=0.1,confidence=0.5, minlen=3))

inspect(head(rules_transactions,15))

frequent_items <- eclat(trans_bankData, parameter = list(support=0.4, minlen=2))
length(frequent_items)
inspect(frequent_items)

itemFrequencyPlot(trans_bankData, topN = 10, type = "absolute", main = "Item frequency")


rules <- apriori(trans_bankData, parameter = list(support = 0.1, confidence = 0.5))
inspect(head(sort(rules, by = "lift", decreasing = T), 8))


subset_rules <- which(colSums(is.subset(rules, rules)) > 1)
rules <- sort(rules[-subset_rules], by = "lift", descreasing = T)
inspect(head(rules, 5))



#Defining the RHS

#pep yes
rules <- apriori(data = trans_bankData, parameter = list(supp = 0.01, conf = 0.9),
                 appearance = list(default = "lhs", rhs = "pep=YES"),
                 control = list(verbose = F))
inspect(head(sort(rules, by = "lift", descreasing = T)))
#inspect(sort(rules, by = "lift", descreasing = T))
length(rules)

plot(rules, measure = c("support", "lift"), shading = "confidence")

#pep no
rules <- apriori(data = trans_bankData, parameter = list(supp = 0.01, conf = 0.975),
                 appearance = list(default = "lhs", rhs = "pep=NO"),
                 control = list(verbose = F))
inspect(head(sort(rules, by = "lift", descreasing = T)))
#inspect(sort(rules, by = "lift", descreasing = T))
length(rules)

plot(rules, measure = c("support", "lift"), shading = "confidence")
