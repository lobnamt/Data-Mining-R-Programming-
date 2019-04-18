#Lobna Mtet
#Xiaochun Kuang
#Oluwole Awoyiola

#Q1) Please read Risk.txt data.
myTable<-read.table("Risk.txt",header = TRUE,sep="\t")
View(myTable)
head(myTable)

#Q2) Please check the structure of the data and type of each column
str(myTable)
sapply(myTable, class)

#Q3) Please show histogram of INCOME
library(ggplot2)
ggplot(myTable, aes(x=INCOME))+geom_histogram()

#Q4) Please show bar chart for GENDER and MARITAL
ggplot(myTable, aes(x=MARITAL)) + geom_bar()
ggplot(myTable, aes(x=GENDER)) + geom_bar()

#Q5) Please show normalized overlay chart for GENDER and MARITAL using the target variable RISK 
ggplot(myTable,aes(x=factor(MARITAL), fill=factor(RISK)))+geom_bar(position="fill")
ggplot(myTable,aes(x=factor(GENDER), fill=factor(RISK)))+geom_bar(position="fill")


#Q7) Please create training and test data. 
set.seed(6)
s<-sample(2,nrow(myTable),replace = TRUE,prob=c(0.7,0.3))
s
mytrain_set<-myTable[s==1,]
mytest_set<-myTable [s==2,]
nrow(mytrain_set)
nrow(mytest_set)

#Q8) Please build a decision tree model using the training data 
library(tree)
names(mytrain_set)
decision_tree<-tree (RISK~AGE+INCOME+GENDER+MARITAL+NUMKIDS+NUMCARDS+HOWPAID+MORTGAGE+STORECAR+LOANS, data=mytrain_set)
summary (mytree)


#Q9) Please plot the decision tree model
#plot the tree
decision_tree
plot(decision_tree)
text (decision_tree,cex=1, pretty = 0)
#test on trainset
train_tree<-predict(decision_tree, mytrain_set, type="class")
length(mytrain_set[,12])
length (train_tree)
table (train_tree,mytrain_set[,12])
#error rate
mean (train_tree!=mytrain_set[,12])


#Q11)	Please use the decision tree model to make prediction on the test data.
#test on test set
pred_test<-predict (decision_tree, mytest_set, type="class")
pred_test
summary(pred_test)
table (pred_test,mytest_set[,12])

#Q12 12.	Please compare the error rates on the training data and test data. Do you see an overfitting problem? Why?
mean (pred_test!=mytest_set[,12])
mean (train_tree!=mytrain_set[,12])
#According to the error rates, there is no overfitting problem because the error rates are almost equal. 
#Thus, the model didn't just memorize the data in the training set.




