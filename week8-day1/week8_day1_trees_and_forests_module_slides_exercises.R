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



#==============================================-

#### Question 2 ####
# There is a total of 10 squares, find the Gini impurity for the following cases:
# 1) There are 7 Red and 3 Blue squares
# 2) There are 5 Red and 5 Blue squares
# 3) All 10 are Blue squares

# Answer:


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




#### Exercise 2 ####
# =================================================-

#### Question 1 ####
# Select only the total_fat, sugars, carbs, sodium, proteins, and cals_per_gram   variables in the fast_food dataframe.
# Fit the tree by taking cals_per_gram as the target variable and total_fat, 
# sugars, carbs, sodium and proteins as the independent variables by setting seed to 1.
# Print the complexity table.
# Examine the tree by plotting it and adding text, and printing it as well.

# Answer:



#==============================================-

#### Question 2 ####
# Find the best complexity parameter. 
# Prune the tree with 0.03 as cp.
# Compare the pruned tree to the previous tree.

# Answer:




#### Exercise 3 ####
# =================================================-

#### Question 1 ####
# Create a training set on the fast_food data set which contains 70 percent of the observations.
# Create a test set with the remaining observations.
# Name the two datasets as fast_food_train and fast_food_test respectively.

# Answer:


#==============================================-

#### Question 2 ####
# Name the levels of the target variable cals_per_gram in both the training and test sets as shown in the module.

# Answer:




#==============================================-

#### Question 3 ####
# Create a tree model that predicts cals_per_gram with all other variables in the 
# fast_food_train dataframe.
# Set the trControl parameter to use method="repeatedcv" with repeats = 3. 
# Set all other parameters the same way we did in the module.
# Print the tree. Where did we realize the greatest accuracy?

# Answer:


#==============================================-

#### Question 4 ####
# Create a prediction on the test set using the fast_food_tree model. 
# Do not specify the type parameter.
# Calculate the accuracy using the confusionMatrix function.

# Answer:




#==============================================-

#### Question 5 ####
# Create a prediction on the test set using the fast_food_tree model, this time
# specifying type="prob".
# Calculate the AUC and lot the ROC curve.

# Answer:




#### Exercise 4 ####
# =================================================-

#### Question 1 ####
# Create a random forest model with the fast_food_train dataset, with 100 trees and
# the number of features per tree being the rounded value of the square root of the # number of predictors.
# What is the OOB estimate of error rate?

# Answer:




#==============================================-

#### Question 2 ####
# Create a confusionMatrix of predictions and actual values for your model.
# What is the accuracy of your predictions?

# Answer:



#==============================================-

#### Question 3 ####
# Calculate the AUC.
# Plot the ROC curve.
# Between the tree and random forest models, which one performed best?

# Answer:





#==============================================-

#### Question 4 ####
# Plot the variable importance for your random forest model.
# Which variable has the greatedt mean decrease of the gini index?

# Answer:



