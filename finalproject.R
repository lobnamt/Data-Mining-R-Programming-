#read the data
bank<-read.csv("bank-additional-full.csv", header = TRUE,sep=";")
View(bank)

#check the dataframe types
str(bank)

#check missing values 
#we insert mode if the type is categorigal and and avergage if the type is numeric

Mode <-function(dataset, na.rm){
  UniDataSet<-unique (dataset)
  UniDataSet [which.max(tabulate(match(dataset,UniDataSet)))]
  
}

#if anything is unkown replace with NA
bank[bank=="unknown"]<- NA
table(bank$job)

##replace with mode for catigorical columns
for(i in 2:7){
  bank[is.na(bank[,i]), i] <- Mode(bank[,i], na.rm = TRUE)

}

levels(bank$job)
set.seed(1)
train.row<-sample(nrow(bank),nrow(bank)*0.7)
traindata<-bank[train.row,]
testdata<-bank[-train.row,]

###using 'tree' package
library (tree)

#build tree
mytree<-tree (y~.-duration-default,data=traindata)
summary (mytree)

#plot tree
plot (mytree)
text (mytree, cex=0.6,pretty=0)
mytree

