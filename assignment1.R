#Lobna Mtet


#You are given the following data. 
#AGE	INCOME	GENDER	RISK
#31	59193	Female	Low
#45	58381	Male	Low
#43	57388	Female	High
#41	56470	Male	Medium
#36	55554	Female	High
#32	54792	Male	Medium


#Q1) Please use the age data to create a vector called age.
age <- c(31,45,43,41,36,32)
age

#Q2) Please use the income data to create a vector called income
income <- c(59193, 58381, 57388, 56470, 55554, 54792)
income 

#Q3) Please use the gender data to create a vector called gender.
gender <- c("Female", "Male", "Female", "Male", "Female", "Male")
gender
class(gender)
gender = factor(gender)
class(gender)

#Q4) Please use the risk data to create a vector called risk. The order level for risk is low < medium<high
risk <- c ("Low", "Low", "High", "Medium", "High", "Medium")
risk = factor(risk, order = TRUE)
risk = factor (risk, levels = c("Low", "Medium", "High"))
risk

#Q5) Please check the class of each vector: age & income should be numeric; gender should be factor; and risk should be ordered factor.
class(age)
class(income)
class(gender)
class(risk)

#Q6) Please create a data frame called mydata using the four vectors.
mydata <- data.frame(age, income, gender, risk)
mydata

#Q7.a) Display the second row.
mydata[2,]

#Q7.b) Please display only the "risk" column using "$"
mydata$risk

#Q7.c) Only show record 2 to 4
mydata[2:4,]

#Q7.d) For all records, please display only income and risk columns using one statement.
mydata[,c(2, 4)]

