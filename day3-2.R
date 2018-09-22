#day3-2

df =  read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
library(rpart,rpart.plot)
head(df)
df$rank=factor(df$rank)
df$admit=factor(df$admit)
dim(df)
dtree1=rpart(admit~.,data=df)
dtree1
rpart.plot(dtree1,nn=T)
printcp(dtree1)
dtree2=prune(dtree1,cp=0.023622)
dtree2
rpart.plot(dtree2)


#predict the class for any sample value

library(dplyr)
(ndata1=sample_n(df,10))#imp for random selection
predict(dtree2,newdata = ndata1,type='class') 

#decisiontree3-----



library(ISLR)
data(Carseats)
data = Carseats
head(data)

#Libraries for Decision Tree
library(rpart)
library(rpart.plot)

#Model
tree1 = rpart(Sales ~ . , data=data, method='anova' )
tree1
rpart.plot(tree1, cex=.8)

#this is large tree, so prune it: check cp
printcp(tree1)
#cp value should be chosen such that xerror is least
prunetree = prune(tree1, cp=0.05)
prunetree1 = prune(tree1, cp=0.02)

#here we have selected a different value to simplify the tree

prunetree
prunetree1
rpart.plot(prunetree1, nn=T)
rpart.plot(prunetree, nn=T)
mean(data[data$ShelveLoc=="Bad" & data$ShelveLoc=="Medium",c("Sales")])
mean(data[data$ShelveLoc=="Bad" | data$ShelveLoc=="Medium",c("Sales")])
nrow(data[data$ShelveLoc=="Bad" | data$ShelveLoc=="Medium",c("Sales")])
length(data[data$ShelveLoc=="Bad" | data$ShelveLoc=="Medium",c("Sales")])
315/400
#Interpretation
#if ShelveLoc=Good, and Price >= 109.5, sales predicted is 9.2

#improve the plot
rpart.plot(prunetree, nn=T, cex=.8, type=4)

#read this document to improve the plot
#https://cran.r-project.org/web/packages/rpart.plot/rpart.plot.pdf
#http://www.milbo.org/rpart-plot/prp.pdf
library(dplyr)
#Predict for test value
(testdata = sample_frac(data,0.2))
(predictedSales=predict(prunetree, newdata=testdata, type='vector'))
cbind(testdata, predictedSales)
#next line will show error because we have to predict numerical value instead of class/ category, so type of response reqd is vector not class
(predict(prunetree, newdata=testdata, type='class'))


#see online help here
#https://www.datacamp.com/community/tutorials/decision-trees-R
