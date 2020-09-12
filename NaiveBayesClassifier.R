
rm(list=ls())
#install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
##install.packages("gridExtra")
library(gridExtra)
#install.packages('mice')
library(mice)
#install.packages("naivebayes")
library(naivebayes)
#install.packages('caret')
library(caret)
#install.packages("dplyr")
library(dplyr)
#install.packages("Metrics")
library(Metrics)


set.seed(14)


Data_Bank <- read.csv("Qualitative_Bankruptcy.data.txt")
colnames(Data_Bank)= c("IndustrialRisk","ManagementRisk","FinancialFlexibility","Credibility","Competitiveness","OperatingRisk","Class")
#Data_Bank=as.data.frame(Data_Bank)

typeof(Data_Bank)

Data_Bank$IndustrialRisk <-as.numeric(factor(Data_Bank$IndustrialRisk, levels = c("N","A","P"),labels = c('0','1','2')))
Data_Bank$ManagementRisk<- as.numeric(factor(Data_Bank$ManagementRisk, levels = c("N","A","P"),labels = c('0','1','2')))
Data_Bank$FinancialFlexibility <- as.numeric(factor(Data_Bank$FinancialFlexibility, levels = c("N","A","P"),labels = c('0','1','2')))
Data_Bank$Credibility <- as.numeric(factor(Data_Bank$Credibility, levels = c("N","A","P"),labels = c('0','1','2')))
Data_Bank$Competitiveness <- as.numeric(factor(Data_Bank$Competitiveness, levels = c("N","A","P"),labels = c('0','1','2')))
Data_Bank$OperatingRisk<- as.numeric(factor(Data_Bank$OperatingRisk, levels = c("N","A","P"),labels = c('0','1','2')))

M<- as.matrix(Data_Bank)
y <- Data_Bank[[7]]

#training
sample_size <- floor(2/3 * nrow(M))
sample= sample(seq_len(nrow(M)), size = sample_size)

train_data=M[sample,-7]
y1=M[sample,7]

test_data=M[-sample,-7]
y2=M[-sample,7]

nb <- naive_bayes(train_data, y1, usekernel = TRUE,laplace = T)
head(predict(nb,test_data, type = "prob")) #posterior proba
head(predict(nb,test_data, type = "class")) # the highest proba gives their class


#nb$prior
#which leads to : 
pred_train_proba=predict(nb,test_data,type="prob")
pred_train_proba


pred_train=predict(nb,test_data,type="class")
pred_train

#to be compared with y2

confusionMatrix(pred_train,as.factor(y2))


##    without competitivness  !!


train_data2=train_data[,-5]

test_data=test_data[,-5]

nb2 <- naive_bayes(train_data2, y1, usekernel = TRUE,laplace = T)
head(predict(nb2,test_data, type = "prob")) #posterior proba
head(predict(nb2,test_data, type = "class")) # the highest proba gives their class


#nb$prior
#which leads to : 
pred_train_proba=predict(nb2,test_data,type="prob")
pred_train_proba


pred_train=predict(nb2,test_data,type="class")
pred_train

#to be compared with y2

confusionMatrix(pred_train,as.factor(y2))



#mosaic plots

plot(nb, which = 1)

plot(nb, which = 2)

plot(nb, which = 3)

plot(nb, which = 4)

plot(nb, which = 5) #resolved with laplace

plot(nb, which = 6)

 
