getwd()
rm(list=ls())
#install.packages("tidyverse")
library(tidyverse)
library(ggplot2)
##install.packages("gridExtra")
library(gridExtra)
#install.packages('mice')
library(mice)
#install.packages('caret')
library(caret)
set.seed(14)
#install.packages("dplyr")
library(dplyr)
#install.packages("corrgram")
library(corrgram)

Data_Bank <- read.csv("Qualitative_Bankruptcy.data.txt")
colnames(Data_Bank)= c("IndustrialRisk","ManagementRisk","FinancialFlexibility","Credibility","Competitiveness","OperatingRisk","Class")
Data_Bank=as.data.frame(Data_Bank)


#missmap(Data_Bank)
head(Data_Bank)
str(Data_Bank)


#Number of occurences of classes:
table(unlist(Data_Bank$Class))
#
table(unlist(Data_Bank$IndustrialRisk))
#graphically :

#attach(Data_Bank)
#detach(Data_Bank)


#descriptive analysis of data: barplots
 #change order
Data_Bank$IndustrialRisk <- factor(Data_Bank$IndustrialRisk, levels = c("N","A","P"))
Data_Bank$ManagementRisk<- factor(Data_Bank$ManagementRisk, levels = c("N","A","P"))
Data_Bank$FinancialFlexibility <- factor(Data_Bank$FinancialFlexibility, levels = c("N","A","P"))
Data_Bank$Credibility <- factor(Data_Bank$Credibility, levels = c("N","A","P"))
Data_Bank$Competitiveness <- factor(Data_Bank$Competitiveness, levels = c("N","A","P"))
Data_Bank$OperatingRisk<- factor(Data_Bank$OperatingRisk, levels = c("N","A","P"))


P1=ggplot(Data_Bank, aes(x=Data_Bank$IndustrialRisk,fill=Data_Bank$IndustrialRisk))
P1=P1+geom_bar(stat = 'count')
P1=P1 + theme(legend.position = "none")

P2=ggplot(Data_Bank, aes(x=Data_Bank$ManagementRisk,fill=Data_Bank$ManagementRisk))
P2=P2+geom_bar(stat = 'count')
P2=P2+ theme(legend.position = "none")

P3=ggplot(Data_Bank, aes(x=Data_Bank$FinancialFlexibility,fill=Data_Bank$FinancialFlexibility))
P3=P3+geom_bar(stat = 'count')
P3=P3+ theme(legend.position = "none")

P4=ggplot(Data_Bank, aes(x=Data_Bank$Credibility,fill=Data_Bank$Credibility))
P4=P4+geom_bar(stat = 'count')
P4=P4+ theme(legend.position = "none")

P5=ggplot(Data_Bank, aes(x=Data_Bank$Competitiveness,fill=Data_Bank$Competitiveness))
P5=P5+geom_bar(stat = 'count')
P5=P5+ theme(legend.position = "none")

P6=ggplot(Data_Bank, aes(x=Data_Bank$OperatingRisk,fill=Data_Bank$OperatingRisk))
P6=P6+geom_bar(stat = 'count')
P6=P6+ theme(legend.position = "none")

P7=ggplot(Data_Bank, aes(x=Data_Bank$Class,fill=Data_Bank$Class))
P7=P7+geom_bar(stat = 'count')
P7=P7+ theme(legend.position = "none")


grid.arrange(P1,P2,P3,P4,P5,P6,nrow=2)

#separately : 
p21=ggplot(Data_Bank, aes(x=Data_Bank$IndustrialRisk,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  facet_grid(~Data_Bank$Class)+
  ylab("Proportion")
p21


p2=ggplot(Data_Bank, aes(x=Data_Bank$IndustrialRisk,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  ylab("Percentage")
p2


p31=ggplot(Data_Bank, aes(x=Data_Bank$ManagementRisk,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  facet_grid(~Data_Bank$Class)+
  ylab("Percentage")
p31

p3=ggplot(Data_Bank, aes(x=Data_Bank$ManagementRisk,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  ylab("Percentage")
p3


p41=ggplot(Data_Bank, aes(x=Data_Bank$FinancialFlexibility,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  facet_grid(~Data_Bank$Class)+
  ylab("Percentage")
p41

p4=ggplot(Data_Bank, aes(x=Data_Bank$FinancialFlexibility,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  ylab("Percentage")
p4
#woooow interesting


p51=ggplot(Data_Bank, aes(x=Data_Bank$Credibility,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  facet_grid(~Data_Bank$Class)+
  ylab("Percentage")
p51


p5=ggplot(Data_Bank, aes(x=Data_Bank$Credibility,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  ylab("Percentage")
p5

p61=ggplot(Data_Bank, aes(x=Data_Bank$Competitiveness,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  facet_grid(~Data_Bank$Class)+
  ylab("Percentage")
p61

p6=ggplot(Data_Bank, aes(x=Data_Bank$Competitiveness,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  ylab("Percentage")
p6
#woooooooooooow


p71=ggplot(Data_Bank, aes(x=Data_Bank$OperatingRisk,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  facet_grid(~Data_Bank$Class)+
  ylab("Percentage")
p71


p7=ggplot(Data_Bank, aes(x=Data_Bank$OperatingRisk,fill=Data_Bank$Class))+
  geom_bar(aes(y =(..count..)/sum(..count..)), width=0.9)+
  ylab("Percentage")
p7

grid.arrange(p2,p3,p4,p5,p6,p7,nrow=2)

#grid.arrange(p21,p31,p41,p51,p61,p71,nrow=2)

p61

grid.arrange(P1,p2,P2,p3,P3,p4,P4,p5,P5,p6,P6,p7,nrow=7)


##data transformation

Data_Bank$IndustrialRisk <- factor(Data_Bank$IndustrialRisk, levels = c("N","A","P"),labels = c('0','1','2'))
Data_Bank$ManagementRisk<- factor(Data_Bank$ManagementRisk, levels = c("N","A","P"),labels = c('0','1','2'))
Data_Bank$FinancialFlexibility <- factor(Data_Bank$FinancialFlexibility, levels = c("N","A","P"),labels = c('0','1','2'))
Data_Bank$Credibility <- factor(Data_Bank$Credibility, levels = c("N","A","P"),labels = c('0','1','2'))
Data_Bank$Competitiveness <- factor(Data_Bank$Competitiveness, levels = c("N","A","P"),labels = c('0','1','2'))
Data_Bank$OperatingRisk<- factor(Data_Bank$OperatingRisk, levels = c("N","A","P"),labels = c('0','1','2'))
Data_Bank$Class<- factor(Data_Bank$Class, levels = c("NB","B"),labels = c('0','1'))

head(Data_Bank)


#linear dependances between variables :
Data_Bank$IndustrialRisk<- as.numeric(as.character(Data_Bank$IndustrialRisk))
Data_Bank$ManagementRisk<- as.numeric(as.character(Data_Bank$ManagementRisk))
Data_Bank$FinancialFlexibility<- as.numeric(as.character(Data_Bank$FinancialFlexibility))
Data_Bank$Credibility<- as.numeric(as.character(Data_Bank$Credibility))
Data_Bank$Competitiveness<- as.numeric(as.character(Data_Bank$Competitiveness))
Data_Bank$OperatingRisk<- as.numeric(as.character(Data_Bank$OperatingRisk))
Data_Bank$Class<- as.numeric(as.character(Data_Bank$Class))
cor(Data_Bank[-7])
corrgram(Data_Bank[-7])

