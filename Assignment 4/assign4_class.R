
#read data. please set working director to where you save the data file
Risk<-read.table("Risk.txt",head=TRUE, sep = "\t")

#check type of each column
sapply (Risk,class)

#check structure of the data
str (Risk)

#remove space before and after a string in factor column
Risk$RISK<-as.factor(trimws (Risk$RISK))
levels (Risk$RISK)

Risk$HOWPAID<-as.factor (trimws(Risk$HOWPAID))
levels (Risk$HOWPAID)

Risk$MARITAL<-as.factor(trimws (Risk$MARITAL))
levels (Risk$MARITAL)

names (Risk)


#min-max normalization; change scale
normalize_min_maz<- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
#normalize numeric columns
Risk [,c(2,3,6,7,10,11)]<-normalize_min_maz (Risk [,c(2,3,6,7,10,11)])
head (Risk)

levels (Risk$RISK)

#class good profit as good and classify both bad profit and bad loss as bad
#Save the new outcome to new target variable RISKNew
Risk$RISKNew<-ifelse(Risk$RISK=="good risk","good","bad")
# convert ISKNew to factor
Risk$RISKNew<-as.factor(Risk$RISKNew)
names (Risk)

#Question 1, please drop ID and RISK columns
Risk <-Risk[,-c(1,12) ]
head(Risk)
View (Risk)


#Quesion 2, please use tree functio to build a decision tree that predict RISKNew
library (tree)
mytree<-tree (RISKNew~AGE+INCOME+GENDER+MARITAL+NUMKIDS+NUMCARDS+HOWPAID+MORTGAGE+STORECAR+LOANS,data=Risk)
mytree

#plot tree
plot (mytree)
text (mytree, cex=0.6, pretty=0)

#Question 3. #Please based on the tree model to select relevant input variables that will be used in neural network
#Note the target variable should be RISKNew


#INCOME 
#MARITAL = single, married, divsewid
#LOANS 
#NUMKIDS


#Question 4. Please create dummy variable for categorical input variable
#hint class.ind function
library(nnet)

dummy_risk<-class.ind(Risk$MARITAL)
dummy_risk2<-class.ind(Risk$RISKNew)
View(dummy_risk)

#Question 5. Please add the dummy variable to the data frame that will be used to build neural network
#hint: cbind function
dummy_risk<-cbind (Risk, dummy_risk2, dummy_risk)
View(dummy_risk)


#Q6. Build a neural network model (neuralnet fucntion) and draw the network
#note-- we are not using partition in this exercises, but usually we should in project.
library(neuralnet)
class(dummy_risk$RISKNew)
set.seed(12)
str(dummy_risk)
nn_risk <- neuralnet(bad + good ~INCOME + LOANS + NUMKIDS+ married + single + divsepwid, data = dummy_risk, linear.output = F, hidden = 3)
plot(nn_risk, rep="best")


#Q7. Use compute function to make prediction and use confusionMatrix to check performance
library(caret)

predict_risk <- compute(nn_risk, data.frame(dummy_risk$INCOME, dummy_risk$LOANS, dummy_risk$NUMKIDS, dummy_risk$married, dummy_risk$single, dummy_risk$divsepwid))
help (compute)

predict_risk$net.result # probability

predicted.class=apply(predict_risk$net.result,1,which.max)

# the position of the column that has the highest probability of each row
predicted.class

#if the returned position is 2, then it is good; otherwise it is bad
predicted.value<-ifelse(predicted.class=="2", "good", "bad")
predicted.value

#check variable type before using confusionMatrix. ConfusionMatrix needs factor type
class (predicted.value)
predicted.value<-as.factor (predicted.value)
class (predicted.value)

confusionMatrix(predicted.value, dummy_risk$RISKNew)



