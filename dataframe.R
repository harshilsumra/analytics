#day1
#data.frame

#roll no, name, batch, gender, marks1, marks2
rollno=c(1:30)
name=paste("student",1:30,sep='')
batch=sample(c(2016,2017,2018),size=30,replace=T)
table(batch)
gender3=sample(c("M","F"),size=30,replace=T)
table(gender3)
(marks1=rnorm(30,mean=65,sd=7))
(marks2=rnorm(30,mean=60,sd=10))
df=data.frame(rollno,name,batch,gender3,marks1,marks2)
df
summary(df)
str(df)
df$name
df$gender3=factor(df$gender3)
df$batch=factor(df$batch,ordered=T,levels=c('2016','2017','2018'))
str(df)
df
summary(df)
df$rollno=as.character(df$rollno)
summary(df)
str(df)
head(df)
tail(df)
dim(df)
nrow(df)
ncol(df)
names(df)
df[1:2,1:4]
df[c(1,3),c(1,4,5,6)]
df[df$gender3=='M',]
df[df$gender3=='M',3:6]#disp only 3rd to 6th column
df[df$gender3=='F' & df$marks1>70,]
length(df)
nrow(df)
nrow(df[df$gender3=='M',])
sort(df$marks1)
order(df$marks1)
df$marks1
df[order(df$marks1),]
rev(sort(df$marks1))
sort(df$marks1)
df[order(df$gender3,df$batch),]
df[order(gender3,-batch),]

#summarising----

aggregate(df$marks1,by=list(df$batch),FUN=mean)
aggregate(marks1~batch,data=df,FUN=mean)
aggregate(cbind(marks1,marks2)~batch,data=df,FUN=mean)
aggregate(cbind(marks1,marks2)~batch+gender3,data=df,FUN=mean)
df2<-data.frame(aggregate(cbind(marks1,marks2)~batch+gender3,data=df,FUN=mean))
aggregate(cbind(marks1,marks2)~batch+gender3,data=df,FUN=max)
df
write.csv(df,"./data/bitsgoa.csv")
df2<-read.csv(file.choose())
df2
head(df2)
df2=df2[,-1]
df2
head(df2)
library()
