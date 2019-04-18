#Group Work
#Lobna Mtet
#Xiaochun Kuang

#Q1) Please read SmallSample.csv data and create a data frame variable call smallsample.
smallsample<- read.csv("SmallSample.csv", header = TRUE)
class(smallsample)
View(smallsample)

#Q2) Please show the first six records to check data frame format
head(smallsample)

#Q3) Please show the structure of the data
str(smallsample)

#Q4) Please check every column's class: age& income should be numeric; gender, marital, and risk should be factor. numkids (number of kids)  should be integer. If they are not the correct type, please change them.
class(smallsample$AGE)
class(smallsample$INCOME)
class(smallsample$GENDER)
class(smallsample$MARITAL)
class(smallsample$RISK)
class(smallsample$NUMKIDS)

#Q5) For the factor column, please display and check their levels and frequency for each level.
levels (smallsample$GENDER)
table(smallsample$GENDER)
levels(smallsample$MARITAL)
table(smallsample$MARITAL)
levels(smallsample$RISK)
table(smallsample$RISK)

#Q6) Please calculate and display the mean of age and income for all the records
mean(smallsample$AGE)
mean(smallsample$INCOME)

#Q7) Please calculate and display the mean of income for each category of risk 
tapply (smallsample$INCOME, smallsample$RISK, mean)

#Q8) 8.	Please create 3 bins for income, and label them "low", "medium", and "high" using equal width strategy. And please add a new column to the data frame of samllsample  and call it INCOMELEVEL. Please assign the binning results to the new column.
c1<-cut(smallsample$INCOME,breaks = 3,labels=c ("low", "medium", "high"))
c1
smallsample$INCOMELEVEL <- c1
head(smallsample)
View(smallsample)

#Q9) Please display how many records fall into "low" income level category.
table(smallsample$INCOMELEVEL, exclude = c("medium", "high"))
      
