require(randomForest)
require(caTools)
require(caret)
require(MBMethPred)
# By @biomedical_informatics Edris Sharif Rahmani Jun 15, 2023
load("Data.RData")
ntaget <- ncol(Data)
split <- sample.split(Data[,ntaget], SplitRatio = 0.8)
training_set <- subset(Data, split == TRUE)
test_set <- subset(Data, split == FALSE)
rfimp <- randomForest(Class ~ ., 
                      data = training_set, 
                      ntree = 300,
                      importance=TRUE,
                      maxnodes = 6)
y_pred <- predict(rfimp, newdata = test_set[-ntaget])
result <- ConfusionMatrix(test_set[, ntaget], y_pred)
imp <- varImp(rfimp)
imp <- imp[imp > 2,]
imp <- na.omit(imp)
View(Data)
View(imp)
