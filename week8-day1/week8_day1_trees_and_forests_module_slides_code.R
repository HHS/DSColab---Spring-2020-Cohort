#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK8 DAY1 TREES AND FORESTS MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 3: Loading packages  ####

library(caret)
library(ROCR)
#install.packages("rpart")
library(rpart)
#install.packages("randomForest")
library(randomForest)


#=================================================-
#### Slide 13: Exercise 1  ####




#=================================================-
#### Slide 19: Load the data  ####

setwd(data_dir)
temp_heart = read.csv("temp_heart_rate.csv", TRUE)


#=================================================-
#### Slide 20: Grow the tree  ####

set.seed(1)
temp_fit  = rpart(Gender ~ .,data = temp_heart)

#print complexity table
printcp(temp_fit)


#=================================================  -
#### Slide 26: Examine the tree: plotcp  ####

plotcp(temp_fit)


#================================================= -
#### Slide 30: Prune the tree in R: Find best cp  ####

# Find the best complexity parameter
bestcp = temp_fit$cptable[        #<- look at the cptable within the temp_fit list
  which.min(temp_fit$cptable      #<- in the cptable
            [,"xerror"]),         #<- look for the min error
            "CP"]                 #<- print the cp value in that row
bestcp


#================================================= -
#### Slide 31: Prune the tree in R: Using best cp  ####

# Prune the tree using the best cp.
temp_pruned = prune(temp_fit, cp = bestcp)
printcp(temp_pruned)


#=================================================-
#### Slide 33: Prune the tree: Not optimal, but pruned  ####

demo_prune = rpart(Gender ~ .,data = temp_heart, control = rpart.control(cp = 0.03))


#=================================================-
#### Slide 35: Exercise 2  ####




#=================================================-
#### Slide 38: Trees on CMP: Remove NAs  ####

setwd(data_dir)
CMP = 
  read.csv("ChemicalManufacturingProcess.csv",
           header = TRUE,
           stringsAsFactors = FALSE)
# NA imputation
ImputeNAsWithMean = function(dataset){ 
  for(i in 1:ncol(dataset)){    
    is_na = is.na(dataset[, i])  
    if(any(is_na)){     
      na_ids = which(is_na)                   
      var_mean = mean(dataset[, i],           
                      na.rm = TRUE)           
      dataset[na_ids, i] = var_mean           
    }
  }
  return(dataset)                            
}
# Impute NAs in CMP dataset.
CMP_NA_impute = ImputeNAsWithMean(CMP)

# rename it as CMP_cleaned
CMP_cleaned = CMP_NA_impute


#=================================================-
#### Slide 39: Trees on CMP: Convert yield column to Categorical  ####

# What are the summary stats of `Yield`?
summary(CMP_cleaned$Yield)

# Median
summary(CMP_cleaned$Yield)[3]

# To convert Yield to binary, lets make everything greater than or equal
# to the median using an ifelse statement
CMP_cleaned$Yield = ifelse(CMP_cleaned$Yield >= 
                           summary(CMP_cleaned$Yield)[3],
                           "High yield",
                           "Low yield" )
# Convert Yield to a factor
CMP_cleaned$Yield = as.factor(CMP_cleaned$Yield)

head(CMP_cleaned$Yield)


#=================================================-
#### Slide 41: CMP_tree: Use caret to split train & test  ####

# Let's split the cleaned dataset into test and train:
# Set the seed.
set.seed(1)

# We will use this to split the actual CMP dataset.
train_index = createDataPartition(CMP_cleaned$Yield,  
                            list = FALSE,       
                            times = 1,          
                            p = 0.7)

# Subset the data to include only train set observations.
CMP_train = CMP_cleaned[train_index, ]

# Subset the data to include only test set observations.
CMP_test = CMP_cleaned[-train_index, ]
# Make sure to name the levels
levels(CMP_train$Yield) =
  make.names(levels(factor(CMP_train$Yield)))

levels(CMP_test$Yield) =
  make.names(levels(factor(CMP_test$Yield)))



#=================================================-
#### Slide 42: CMP_tree: Use rpart within caret  ####

# Run trees, set cv as train control first, include two class summary:
CMP_ctrl = trainControl(method="repeatedcv",
                     repeats = 3)

CMP_tree = train(Yield ~ ., data = CMP_train, 
                method = "rpart", 
                trControl = CMP_ctrl,  
                tuneLength = 20)


#=================================================-
#### Slide 44: CMP_tree: Predict & Assess   ####

# 
# type="prob" gives the probability values
# type="raw" gives the majority class of each observation in test data based on the
# probability values 
# The default for "type" when we don't mention anything in the predict is raw.
treesPredict = predict(CMP_tree,newdata = CMP_test,type="prob")
treesPredict_raw = predict(CMP_tree,newdata = CMP_test,type="raw")


#=================================================-
#### Slide 45: CMP_tree: Assess ROC curve and AUC  ####

# ROC
CMP_rocr_pred = treesPredict[,2]
CMP_trees_preds = prediction(CMP_rocr_pred,labels = CMP_test$Yield)
CMP_trees_perf = performance(CMP_trees_preds,measure="tpr",x.measure = "fpr")

# AUC
CMP_auc.perf = performance(CMP_trees_preds,measure="auc")
CMP_auc.perf@y.values
plot(CMP_trees_perf,col='blue')
abline(a=0,b=1)


#=================================================-
#### Slide 47: Exercise 3  ####




#=================================================-
#### Slide 60: Random forest: CMP  ####

set.seed(1)
mtry = round(                    #<- round the answer to 0 decimal places
        sqrt(ncol(CMP_train)-1)) #<- number of cols in CMP - 1 (- the target var)
       

CMP_rf = randomForest(Yield ~.,
                      data = CMP_train,
                      mtry = mtry,
                      ntree = 100)


#=================================================-
#### Slide 61: CMP forest: Evaluate results  ####

print(CMP_rf)


#=================================================-
#### Slide 62: CMP forest: Predict with test & evaluate  ####

rfPredict = predict(CMP_rf,newdata=CMP_test,type="prob")



#=================================================-
#### Slide 63: CMP forest: ROC curve and AUC  ####

# ROC
CMP_rocr_pred_rf = rfPredict[,2]
CMP_trees_preds_rf = prediction(CMP_rocr_pred_rf,labels = CMP_test$Yield)
CMP_trees_perf_rf = performance(CMP_trees_preds_rf,measure="tpr",x.measure = "fpr")

# AUC
CMP_auc.perf_rf = performance(CMP_trees_preds_rf,measure="auc")
CMP_auc.perf_rf@y.values
plot(CMP_trees_perf_rf,col='red')
abline(a=0,b=1)


#=================================================-
#### Slide 69: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
