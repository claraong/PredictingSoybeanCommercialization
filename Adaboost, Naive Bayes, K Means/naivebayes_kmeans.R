library(mlbench)
library(e1071)
library(rpart)
library(caret)
library(kernlab)
library(clue)
library(pca)

require(foreign)
require(nnet)
require(ggplot2)
require(reshape2)
library(ggplot2)


install.packages('ggplot2', dep = TRUE)

setwd("C:/Users/User/Dropbox/SoybeanProject4741/Clara_Models")
myvars <- c("CHECK", "RM", "YIELD", "FAM_SEGMENT1", "FAM_SEGMENT2", "FAM_SEGMENT3", "FAM_SEGMENT4", "FAM_SEGMENT5", "GRAD")


train1 <- read.csv("../Split_Data2/training[1].csv")
train1 <- train1[myvars]
train1$GRAD <- as.factor(train1$GRAD)

train2 <- read.csv("../Split_Data2/training[2].csv")
train2 <- train2[myvars]
train2$GRAD <- as.factor(train2$GRAD)

train3 <- read.csv("../Split_Data2/training[3].csv")
train3 <- train3[myvars]
train3$GRAD <- as.factor(train3$GRAD)

train4 <- read.csv("../Split_Data2/training[4].csv")
train4 <- train4[myvars]
train4$GRAD <- as.factor(train4$GRAD)

train5 <- read.csv("../Split_Data2/training[5].csv")
train5 <- train5[myvars]
train5$GRAD <- as.factor(train5$GRAD)


# Test sets # 

test1 <-read.csv("../Split_Data2/test_2010.csv")
test1 <- test1[myvars]
test1$GRAD <- as.factor(test1$GRAD)

test2 <-read.csv("../Split_Data2/test_2011.csv")
test2 <- test2[myvars]
test2$GRAD <- as.factor(test2$GRAD)

test3 <-read.csv("../Split_Data2/test_2012.csv")
test3 <- test3[myvars]
test3$GRAD <- as.factor(test3$GRAD)


test4 <-read.csv("../Split_Data2/test_2013.csv")
test4 <- test4[myvars]
test4$GRAD <- as.factor(test4$GRAD)


test5 <-read.csv("../Split_Data2/test_2014.csv")
test5 <- test5[myvars]
test5$GRAD <- as.factor(test5$GRAD)


#Training error#
nb_model <- naiveBayes(train1$GRAD~., data = train1)
pred <- predict(nb_model, train1[,1:length(myvars)-1])
confusiontrain1 <- confusionMatrix(pred, reference = train1$GRAD, positive='yes')

nb_model <- naiveBayes(train2$GRAD~., data = train2)
pred <- predict(nb_model, train2[,1:length(myvars)-1])
confusiontrain2 <- confusionMatrix(pred, reference = train2$GRAD, positive='yes')

nb_model <- naiveBayes(train3$GRAD~., data = train3)
pred <- predict(nb_model, train3[,1:length(myvars)-1])
confusiontrain3 <- confusionMatrix(pred, reference = train3$GRAD, positive='yes')


nb_model <- naiveBayes(train4$GRAD~., data = train4)
pred <- predict(nb_model, train4[,1:length(myvars)-1])
confusiontrain4 <- confusionMatrix(pred, reference = train4$GRAD, positive='yes')


nb_model <- naiveBayes(train5$GRAD~., data = train5)
pred <- predict(nb_model, train5[,1:length(myvars)-1])
confusiontrain5 <-confusionMatrix(pred, reference = train5$GRAD, positive='yes')


confusiontrain1$table
confusiontrain2$table
confusiontrain3$table
confusiontrain4$table
confusiontrain5$table

confusiontrain1$overall['Accuracy']
confusiontrain2$overall['Accuracy']
confusiontrain3$overall['Accuracy']
confusiontrain4$overall['Accuracy']
confusiontrain5$overall['Accuracy']


