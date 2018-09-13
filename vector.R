#vector
x<-c(1:3)
x
y<-c("apple","banana","mango")
y
x1=1:1000000
length(x1)
x1
x3=seq(10,100,3)
x3

#numeric vector----
(marks=rnorm(30,mean=60,sd=10))
?rnorm
mean(marks)
median(marks)
mode(marks)
sd(marks)
var(marks)
summary(marks)
boxplot(marks)
#property fo ds
length(marks)
range(marks)
str(marks)
?str
class(marks)
hist(marks)
plot(density(marks))

#character vector----
(names<-c("Joker","bAtman","catwoman","superman","lex"))
mean(names)
class(names)
summary(names)
gender<-c("M","F","M")
genderf<-factor(gender)
summary(genderf)
grades=c("A","B","C","D","A","C","A","B","D")
gradesf=factor(grades,ordered=T,levels=c("D","B","A","C"))
summary(gradesf)
gradesf
table(gradesf)
table(genderf)
barplot(table(gradesf))
barplot(table(gradesf))
pie(table(gradesf))

#logical vector----

married=c(T,F,T,T,T,F,F,T,T,F,T)
sum(married)
table(married)
class(married)
summary(married)
?pie
marks
trunc(marks);round(marks,1);floor(marks);ceiling(marks)
(marks1=trunc(marks))
marks1[1]
marks1[18]
marks1[1:5]
marks1
marks1[-2]
marks1[c(1,2,4,5,8,16)]
mean(marks1[c(1,2,4,5,8,16)])
marks1[marks1>60]
marks1>60 & marks1<65
marks1[marks1>60 & marks1<75]
set.seed(1234)
gender2=sample(c("M","F"),size=1000000,replace=T,prob=c(0.6,0.4))
gender2
table(gender2)
prop.table(table(gender2))
