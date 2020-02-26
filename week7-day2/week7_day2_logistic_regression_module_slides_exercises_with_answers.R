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
View(pizza_rating)

# ===========================================-
### Question 2 ####
# Run a logistic regression on the sample data with Rating as the predictor and Buy as the target.
# Display the attributes and the summary of the model.

# Answer:
glm_res = glm(Buy ~ Rating,      #<- formula
              data = pizza_rating, #<- data 
              family = "binomial")#<- family of functions

attributes(glm_res)
summary(glm_res)

# ===========================================-
#### Question 3 ####
# Display the coefficients, Null Deviance, Residual Deviance and AIC for the model.

# Answer:
glm_res$coefficients
glm_res$null.deviance
glm_res$deviance
glm_res$aic


#### Exercise 2 ####
# =================================================-

#### Question 1 ####
# Read the fast_food_data csv file as fastfood.

# Answer: 

fastfood = read.csv("fast_food_data.csv")

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

fastfood = fastfood %>%
  mutate(cals_per_gram = ifelse((Calories/Serving.Size..g.)>2.5, "High","Low")) %>%
  mutate(cals_per_gram = as.factor(cals_per_gram)) %>%
  rename(fat = Total.Fat..g., sodium = Sodium..mg., 
         carbs = Carbs..g., sugar = Sugars..g., protein = Protein..g.) %>%
  dplyr::select(fat, sodium, carbs, sugar, protein, cals_per_gram) #<- this ensures we use the select function from the dplyr package

#============================================-
#### Question 3 ####
# Set your seed to set.seed(2)
# Create a train and test set for the fastfood dataset, in which the training set 
# contains 70% of the observations.
# Using the glm() function, create a logistic regression model with the training data, predicting the classification of cals_per_gram by all other variables.
# Calculate the difference between the null deviance and residual deviance. 
# Is there improvement by adding the predictors?

# Answer:

set.seed(2)
train_index = createDataPartition(fastfood$cals_per_gram,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)            #<- 70% training, 30% test

# Subset the data to include only train set observations.
fastfood_train = fastfood[train_index, ]

# Subset the data to include only test set observations.
fastfood_test = fastfood[-train_index, ]

# Create the logistic regression model using glm
fastfood_logit = glm(cals_per_gram ~ ., family = "binomial", data = fastfood_train)
summary(fastfood_logit)

# Calculate the difference between null and residual deviance
fastfood_logit$null.deviance - fastfood_logit$deviance
# The difference is 27.24714, thus there is improvement by considering 
# our predictors in the model.

#============================================-
#### Question 4 ####
# Create a plot of the ROC curve.
# Calculate the area under the curve. 
# Finally, create a confusion matrix with a 0.5 cutoff.
# How accurate were our predictions?

# Answer:

# Build a ROC curve.
fastfood_pred = prediction(fastfood_logit$fitted.values, fastfood_train$cals_per_gram)
# Build performance object for plotting TPR vs FPR.
ROCR_ff = performance(fastfood_pred, 'tpr','fpr')
plot(ROCR_ff, col = 'darkblue',lwd = 3)
abline(a = 0, b = 1, col = "red",lwd = 3,lty = 2)

# Calculate the AUC
AUC_ff = performance(fastfood_pred,
                       measure = "auc")
AUC_ff@y.values[[1]]
# The area under the curve is 0.7881699, which is close to 1. Our model performed well.

# Finally, create the confusion matrix
fastfood_train$pred_class = factor(ifelse(fastfood_logit$fitted.values > 0.5, "Low", "High"))
ff_conf_matrix = confusionMatrix(fastfood_train$pred_class, fastfood_train$cals_per_gram)
ff_conf_matrix
# Our accuracy here is 0.7191, which means our model performed pretty well.

#============================================-
#### Question 5 ####
# Plot the accuracy of our model for various cutoff points using the performance function.
# Using this information, calculate the optimal cutoff point.
# What is the best accuracy we can achieve, and at what cutoff point?

# Answer:

# Plot the accuracy for various cutoff points.
ff_acc = performance(fastfood_pred, measure = "acc")
plot(ff_acc)

# Calculate the optimal cutoff point.
max_ind = which.max(slot(ff_acc, "y.values")[[1]])
best_accuracy = slot(ff_acc, "y.values")[[1]][max_ind]
best_cutoff = slot(ff_acc, "x.values")[[1]][max_ind]
print(c(accuracy= best_accuracy, cutoff = best_cutoff))
# We realize an accuracy of 0.7640449 with a cutoff of 0.3769361.


#### Exercise 3 ####
# =================================================-