#############
# Testing error
nb_model <- naiveBayes(train1$GRAD~., data = train1)
pred <- data.frame(predict(nb_model, test1[,1:length(myvars)-1]))
toprint <-read.csv("../Split_Data2/test_2010.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "naivebayes1.csv")
test1$GRAD<- as.factor(test1$GRAD)
confusion1 <- confusionMatrix(pred, reference = test1$GRAD, positive="yes")

nb_model <- naiveBayes(train2$GRAD~., data = train2)
pred <- predict(nb_model, test2[,1:length(myvars)-1])
test2 <-read.csv("../Split_Data2/test_2011.csv")
new <- cbind (test2, pred)
write.csv(new, file = "naivebayes2.csv")
confusion2 <- confusionMatrix(pred, reference = test2$GRAD, positive='yes')

nb_model <- naiveBayes(train3$GRAD~., data = train3)
pred <- predict(nb_model, test3[,1:length(myvars)-1])
test3 <-read.csv("../Split_Data2/test_2012.csv")
new <- cbind (test3, pred)
write.csv(new, file = "naivebayes3.csv")
confusion3 <- confusionMatrix(pred, reference = test3$GRAD, positive='yes')

nb_model <- naiveBayes(train4$GRAD~., data = train4)
pred <- predict(nb_model, test4[,1:length(myvars)-1])
test4 <-read.csv("../Split_Data2/test_2013.csv")
new <- cbind (test4, pred)
write.csv(new, file = "naivebayes4.csv")
confusion4 <- confusionMatrix(pred, reference = test4$GRAD, positive='yes')

nb_model <- naiveBayes(train5$GRAD~., data = train5)
pred <- predict(nb_model, test5[,1:length(myvars)-1])
test5 <-read.csv("../Split_Data2/test_2014.csv")
new <- cbind (test5, pred)
write.csv(new, file = "naivebayes5.csv")
confusion5 <-confusionMatrix(pred, reference = test5$GRAD, positive='yes')

confusion1$table
confusion2$table
confusion3$table
confusion4$table
confusion5$table

confusion1$overall['Accuracy']
confusion2$overall['Accuracy']
confusion3$overall['Accuracy']
confusion4$overall['Accuracy']
confusion5$overall['Accuracy']

# Prediction set#

test6 <-read.csv("../Split_Data2/prediction_set.csv")
test6 <- test6[myvars]
test6$GRAD <- as.factor(test6$GRAD)
nb_model <- naiveBayes(train5$GRAD~., data = train5) # best model is the 5th one
pred <- predict(nb_model, test6[,length(myvars)-1])
test6 <-read.csv("../Split_Data2/prediction_set.csv")
new <- cbind (test6, pred)
write.csv(new, file = "naivebayes6.csv")


##KMEANS##

setwd("C:/Users/User/Dropbox/SoybeanProject4741/Clara_Models")
myvars <- c("CHECK", "RM", "YIELD", "CLASS_ABSENT", "FAM_SEGMENT1", "FAM_SEGMENT2", "FAM_SEGMENT3", "FAM_SEGMENT4", "FAM_SEGMENT5", "GRAD")


train1 <- read.csv("../Split_Data2/training[1].csv")
train1 <- train1[myvars]
train1$GRAD <- as.factor(train1$GRAD)
train1$CHECK <- as.numeric(train1$CHECK) # change to 1 and 0

train2 <- read.csv("../Split_Data2/training[2].csv")
train2 <- train2[myvars]
train2$GRAD <- as.factor(train2$GRAD)
train2$CHECK <- as.numeric(train2$CHECK)

train3 <- read.csv("../Split_Data2/training[3].csv")
train3 <- train3[myvars]
train3$GRAD <- as.factor(train3$GRAD)
train3$CHECK <- as.numeric(train3$CHECK)

train4 <- read.csv("../Split_Data2/training[4].csv")
train4 <- train4[myvars]
train4$GRAD <- as.factor(train4$GRAD)
train4$CHECK <- as.numeric(train4$CHECK)

train5 <- read.csv("../Split_Data2/training[5].csv")
train5 <- train5[myvars]
train5$GRAD <- as.factor(train5$GRAD)
train5$CHECK <- as.numeric(train5$CHECK)


# test sets # 

test1 <-read.csv("../Split_Data2/test_2010.csv")
test1 <- test1[myvars]
test1$GRAD <- as.factor(test1$GRAD)
test1$CHECK <- as.numeric(test1$CHECK)

test2 <-read.csv("../Split_Data2/test_2011.csv")
test2 <- test2[myvars]
test2$GRAD <- as.factor(test2$GRAD)
test2$CHECK <- as.numeric(test2$CHECK)


test3 <-read.csv("../Split_Data2/test_2012.csv")
test3 <- test3[myvars]
test3$GRAD <- as.factor(test3$GRAD)
test3$CHECK <- as.numeric(test3$CHECK)


test4 <-read.csv("../Split_Data2/test_2013.csv")
test4 <- test4[myvars]
test4$GRAD <- as.factor(test4$GRAD)
test4$CHECK <- as.numeric(test4$CHECK)


test5 <-read.csv("../Split_Data2/test_2014.csv")
test5 <- test5[myvars]
test5$GRAD <- as.factor(test5$GRAD)
test5$CHECK <- as.numeric(test5$CHECK)


# training and testing error for 2 clusters#

cluster1 <- kmeans(train1[,1:dim(train1)[2]-1], 2, nstart = 20)
pred <-cluster1$cluster
tabletrain1 <-table(cl_predict(cluster1, train1[1:length(myvars)-1]), train1$GRAD)
tabletest1 <-table(cl_predict(cluster1, test1[1:length(myvars)-1]), test1$GRAD)
toprint <- read.csv("../Split_Data2/test_2010.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest1_2clusters.csv")


cluster2 <- kmeans(train2[,1:dim(train2)[2]-1], 2, nstart = 20)
pred <-cluster2$cluster
tabletrain2 <-table(cl_predict(cluster2, train2[1:length(myvars)-1]), train2$GRAD)
tabletest2 <-table(cl_predict(cluster2, test2[1:length(myvars)-1]), test2$GRAD)
toprint <- read.csv("../Split_Data2/test_2011.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest2_2clusters.csv")


cluster3 <- kmeans(train3[,1:dim(train3)[2]-1], 2, nstart = 20)
pred <-cluster3$cluster
tabletrain3 <-table(cl_predict(cluster3, train3[1:length(myvars)-1]), train3$GRAD)
tabletest3 <-table(cl_predict(cluster3, test3[1:length(myvars)-1]), test3$GRAD)
toprint <- read.csv("../Split_Data2/test_2012.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest3_2clusters.csv")

cluster4 <- kmeans(train4[,1:dim(train4)[2]-1], 2, nstart = 20)
pred <-cluster4$cluster
tabletrain4 <-table(cl_predict(cluster4, train4[1:length(myvars)-1]), train4$GRAD)
tabletest4 <-table(cl_predict(cluster4, test4[1:length(myvars)-1]), test4$GRAD)
toprint <- read.csv("../Split_Data2/test_2013.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest4_2clusters.csv")


cluster5 <- kmeans(train5[,1:dim(train5)[2]-1], 2, nstart = 20)
pred <-cluster5$cluster
tabletrain5 <-table(cl_predict(cluster5, train5[1:length(myvars)-1]), train5$GRAD)
tabletest5 <-table(cl_predict(cluster5, test5[1:length(myvars)-1]), test5$GRAD)
toprint <- read.csv("../Split_Data2/test_2014.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest5_2clusters.csv")

tabletrain1
tabletrain2
tabletrain3
tabletrain4
tabletrain5

tabletest1
tabletest2
tabletest3
tabletest4
tabletest5



# training and testing error for 3 clusters#

setwd("C:/Users/User/Dropbox/SoybeanProject4741/Clara_Models")
myvars <- c("CHECK", "RM", "YIELD", "CLASS_ABSENT", "FAM_SEGMENT1", "FAM_SEGMENT2", "FAM_SEGMENT3", "FAM_SEGMENT4", "FAM_SEGMENT5", "GRAD")


train1 <- read.csv("../Split_Data2/training[1].csv")
train1 <- train1[myvars]
train1$GRAD <- as.factor(train1$GRAD)
train1$CHECK <- as.numeric(train1$CHECK) # change to 1 and 0

train2 <- read.csv("../Split_Data2/training[2].csv")
train2 <- train2[myvars]
train2$GRAD <- as.factor(train2$GRAD)
train2$CHECK <- as.numeric(train2$CHECK)

train3 <- read.csv("../Split_Data2/training[3].csv")
train3 <- train3[myvars]
train3$GRAD <- as.factor(train3$GRAD)
train3$CHECK <- as.numeric(train3$CHECK)

train4 <- read.csv("../Split_Data2/training[4].csv")
train4 <- train4[myvars]
train4$GRAD <- as.factor(train4$GRAD)
train4$CHECK <- as.numeric(train4$CHECK)

train5 <- read.csv("../Split_Data2/training[5].csv")
train5 <- train5[myvars]
train5$GRAD <- as.factor(train5$GRAD)
train5$CHECK <- as.numeric(train5$CHECK)



cluster1 <- kmeans(train1[,1:dim(train1)[2]-1], 3, nstart = 20)
pred <-cluster1$cluster
tabletrain1 <-table(cl_predict(cluster1, train1[1:length(myvars)-1]), train1$GRAD)
tabletest1 <-table(cl_predict(cluster1, test1[1:length(myvars)-1]), test1$GRAD)
toprint <- read.csv("../Split_Data2/test_2009.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest1_3clusters.csv")


cluster2 <- kmeans(train2[,1:dim(train2)[2]-1], 3, nstart = 20)
pred <-cluster2$cluster
tabletrain2 <-table(cl_predict(cluster2, train2[1:length(myvars)-1]), train2$GRAD)
tabletest2 <-table(cl_predict(cluster2, test2[1:length(myvars)-1]), test2$GRAD)
toprint <- read.csv("../Split_Data2/test_2010.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest2_3clusters.csv")


cluster3 <- kmeans(train3[,1:dim(train3)[2]-1], 3, nstart = 20)
pred <-cluster3$cluster
tabletrain3 <-table(cl_predict(cluster3, train3[1:length(myvars)-1]), train3$GRAD)
tabletest3 <-table(cl_predict(cluster3, test3[1:length(myvars)-1]), test3$GRAD)
toprint <- read.csv("../Split_Data2/test_2011.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest3_3clusters.csv")



cluster4 <- kmeans(train4[,1:dim(train4)[2]-1], 3, nstart = 20)
pred <-cluster4$cluster
tabletrain4 <-table(cl_predict(cluster4, train4[1:length(myvars)-1]), train4$GRAD)
tabletest4 <-table(cl_predict(cluster4, test4[1:length(myvars)-1]), test4$GRAD)
toprint <- read.csv("../Split_Data2/test_2012.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest4_3clusters.csv")


cluster5 <- kmeans(train5[,1:dim(train5)[2]-1], 3, nstart = 20)
pred <-cluster5$cluster
tabletrain5 <-table(cl_predict(cluster5, train5[1:length(myvars)-1]), train5$GRAD)
tabletest5 <-table(cl_predict(cluster5, test5[1:length(myvars)-1]), test5$GRAD)
toprint <- read.csv("../Split_Data2/test_2014.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest5_3clusters.csv")


tabletrain1
tabletrain2
tabletrain3
tabletrain4
tabletrain5

tabletest1
tabletest2
tabletest3
tabletest4
tabletest5



# Prediction set for 3 clusters #

test6 <-read.csv("../Split_Data2/prediction_set.csv")
test6 <- test6[myvars]
test6$GRAD <- as.factor(test6$GRAD)


cluster6 <- kmeans(train4[,1:dim(train4)[2]-1], 3, nstart = 20) # best model is the 4th one
pred <-cluster6$cluster
tablepred <-table(cl_predict(cluster6, train4[1:length(myvars)-1]), train5$GRAD)
toprint <- read.csv("../Split_Data2/prediction_set.csv")
new <- cbind (toprint, pred)
write.csv(new, file = "kmeanstest6_3clusters.csv")


