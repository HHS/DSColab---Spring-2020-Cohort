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

fastfood = read.csv("fast_food_data.csv")

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

fastfood = fastfood %>%
  mutate(cals_per_gram = ifelse((Calories/Serving.Size..g.)>2.5, "High","Low")) %>%
  mutate(cals_per_gram = as.factor(cals_per_gram)) %>%
  rename(fat = Total.Fat..g., sodium = Sodium..mg., 
         carbs = Carbs..g., sugar = Sugars..g., protein = Protein..g.) %>%
  dplyr::select(fat, sodium, carbs, sugar, protein, cals_per_gram) #<- this ensure we use the select function from the dplyr package



#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Examine the distribution of cals_per_gram using the prop.table() function. 
# Does it appear to be evenly distributed between "High" and "Low"?

# Answer: 

prop.table(table(fastfood$cals_per_gram))
# We have almost an even split - so yes it is just about evenly distributed between High and Low.

#================================================-

#### Question 2 ####
# Determine the ratio of NA terms to non-NA terms.

# Answer: 

sum(is.na(fastfood)) / sum(!is.na(fastfood))
# Our ratio is 0.

#================================================-

#### Question 3 ####
# Change the levels of our target variable to be the variable names for prediction.

# Answer: 

levels(fastfood$cals_per_gram) =
  make.names(levels(factor(fastfood$cals_per_gram)))

#================================================-

#### Question 4 ####
# Create a training data set that contains 70% of the observations, 
# and a test dataset that contains 30% of the observations.
# Name these datasets fastfood_train and fastfood_test, respectively.

# Answer: 
train_indices = createDataPartition(fastfood$cals_per_gram,
                                  list = FALSE,
                                  times = 1,          
                                  p = 0.7)

fastfood_train = fastfood[train_indices, ]
fastfood_test = fastfood[-train_indices, ]

#================================================-

#### Question 5 ####
# Finally, train the model on the training data using all the variables and cals_per_gram
# as the outcome. 
# Do not specify any cross validation methods.
# Use the knn method. What value of k was used for the model?
# Create a vector of predictions called test_predictions that utilizes the predict() function.

# Answer: 
fastfood_model = train(cals_per_gram ~., 
                 data = fastfood_train, 
                 method = "knn")

fastfood_model
# k = 9 was used for our value of k.

test_predictions = predict(fastfood_model, fastfood_test)


#### Exercise 3 ####
# =================================================-


#### Question 1 ####
# Create a confusion matrix for our predictions and test data.
# How accurate were our predictions of cals_per_gram?
# How do we define sensitivty and what is the rate in this case?
# How do we define specificity and what is the rate in this case?

# Answer: 

confusionMatrix(test_predictions, 
                fastfood_test$cals_per_gram)

# We made predictions with 54% accuracy.
# Sensitivity is defined as the true positive rate - the proportion of positive predictions we correctly identified. Here it is 0.6111.
# Specificity is defined as the true negative rate - the proportion of negative predictions we correctly identified. Here it is 0.4737.



#### Exercise 4 ####
# =================================================-

#================================================-
#### Question 1 ####
# Create a train control called ex_ctrl with 3 repeats.
# Run the knn model using this control on the training_data.
# View the results.

# Answer
ex_ctrl = trainControl(method = "repeatedcv", repeats = 3, classProbs = TRUE)
knn_fit_cv = train(cals_per_gram ~., 
                   data = fastfood_train, 
                   method = "knn", 
                   trControl = ex_ctrl,
                   tuneLength = 20)
knn_fit_cv

#===============================================-
#### Question 2 ####
# Predict the values using this new model.
# Get the confusion matrix and check the accuracy.

# Answer
test_pred_cv = predict(knn_fit_cv,newdata = fastfood_test )
confusionMatrix(test_predictions, 
                fastfood_test$cals_per_gram )
#===============================================-

#### Question 3 ####
# Read in the fast_food dataset again as fast_food_new. Print the colnames of fast_food_new.
# Keep the 3,4,5,6,9,10,11,12 columns and rename the column name as Type, Serving_size, Calories, Total_fat, Sodium, Carbs, Sugars, Protein.
# Take the type variable - keep it as 'yes' if the type is either "Breaded.Chicken.Sandwich"/ "Grilled.Chicken.Sandwich"/ "Chicken.Nuggets" and 'no' otherwise. Convert the type to factors.

fast_food_new = read.csv("fast_food_data.csv")
colnames(fast_food_new)
fast_food_new = fast_food_new[,c(3,4,5,6,9,10,11,12)]
colnames(fast_food_new) = c("Type", "Serving_size", "Calories", "Total_fat", "Sodium", "Carbs", "Sugars", "Protein")
 fast_food_new$Type = ifelse(grepl("Chicken", fast_food_new$Type), 'yes', 'no')
 fast_food_new$Type = as.factor(fast_food_new$Type)

#===============================================-
#### Question 4 ####
# Set seed as 3 and create data parition of 70% training and 30% testing data.
# Name the levels of the target variable Type.

# Answer
set.seed(3)

# We will use this to split the actual CMP dataset.
train_index = createDataPartition(fast_food_new$Type,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)  

# Subset the data to include only train set observations.
fast_food_train = fast_food_new[train_index, ]

# Subset the data to include only test set observations.
fast_food_test = fast_food_new[-train_index, ]

levels(fast_food_train$Type) =
  make.names(levels(factor(fast_food_train$Type)))

levels(fast_food_test$Type) =
  make.names(levels(factor(fast_food_test$Type)))

#===============================================-
#### Question 5 ####
# Train a model using cv with 3 repeats. Predict the values and derive the confusion matrix.

# Answer
ex_ctrl = trainControl(method="repeatedcv",
                        repeats = 3,
                        classProbs = TRUE,
                        summaryFunction = twoClassSummary)

ex_knn = train(Type ~ ., data = fast_food_train, 
                method = "knn", 
                trControl = ex_ctrl,  
                tuneLength = 20)

knnPredict = predict(ex_knn,newdata = fast_food_test )
confusionMatrix(knnPredict, fast_food_test$Type )
#===============================================-


