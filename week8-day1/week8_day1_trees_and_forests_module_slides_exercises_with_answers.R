#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK8 DAY1 TREES AND FORESTS MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####
# Below is the data frame Outside, Play is the target variable while the Outlook, Temp and Humidity are predictors. 
# View the data frame and identify which predictor variable splits the target variable more cleanly? 
# Hint: which predictor values aligns with the target values.

Outside = data.frame(Outlook=c("sunny", "sunny", "cloudy", "sunny"),
                     Temp = c("hot", "hot", "cool", "cool"),
                     Humidity = c("high", "low", "high", "low"),
                     Play = c("no", "no", "yes", "yes"))


# Answer:
View(Outside)
# Temp aligns with Play clearly.
#==============================================-

#### Question 2 ####
# There is a total of 10 squares, find the Gini impurity for the following cases:
# 1) There are 7 Red and 3 Blue squares
# 2) There are 5 Red and 5 Blue squares
# 3) All 10 are Blue squares

# Answer:
1 - ((7/10)^2 + (3/10)^2)
# 0.42
1 - ((5/10)^2 + (5/10)^2)
# 0.5
1 - ((0/10)^2 + (10/10)^2)
# 0
#==============================================-

#### Question 3 ####
# Set the main_dir, data_dir and plot_dir.
# set the working directory to data_dir.
# Load tidyverse, ROCR and Caret packages.
# Install and Load Random Forest and rpart packages.

# Hints:
# Set `main_dir` to the location of your `hhs-r` folder (for Mac/Linux).
# main_dir = "~/Desktop/hhs-r-2020"
# Set `main_dir` to the location of your `hhs-r` folder (for Windows).
# main_dir = "C:/Users/[username]/Desktop/hhs-r-2020"
# Make `data_dir` from the `main_dir` and 
# remainder of the path to data directory.
# data_dir = paste0(main_dir, "/data")
# Make `plots_dir` from the `main_dir` and 
# remainder of the path to plots directory.
# plot_dir = paste0(main_dir, "/plots")

# Answer:
# Set `main_dir` to the location of your `hhs-r` folder (for Mac/Linux).
main_dir = "~/Desktop/hhs-r-2020"
# Set `main_dir` to the location of your `hhs-r` folder (for Windows).
main_dir = "C:/Users/[username]/Desktop/hhs-r-2020"
# Make `data_dir` from the `main_dir` and 
# remainder of the path to data directory.
data_dir = paste0(main_dir, "/data")
# Make `plots_dir` from the `main_dir` and 
# remainder of the path to plots directory.
plot_dir = paste0(main_dir, "/plots")
setwd(data_dir)
# Load ROCR and Caret packages.
library(ROCR)
library(caret)
library(tidyverse)

# Install and Load Random Forest and rpart packages.
library(randomForest)
library(rpart)
#==============================================-

#### Question 4 ####
# Read the fast_food_data.csv to dataframe fast_food.
# Analyze the structure and summary of the data.
# Handle NA's if there are any by replacing with the mean.
# Print the column names of the dataframe.
# Rename the columns with the names - restaurant, item, type, size, calories, 
# total_fat, saturated_fat, trans_fat, sodium, carbs, sugars, proteins, revenue.
# Add a column to fast_food by creating a new variable cals_per_gram that is "High" if the ratio of 'Calories' to 'size' is greater than 2.5, and "Low" otherwise. Convert the column to factor.

# Answer:
fast_food = read.csv("fast_food_data.csv", TRUE)
str(fast_food)
summary(fast_food)
fast_food[which(is.na(fast_food$Trans.Fat..g.)), "Trans.Fat..g."] = mean(fast_food$Trans.Fat..g., na.rm=TRUE)

colnames(fast_food)
colnames(fast_food) = c('restaurant', 'item', 'type', 'size', 'calories', 'total_fat','saturated_fat', 'trans_fat', 'sodium', 'carbs', 'sugars', 'proteins', 'revenue')

fast_food = fast_food %>%
  mutate(cals_per_gram = ifelse((calories/size) > 2.5, "High", "Low")) %>%
  mutate(cals_per_gram = as.factor(cals_per_gram))



#### Exercise 2 ####
# =================================================-

#### Question 1 ####
# Select only the total_fat, sugars, carbs, sodium, proteins, and cals_per_gram   variables in the fast_food dataframe.
# Fit the tree by taking cals_per_gram as the target variable and total_fat, 
# sugars, carbs, sodium and proteins as the independent variables by setting seed to 1.
# Print the complexity table.
# Examine the tree by plotting it and adding text, and printing it as well.

# Answer:
fast_food = fast_food %>%
  select(total_fat, sugars, carbs, sodium, proteins, cals_per_gram)

set.seed(1)
tree_fit = rpart(formula = cals_per_gram ~ ., data = fast_food)

printcp(tree_fit)

plot(tree_fit)
text(tree_fit)

print(tree_fit)
#==============================================-

#### Question 2 ####
# Find the best complexity parameter. 
# Prune the tree with 0.03 as cp.
# Compare the pruned tree to the previous tree.

# Answer:
# Find the best complexity parameter
bestcp = tree_fit$cptable[        #<- look at the cptable within the temp_fit list
  which.min(tree_fit$cptable      #<- in the cptable
            [,"xerror"]),         #<- look for the min error
  "CP"]                 #<- print the cp value in that row
