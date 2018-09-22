# Decision trees1----

library(rpart)
library(rpart.plot)
education=factor(c(3,2,2,3,2,2,3,2,2,2))
married=factor(c('S','M','S','M','M','M','S','S','M','S'))
income=c(125,100,70, 120, 95, 60, 220, 85, 75, 90)
buy=factor(c(0,0,0,0,1,0,0,1,0,1))
(data= data.frame(buy, education, married, income))
head(data)

xtabs( ~ buy + education, data=data)

table(data$buy, data$education)
dtree1 = rpart(buy ~ education + married + income, data=data)
dtree1
dtree1 = rpart(buy ~ education + married, data=data, parms=list(split='gini'),  minsplit=4, minbucket=2,cp=-1)
dtree1
rpart.plot(dtree1,nn=T)
printcp(dtree1)
table(data$buy)
head(data)
ndata1 = data.frame(education=factor(c(3,3)), married=c('S','M'), income=c(110,120))
predict(dtree1, newdata=ndata1, type='class')
(p2=predict(dtree1, newdata=ndata1, type='prob'))
cbind(ndata1, p1,p2)

#decisiontree2----


marry=sample(c('Yes',"No"), size=100, replace=T)
selfGender=sample(c('M',"F"), size=100, replace=T)
selfAge=ceiling(runif(100, 23,30))
selfEdn=sample(c(1,2,3,4), size=100, replace=T, prob=c(.1,.3,.4,.2))
spouseAge=ceiling(rnorm(100, mean=26,sd=5))
spouseEdn=sample(c(1,2,3,4), size=100, replace=T, prob=c(.1,.3,.4,.2))
spouseSiblings=sample(c(0,1,2,3), size=100, replace=T, prob=c(.2,.3,.3,.2))
spouseCity=sample(c('Rural',"Urban"), size=100, replace=T)
spouseSalary= ceiling(runif(100, 0,100000))

df = data.frame(marry, selfGender, selfAge, selfEdn, spouseAge, spouseEdn, spouseSiblings, spouseCity, spouseSalary )

head(df)

library(rpart)

dtree1 = rpart(marry ~ . , data=df)
dtree1
library(rpart.plot)
rpart.plot(dtree1,cex=0.8)

df[spouseSalary > 36e+3 & spouseAge >=22 & marry=='Yes',c('spouseSalary','spouseAge', 'marry')]


dtree2 = rpart(marry ~ . , data=df, cp=-1)
dtree2
rpart.plot(dtree2)

printcp(dtree2)
ptree2 = prune(dtree2, cp=.04)
rpart.plot(ptree2)
ptree3 = prune(dtree2, cp=.021277)
rpart.plot(ptree3,nn=T)
ptree3
df[spouseAge>=30 & spouseAge>=25 & spouseSalary< 21000,c("spouseAge","spouseSalary","marry")]
table(df$marry)

#predict
df = data.frame(marry, selfGender, selfAge, selfEdn, spouseAge, spouseEdn, spouseSiblings, spouseCity, spouseSalary )
head(df)
ndata1=data.frame(selfGender="M", selfAge=24, selfEdn=4, spouseAge=25, spouseEdn=3, spouseSiblings=1, spouseCity="Rural", spouseSalary=45000 )
head(df)
ndata1
predict(ptree3,data=ndata1,type='prob')
predict(ptree3,data=ndata1,type='class')
