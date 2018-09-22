#day1
y=c(1,2,3,NA)
y
is.na(y)
z=na.omit(y)
z
library(VIM)
library(mice)
sleep
head(sleep)
is.na(sleep)
!complete.cases(sleep)
dim(sleep)
complete.cases(sleep)
sleep[complete.cases(sleep),]
sleep[!complete.cases(sleep),]
dim(sleep[complete.cases(sleep),])
dim(sleep[!complete.cases(sleep),])
sum(is.na(sleep$Dream))
mean(is.na(sleep$Dream))
mean(!complete.cases(sleep))
library(mice)
data(sleep, package="VIM")
md.pattern(sleep)


#method2----
library("VIM")
aggr(sleep, prop=FALSE, numbers=TRUE)
aggr(sleep, prop=TRUE, numbers=TRUE)
matrixplot(sleep)#not that cool
marginplot(sleep[c("Gest","Dream")],xlab='gest',ylab='dream', pch=c(20),col=c("darkgray", "red", "blue"))#ask abt this

#method3---- correlation

x <- as.data.frame(abs(is.na(sleep)))
x
head(sleep, n=5)
head(x, n=5)
y <- x[which(apply(x,2,sum)>0)]
y
cor(y)
sleep
y
names(sleep)
names(y)
cor(sleep, use="pairwise.complete.obs")
cor(sleep)
cor(, use="pairwise.complete.obs")#ask about pairwise part
cor(y)
 
#part4
newdata <- sleep[complete.cases(sleep),]
newdata <- na.omit(sleep)
options(digits=1)#ask away
cor(na.omit(sleep))

#to study the impact of life span and length of gestation on the amount of dream sleep, you could employ linear regression with listwise deletion----
fit <- lm(Dream ~ Span + Gest, data=na.omit(sleep))
summary(fit)

#micestuff
# library(mice)
#imp <- mice(data, m)
#fit <- with(imp, analysis)
#pooled <- pool(fit)


library(mice)
data(sleep, package="VIM")
imp <- mice(sleep, seed=1234)
fit <- with(imp, lm(Dream ~ Span + Gest))
pooled <- pool(fit)
summary(pooled)
#complete(imp, action=#) to display one of the 5 imputed datasets

           