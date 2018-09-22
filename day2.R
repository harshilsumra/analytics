#Day2starts

#Regression#diagnostic----
women
head(women)
dim(women)
str(women)
options(digits=4)
cor(women$height,women$weight)
cov(women$height,women$weight)
plot(women,type='b',lty=2,pch=4)
w=lm(weight~height,data=women)
summary(w)
range(women$weight)
range(women$height)

#weight=-87.5167 + 3.4500(height) for height 58 to 72

fitted(w)
names(w)
j=cbind(women,fitted(w))
j
cbind(women,fitted(w),residuals(w))
#to predict for 62.5
ndata1=data.frame(height=c(62.5,63.5))
predict(w,newdata = ndata1)
cbind(ndata1,predict(w,newdata = ndata1))

#multivariate
names(mtcars)
m=lm(mpg~wt+hp,data=mtcars)
plot(m)
summary(m)
range(mtcars$wt);range(mtcars$hp)
ndata2=data.frame(wt=c(2.2,3.4,4.5),hp=c(57,200,250))
predict(m,newdata = ndata2)
cbind(ndata2,predict(m,newdata = ndata2))
library(olsrr)
model <- lm(mpg ~ disp + hp + wt + qsec, data = mtcars)
k <- ols_step_all_possible(model)
plot(k)
k
summary(lm(mpg ~ wt, data=mtcars))
summary(lm(mpg ~ wt+ hp, data=mtcars))

#logit model----

#Logistic Regression : Predict Probability of Selection 

df =  read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

## view the first few rows of the data
head(df)
str(df)
sum(is.na(df))

## two-way contingency table of categorical outcome and predictors we want to make sure there are no empty cells
xtabs(~admit + rank, data = df)

#convert rank into factors
df$rank = factor(df$rank)
df$admit=factor(df$admit)
fit3 = glm(admit ~ gre + gpa + rank, data=df,family="binomial")
summary(fit3)

#predict probabilities of original values
(prob=predict(fit3,type=c("response")))
cbind(df, prob)

#Test with new data
(newdata1 = data.frame(gre = mean(df$gre), gpa = mean(df$gpa), rank = factor(1)))
cbind(newdata1, predictProb=predict(fit3, newdata = newdata1, type="response"))
#if prob > 0.5, we say select = 1

#another set of data for prediction
range(df$gre); range(df$gpa);levels(df$rank)
(newdata2 = data.frame(gre = c(200, 300, 400, 500), gpa = c(2.5, 3, 3.3, 3.75), rank = factor(c(1,2,3,4))))
str(newdata2)
newdata2b = cbind(newdata2, predictProb2=predict(fit3, newdata = newdata2, type = "response"))
newdata2b


#this way you predict Probabilites