bestcp

temp_pruned = prune(tree_fit, cp = bestcp)
printcp(temp_pruned)

demo_prune = rpart(cals_per_gram ~ total_fat+sugars+carbs+sodium+proteins,data = fast_food, control = rpart.control(cp = 0.03))
demo_prune

plot(demo_prune)
text(demo_prune)


#### Exercise 3 ####
# =================================================-

#### Question 1 ####
# Create a training set on the fast_food data set which contains 70 percent of the observations.
# Create a test set with the remaining observations.
# Name the two datasets as fast_food_train and fast_food_test respectively.

# Answer:
train_index = createDataPartition(fast_food$cals_per_gram,  
                                  list = FALSE,       
                                  times = 1,          
                                  p = 0.7)

# Create the training subset
fast_food_train = fast_food[train_index,]

# Create the test subset
fast_food_test = fast_food[-train_index,]

#==============================================-

#### Question 2 ####
# Name the levels of the target variable cals_per_gram in both the training and test sets as shown in the module.

# Answer:

levels(fast_food_train$cals_per_gram) =
  make.names(levels(factor(fast_food_train$cals_per_gram)))

levels(fast_food_test$cals_per_gram) =
  make.names(levels(factor(fast_food_test$cals_per_gram)))

#==============================================-

#### Question 3 ####
# Create a tree model that predicts cals_per_gram with all other variables in the 
# fast_food_train dataframe.
# Set the trControl parameter to use method="repeatedcv" with repeats = 3. 
# Set all other parameters the same way we did in the module.
# Print the tree. Where did we realize the greatest accuracy?

# Answer:
# Our greatest accuracy is realized with cp = 0.05140759.
fast_food_ctrl = trainControl(method="repeatedcv",
                              repeats = 3)

fast_food_tree = train(cals_per_gram ~ ., 
                       data = fast_food_train, 
                       method = "rpart", 
                       trControl = fast_food_ctrl,  
                       tuneLength = 20)

print(fast_food_tree)

#==============================================-

#### Question 4 ####
# Create a prediction on the test set using the fast_food_tree model. 
# Do not specify the type parameter.
# Calculate the accuracy using the confusionMatrix function.

# Answer:
treesPredict = predict(fast_food_tree, newdata = fast_food_test)
confusionMatrix(treesPredict, fast_food_test$cals_per_gram)
# Accuracy : 0.8108

#==============================================-

#### Question 5 ####
# Create a prediction on the test set using the fast_food_tree model, this time
# specifying type="prob".
# Calculate the AUC and lot the ROC curve.

# Answer:
treesPredict2 = predict(fast_food_tree, newdata = fast_food_test, type = "prob")

ff_rocr_pred = treesPredict2[,2]
ff_trees_preds = prediction(ff_rocr_pred, labels = fast_food_test$cals_per_gram)
ff_trees_perf = performance(ff_trees_preds, measure="tpr", x.measure = "fpr")

ff_auc.perf = performance(ff_trees_preds, measure = "auc")
ff_auc.perf@y.values
# The AUC is 0.8231

plot(ff_trees_perf, col = 'blue') #<- plot the performance (ROC curve)
abline(a = 0, b = 1) #<- add the line y=x


#### Exercise 4 ####
# =================================================-

#### Question 1 ####
# Create a random forest model with the fast_food_train dataset, with 100 trees and
# the number of features per tree being the rounded value of the square root of the # number of predictors.
# What is the OOB estimate of error rate?

# Answer:
mpreds = round(sqrt(ncol(fast_food_train))-1)

ff_rf = randomForest(cals_per_gram ~.,
                      data = fast_food_train,
                      mtry = mpreds,
                      ntree = 100)

print(ff_rf)
# 34.83%

#==============================================-

#### Question 2 ####
# Create a confusionMatrix of predictions and actual values for your model.
# What is the accuracy of your predictions?

# Answer:
frPredict = predict(ff_rf, newdata = fast_food_test)
confusionMatrix(frPredict, fast_food_test$cals_per_gram)
# Here the accuracy is 81.08%.

#==============================================-

#### Question 3 ####
# Calculate the AUC.
# Plot the ROC curve.
# Between the tree and random forest models, which one performed best?

# Answer:
# 0.8918129
# Between the tree and random forest models, the random forest has both a larger AUC value,
# along with a better looking ROC curve, which leads us to conclude the RF model
# is a better model for our data.

rfPredict2 = predict(ff_rf, newdata = fast_food_test, type = "prob")
ff_rocr_pred_rf = rfPredict2[,2]
ff_trees_preds_rf = prediction(ff_rocr_pred_rf,labels = fast_food_test$cals_per_gram)
ff_trees_perf_rf = performance(ff_trees_preds_rf,measure="tpr",x.measure = "fpr")

# AUC
ff_auc.perf_rf = performance(ff_trees_preds_rf,measure="auc")
ff_auc.perf_rf@y.values


# ROC curve
plot(ff_trees_perf_rf,col='red')
abline(a=0,b=1)


#==============================================-

#### Question 4 ####
# Plot the variable importance for your random forest model.
# Which variable has the greatedt mean decrease of the gini index?

# Answer:
varImpPlot(ff_rf)
# Calories has the greatest mean decrease of the gini index.