#### Question 1 ####
# Create prediction probabilities of cals_per_gram on the test data set.
# Append these probabilities to the fastfood_test dataframe as 'pred_probs'.
# Convert these probabilities into a class "Low" or "High" using the optimal
# cutoff calculated in Exercise 2, append to the fastfood_test dataframe as 'preds_class' and display the final fastfood_test dataframe.

# Answer:

# Predict cals_per_gram using the logistic regression model.
fastfood_test$pred_probs = predict(fastfood_logit, 
                                   newdata = fastfood_test[, -6], 
                                   type = "response")

# Convert probabilities into class
fastfood_test$preds_class = factor(ifelse(fastfood_test$pred_prob > 0.3769361 , "Low", "High")) 

head(fastfood_test)

# ============================================-
#### Question 2 ####
# Create a confusion matrix of our predicted and actual values of the test data.
# How accurate was our model?

# Answer:

conf_matrix = confusionMatrix(fastfood_test$preds_class, fastfood_test$cals_per_gram)
conf_matrix
# Our model achieves an accuracy of 0.7568!

# ============================================-
#### Question 3 ####
# Plot the ROC curve and calculate the AUC.

# Answer:

# First build a ROC curve
# Get prediction probabilities using `prediction` from ROCR package.
ROCR_preds = prediction(fastfood_test$pred_probs, fastfood_test$cals_per_gram)
# Build performance object for plotting TPR vs FPR.
ROCR_performance = performance(ROCR_preds, 'tpr','fpr')
# Build ROC curve with random guess reference line.
plot(ROCR_performance,  col = 'darkblue', lwd = 3)
abline(a = 0, b = 1,col = "red",lwd = 3,lty = 2)

# Now calculate the AUC
ROCR_auc = performance(ROCR_preds,
                       measure = "auc")
ROCR_auc@y.values[[1]]
# AUC is 0.9298246, meaning we have a really good model.


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

fastfood2 = read.csv("fast_food_data.csv")

fastfood2 = fastfood2 %>%
  mutate(cals_per_gram = ifelse((Calories/Serving.Size..g.)>2.5, "High","Low")) %>%
  mutate(cals_per_gram = as.factor(cals_per_gram))

# Create the logistic regression model using glm
fastfood2_logit = glm(cals_per_gram ~ ., family = "binomial", data = fastfood2)
summary(fastfood2_logit)

# Some of our variables are filled with NA values, while all p values are 1.
# We have fed in "junk" data to our logisitc regression and are resulted with
# a "junk" model.


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

ff_reduced_pca = read.csv("ff_reduced_pca.csv")

# Set the seed.
set.seed(2)

# Split ff dataset into train and test data.
train_index = createDataPartition(ff_reduced_pca$cals_per_gram,  #<- outcome variable
                                  list = FALSE,     #<- avoid returning the data as a list
                                  times = 1,        #<- split 1 time 
                                  p = 0.7)  

# Subset the data to include only train set observations.
ff_pca_train = ff_reduced_pca[train_index, ]

# Subset the data to include only test set observations.
ff_pca_test =ff_reduced_pca[-train_index, ]

# Create the logistic regression
ff_pca_logit = glm(cals_per_gram ~ .,
                    family = "binomial",
                    data = ff_pca_train)
summary(ff_pca_logit)

# ==========================================-
#### Question 3 ####
# Calculate the prediction probabilities of the test dataset, appending this to 
# the test dataset as a variable named 'pred_probs'
# Then, classify these predictions, again appending to the test dataset as 
# "preds_class". Use the optimal cutoff point calculated in Exercise 2.

# Answer:

# First, the prediction probabilities.
ff_pca_test$pred_probs = predict(ff_pca_logit, 
                                 newdata = ff_pca_test[, -6], 
                                 type = "response")

# Next, the predicted class using the cutoff from Exercise 2.
ff_pca_test$preds_class = factor(ifelse(ff_pca_test$pred_probs > 0.3769361, "Low", "High"))

# ==========================================-
#### Question 4 ####
# Finally, calculate the accuracy of your predictions using a confusion matrix.
# How did the PCA results compare to the raw dataset in this instance?
# Why did we experience this difference? Elaborate.

# Answer:

conf_matrix_pca = confusionMatrix(ff_pca_test$preds_class,ff_pca_test$cals_per_gram)
conf_matrix_pca
# Here, we only achieve an accuracy of 57%, compared to the raw datasets accuracy
# of almost 75%. In this instance with this dataframe, it was not completely neccessary to utilize PCA, as we did not have a great dimensionality in our data
# to begin with, and were not as concerned with already correlated variables.
# This being said, it is often a good idea to apply PCA to data to ensure
# to account for such characteristics in our data.


