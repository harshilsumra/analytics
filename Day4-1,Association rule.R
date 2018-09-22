#day3-1
#association rule analysis|Market basket analysis


# Association Rules - Groceries data set ####

library(arules)  #install first
library(arulesViz) #install first
library(datasets)  # no need to install, just load it reqd for Groceries
data('Groceries')
Groceries

#Structure of Groceries
str(Groceries)
Groceries
inspect(Groceries[1:5])  #view
LIST(Groceries[1:6])  #another view
 
#Find Frequent Itemset len corresponds to 
frequentItems = eclat (Groceries)
inspect(frequentItems)
frequentItems = eclat (Groceries, parameter = list(supp = 0.01, minlen= 3, maxlen = 5)) 
inspect(frequentItems)
frequentItems
inspect(frequentItems[10:15])
#inspect(frequentItems[100:122])
#Descending Sort frequent items by count : 1 to 25 itemsets
inspect(sort (frequentItems, by="count", decreasing=TRUE)[1:25])
inspect(sort (frequentItems, by="count", decreasing=F)[1:25])

#Support is : support(A&B) = n(A&B)/ N
#Plot the Frequency Plot
itemFrequencyPlot(Groceries,topN = 15,type="absolute")
itemFrequencyPlot(Groceries, topN = 10, type='relative')
abline(h=0.15)

# Create rules and the relationship between items
#parameters are min filter conditions 
rules = apriori(Groceries, parameter = list(supp = 0.005, conf = 0.5, minlen=2))
rules
inspect (rules[1:5])
#Sort Rules by confidence, lift and see the data
rulesc <- sort (rules, by="confidence", decreasing=TRUE)
inspect(rulesc[1:5])
rulesl <- sort (rules, by="lift", decreasing=TRUE)
inspect (rulesl[1:5])
#which items have strong confidence and lift 

#How To Control The Number Of Rules in Output ?
#maxlen, minlen, supp, conf
rules2 = apriori (Groceries, parameter = list (supp = 0.001, conf = 0.5, minlen=2, maxlen=3)) 
inspect(rules2[1:5])

# Are there any duplicate/ Redundant Rules 
#https://rdrr.io/cran/arules/man/is.redundant.html

sum(is.redundant(rules2))
(redundant = which(is.redundant(rules2)))
inspect(rules2[redundant])
#inspect(subset(rules2, subset=lhs %ain% c('citrus fruit','rice') & rhs %in% 'whole milk' ))
#remove it
rulesNR = rules2[-redundant] 
is.redundant(rulesNR)
sum(is.redundant(rulesNR))  #ok now



#Find what factors influenced an event ‘X’
rules3 = apriori (data=Groceries, parameter=list (supp=0.002,conf = 0.8), appearance = list (default="lhs",rhs="whole milk"), control = list (verbose=F))
rules3
inspect(rules3[1:5])
inspect(rules3)

#Find out what events were influenced by a given event
subset1 = subset(rules2, appearance = list (default="lhs",rhs="whole milk"))
subset1 = subset(rules2, subset=rhs %in% 'bottled beer' )
inspect(subset1)
inspect(rules2)
subset2 = subset(rules2, subset=lhs %ain% c('baking powder','soda') )
inspect(subset2)
subset2a = subset(rules2, subset=lhs %in% c('baking powder','soda') )
inspect(subset2a)




subset3 = subset(rules2, subset=rhs %in% 'bottled beer' & confidence > .7, by = 'lift', decreasing = T)
inspect(subset3)
subset4 = subset(rules2, subset=lhs %in% 'bottled beer' & rhs %in% 'whole milk' )
inspect(subset4)

#Visualizing The Rules -----
plot(subset1[1:10]) 
plot(subset1[1:10], measure=c("support", "lift"), shading="confidence")

#


rules4 = apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.4), appearance = list (default="rhs",lhs=c('tropical fruit','herbs')), control = list (verbose=F))
inspect(rules4[1:5])
inspect(rules4)

#assocrule 3----

# Association Rule - Simple Example Case
# read this pdf for help
#https://cran.r-project.org/web/packages/arules/arules.pdf

#libraries
library(arules)
library(arulesViz)

#Create Data

#Method3 Use: ----
#Data in the form of list
itemlist = list(c('I1','I2','I5'), c('I2','I4'), c('I2','I3'),c('I1','I2','I4'),c('I1','I3'),c('I2','I3'),c('I1','I3'),c('I1','I2','I3','I5'),c('I1','I2','I3'))
itemlist
length(itemlist)
## set transaction names
names(itemlist) <- paste("Tr",c(1:9), sep = "")
itemlist
## coerce into transactions
tdata3 <- as(itemlist, "transactions")
tdata3
summary(tdata3)

tdata=tdata3

#Data ready - Perform AR ----
## analyze transactions
summary(tdata)
itemlist
image(tdata)

#Analysis
freqitems = eclat(tdata) #default support=.1
freqitems = eclat(tdata, parameter = list(minlen=1, supp=.1, maxlen=2 ))

freqitems
inspect(freqitems)

support(items(freqitems[1:2]), transactions=tdata)
inspect(freqitems[1])
inspect(items(freqitems[1]))

itemFrequencyPlot(tdata,topN = 5,type="absolute")
itemFrequencyPlot(tdata,topN = 5,type="relative", horiz=T)
write.csv(as.data.frame(inspect(freqitems)),'freqitems1.csv')


#Construct the Rules
rules = apriori(tdata, parameter = list(supp = 0.2, conf = 0.5, minlen=2))
itemFrequencyPlot(items(rules))

inspect(rules[1:5])
inspect(rules)
write.csv(as.data.frame(inspect(rules)),'rules1.csv')
#sort rules by support
rules_s = sort(rules, by="support", decreasing=TRUE )
inspect(rules_s)
inspect(rules_s[1:5])  #itemsset having high support

#sort rules by confidence
rules_c = sort(rules, by="confidence", decreasing=TRUE )
inspect(rules_c)
inspect(rules_c[1:5])  #itemsset having high confidence

#sort rules by lift
inspect(head(rules, n = 3, by ="lift"))
rules_l = sort(rules, by="lift", decreasing=TRUE )
inspect(rules_l)
inspect(rules_l[1:5])  #itemsset having high confidence

#Quality Data of Rules
quality(rules_c) 


#Redundant Rules
inspect(rules)
(redundant = which(is.redundant(rules)))
inspect(rules[c(8,9,10,11,12,14,14)])
inspect(rules[redundant])
inspect(rules)
write.csv(as(rules,"data.frame"), file='./data/rulesR.csv')


#Remove Redundant Rules
rulesNR <- rules[-redundant] 
is.redundant(rulesNR)
sum(is.redundant(rulesNR))  #ok now
inspect(rulesNR)

#Rules with LHS and RHS: single or combination
rules2= rulesNR
inspect(rules2)

rules2.lhs1 <- subset(rules2, lhs %in% c("I1", "I5"))
inspect(rules2.lhs1)

rules2.rhs1 <- subset(rules2, rhs %in% c("I3"))
inspect(rules2.rhs1)

rules2.lhsrhs1 = subset(rules2, lhs %in% c("I1") & rhs %in% c("I3"))
inspect(rules2.lhsrhs1)

rules2.lhsrhs2 = subset(rules2, lhs %in% c("I1") | rhs %in% c("I3"))
inspect(rules2.lhsrhs2)



# Rules as DF: original rules
rules_DF <- as(rules,"data.frame")
rules_DF
str(rules_DF)
write.csv(rules_DF, './data/myrules1.csv')

#Visualisation
plot(rules)

