#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK7 DAY2 LOGISTIC REGRESSION MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####
# Create a dataframe for pizza rating with the following data and view the dataframe.
pizza_rating = data.frame(Rating = c(2.5,1,4.5,2,4.7,3.9,2.2,4.9), Buy = c(0,0,1,0,1,1,0,1))

# Answer:

# ===========================================-
### Question 2 ####
# Run a logistic regression on the sample data with Rating as the predictor and Buy as the target.
# Display the attributes and the summary of the model.

# Answer:



# ===========================================-
#### Question 3 ####
# Display the coefficients, Null Deviance, Residual Deviance and AIC for the model.

# Answer:




#### Exercise 2 ####
# =================================================-

#### Question 1 ####
# Read the fast_food_data csv file as fastfood.

# Answer: 



#============================================-
#### Question 2 ####
# We will create a categorical variable named cals_per_gram. Complete the following:
# Install and load dplyr package
# Create a new variable cals_per_gram that is "High" if the ratio of 'Calories' to 
# 'Serving.Size..g.' is greater than 2.5, and "Low" otherwise.
# Convert this variable to a factor.
# Rename Total.Fat..g., Sodium..mg., Carbs..g., Sugars..g., and Protein..g. to
# fat, sodium, carbs, sugar, and protein, respectively.
# Select only these renamed columns and the cals_per_gram variable.

# Answer: 


#============================================-
#### Question 3 ####
# Set your seed to set.seed(2)
# Create a train and test set for the fastfood dataset, in which the training set 
# contains 70% of the observations.
# Using the glm() function, create a logistic regression model with the training data, predicting the classification of cals_per_gram by all other variables.
# Calculate the difference between the null deviance and residual deviance. 
# Is there improvement by adding the predictors?

# Answer:




#============================================-
#### Question 4 ####
# Create a plot of the ROC curve.
# Calculate the area under the curve. 
# Finally, create a confusion matrix with a 0.5 cutoff.
# How accurate were our predictions?

# Answer:



#============================================-
#### Question 5 ####
# Plot the accuracy of our model for various cutoff points using the performance function.
# Using this information, calculate the optimal cutoff point.
# What is the best accuracy we can achieve, and at what cutoff point?

# Answer:




#### Exercise 3 ####
# =================================================-

#### Question 1 ####
# Create prediction probabilities of cals_per_gram on the test data set.
# Append these probabilities to the fastfood_test dataframe as 'pred_probs'.
# Convert these probabilities into a class "Low" or "High" using the optimal
# cutoff calculated in Exercise 2, append to the fastfood_test dataframe as 'preds_class' and display the final fastfood_test dataframe.

# Answer:



# ============================================-
#### Question 2 ####
# Create a confusion matrix of our predicted and actual values of the test data.
# How accurate was our model?

# Answer:



# ============================================-
#### Question 3 ####
# Plot the ROC curve and calculate the AUC.

# Answer:




#### Exercise 4 ####
# =================================================-

#### Question 1 ####
# Read in the 'fast_food_data.csv' from the data directory as fastfood2.
# Similar to before, create a new variable, 'cals_per_gram', which 
# is type factor, and is "High" if the value of Calories/Serving.Size..g.
# is greater than 2.5 and otherwise is "Low".
# Do NOT split into a train and test set.
# Now, create a logistic regression with fastfood2. Does it converge?
# Analyze the results using the summary function.

# Answer:




# ==========================================-
#### Question 2 ####
# Read in the "ff_reduced_pca.csv" as ff_reduced_pca. This file contains the five 
# principle components from our fastfood dataset. We will analyze whether they provide a good prediction or not.
# Set your seed to set.seed(2)
# Split the dataframe into a training and test set, with 
# the training set containing 70% of the data
# Name them ff_pca_train and ff_pca_test, respectively.
# Create a logistic regression model predicting cals_per_gram 
# with the five principal components.

# Answer:



# ==========================================-
#### Question 3 ####
# Calculate the prediction probabilities of the test dataset, appending this to 
# the test dataset as a variable named 'pred_probs'
# Then, classify these predictions, again appending to the test dataset as 
# "preds_class". Use the optimal cutoff point calculated in Exercise 2.

# Answer:



# ==========================================-
#### Question 4 ####
# Finally, calculate the accuracy of your predictions using a confusion matrix.
# How did the PCA results compare to the raw dataset in this instance?
# Why did we experience this difference? Elaborate.

# Answer:

