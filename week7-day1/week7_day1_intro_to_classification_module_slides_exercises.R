#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK7 DAY1 INTRO TO CLASSIFICATION MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-


#### Question 1 ####
# Read in the fast_food_data csv file as fastfood.

# Answer: 



#================================================-

#### Question 2 ####
# We will create a categorical variable named cals_per_gram. Complete the following:
# Create a new variable cals_per_gram that is "High" if the ratio of 'Calories' to 
# 'Serving.Size..g.' is greater than 2.5, and "Low" otherwise.
# Convert this variable to a factor.
# Rename Total.Fat..g., Sodium..mg., Carbs..g., Sugars..g., and Protein..g. to
# fat, sodium, carbs, sugar, and protein, respectively.
# Select only these renamed columns and the cals_per_gram variable.

# Answer: 



#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Examine the distribution of cals_per_gram using the prop.table() function. 
# Does it appear to be evenly distributed between "High" and "Low"?

# Answer: 



#================================================-

#### Question 2 ####
# Determine the ratio of NA terms to non-NA terms.

# Answer: 



#================================================-

#### Question 3 ####
# Change the levels of our target variable to be the variable names for prediction.

# Answer: 



#================================================-

#### Question 4 ####
# Create a training data set that contains 70% of the observations, 
# and a test dataset that contains 30% of the observations.
# Name these datasets fastfood_train and fastfood_test, respectively.

# Answer: 



#================================================-

#### Question 5 ####
# Finally, train the model on the training data using all the variables and cals_per_gram
# as the outcome. 
# Do not specify any cross validation methods.
# Use the knn method. What value of k was used for the model?
# Create a vector of predictions called test_predictions that utilizes the predict() function.

# Answer: 



#### Exercise 3 ####
# =================================================-


#### Question 1 ####
# Create a confusion matrix for our predictions and test data.
# How accurate were our predictions of cals_per_gram?
# How do we define sensitivty and what is the rate in this case?
# How do we define specificity and what is the rate in this case?

# Answer: 



#### Exercise 4 ####
# =================================================-

#================================================-
#### Question 1 ####
# Create a train control called ex_ctrl with 3 repeats.
# Run the knn model using this control on the training_data.
# View the results.

# Answer



#===============================================-
#### Question 2 ####
# Predict the values using this new model.
# Get the confusion matrix and check the accuracy.

# Answer


#===============================================-

#### Question 3 ####
# Read in the fast_food dataset again as fast_food_new. Print the colnames of fast_food_new.
# Keep the 3,4,5,6,9,10,11,12 columns and rename the column name as Type, Serving_size, Calories, Total_fat, Sodium, Carbs, Sugars, Protein.
# Take the type variable - keep it as 'yes' if the type is either "Breaded.Chicken.Sandwich"/ "Grilled.Chicken.Sandwich"/ "Chicken.Nuggets" and 'no' otherwise. Convert the type to factors.

# Answer:


#===============================================-
#### Question 4 ####
# Set seed as 3 and create data parition of 70% training and 30% testing data.
# Name the levels of the target variable Type.

# Answer



#===============================================-
#### Question 5 ####
# Train a model using cv with 3 repeats. Predict the values and derive the confusion matrix.

# Answer


#===============================================-


