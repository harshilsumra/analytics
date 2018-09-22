#day1
library(dplyr)
women %>% head(n=5)
head(women,n=5)
mtcars
head(mtcars)
names(mtcars)
mtcars%>%group_by(mpg)%>%summarise(mean(mpg),max(mpg))
mtcars%>%group_by(gear,carb)%>%summarise(mean(mpg),max(mpg),min(hp))
mtcars%>%group_by(gear,carb)%>%summarise_all(mean)
mtcars%>%filter(mpg>25)%>%select(mpg,gear)
mtcars%>%group_by(gear)%>% summarise_if(is.numeric,mean)
?summarise_if
sales%>%group_by(region)%>%summarise_if(is.numeric,mean)
pull(mtcars,gear)
select(mtcars,gear)
mtcars%>%slice(10:20)%>%group_by(mpg,gear,carb)%>%summarise_all(mean)
mtcars%>%filter(disp>150)
count(mtcars%>%filter(disp>150))
