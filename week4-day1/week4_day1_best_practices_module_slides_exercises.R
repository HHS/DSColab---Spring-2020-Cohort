#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK4 DAY1 BEST PRACTICES MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####
# Confirm your working directory to where we store data.
# Read in "fast_food_data.csv" and save it to "fast_food_data".
# When reading in the file, only set header = TRUE, no other special options.
# Check the structure of fast_food_data


#================================================-
#### Question 2 ####
# Select all the variables except Revenue, Sodium, Restuarant, & Item.
# There are many ways to subset the dataset in this fashion.
# For this problem, please use a combination of the `select` and `starts_with` functions.
# Name the subsetted dataset, "fast_food_sub"
# Replace all the "." with " ". Remove the . in the column names.

#================================================-
#### Question 3 ####
# Use the method from the class exercise to find the unique data types in fast_food_sub.
# Name the list of data types "var_data_types"

#================================================-
#### Question 4 ####
# In one code line, use the ImputeNAsWithMean function to replace any missing values in the numeric variables in the dataset.
# Use cbind to rejoin the output of `ImputeNAsWithMean`with the Type column from fast_food_sub to create a new dataset.
# Name the new dataset "fast_food_imp"
# Hint 1: Nest the actual function within the `cbind`
# Hint 2: Remeber to rename fast_food_sub$Type when you bind it.
# Hint: use column indexing to only feed the numeric columns into the function. 

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


#================================================-
#### Question 5 ####
# Check for variables with near zero variance within fast_food_imp. 
# save the output of the function to nzv_check.
# Are there any variables with near zero variance?



#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Set the seed.
set.seed(2)

# Create a data partition index with a 70% split and name it "ff_train_index"
# We will use this to split the actual fast_food_imp dataset.

#================================================-
#### Question 2 ####
# Subset fast_food_imp to include only ff_train_index observations.
# Name the training dataset "fast_food_train".
# Then check the number of rows should be in fast_food_train, based on the number of rows in fast_food_imp.
# How does it compare to the actual number of rows in fast_food_train?


#================================================-
#### Question 3 ####
# Continue to subset fast_food_imp to create the test set.
# How many rows does fast_food_test have compared to what is 30% of the observations of fast_food_imp?



#### Exercise 3 ####
# =================================================-


#### Question 1 ####
# Create a linear model named ff_model, using fast_food_train, and all of the variables to predict Calories.
# Check the summary of ff_model.
# How many of the coefficients in ff_model are statistically significant?
# Yet, how does the model perform compared to the null hypothesis? 
# How much diference is there between multiple R-squared and the Adjusted R-squared?

#================================================-
#### Question 2 ####
# Check to see if ff_model meets the assumptions of LINE.
# Does it meet the assumptions?


#================================================-
#### Question 3 ####
# Save the output of running `cooks.distance` on ff_model to ff_cooksd.
# Check the head of ff_cooksd.
# What does plotting the fourth plot of the assumptions suggest about influential points in the model?

#================================================-
#### Question 4 ####
# Replicate the code from the in-class exercises to identify the row numbers with influential observations.
# Name the list of row numbers "influential_ff"
# How many observations are influential to the model in fast_food_train?

#================================================-
#### Question 5 ####
# Remove the observations in influential_ff from fast_food_train.
# Name the adjusted dataset ff_train_cooks


#================================================-
#### Question 6 ####
# Re-run the model on the adjusted dataset ff_train_cooks.
# Name the new model ff_model_cooks.
# How does the adjusted r-squared change between ff_model and ff_model_cooks?


#================================================-
#### Question 7 ####
# Check the plots of the residuals to see if ff_model_cooks to see if it meets the necessary assumptions.


#### Question 8 ####
# To check for aliased coefficients use `alias` on ff_model_cooks and save the output to aliased_ff.


#================================================-
#### Question 9 ####
# Save the output of aliased_ff$Complete to aliased_complete_ff to the variable aliased_complete_ff
# Check the row names of aliased_complete_ff to see how many variables are perfectly correlated.


#================================================-
#### Question 10 ####
ff_vif = vif(ff_model_cooks)
ff_vif_val=ff_vif[,1[1]]
vif_scores=data.frame(var_names=names(ff_vif_val),values=unname(ff_vif_val))
# Run the above code to create a dataframe of variable names and their associated VIF score.
# Filter vif_scored to only include variables with VIF scores greater than 10.
# Then arrange the VIF values in ascending value.
# How many variables have a VIF score greater than 10?
# Which variable has the highest VIF score?


#### Exercise 4 ####
# =================================================-

#### Question 1 ####
# Use the ff_model_cooks to predict the Calorie values in the fast_food_test dataset.
# Save the output to the variable pred_ff_val
# Hint: Remember to not include the calories column in fast_food_test, when you use `predict`


#================================================-
#### Question 2 ####
# Use `data.frame` to combine pred_ff_val, the actual Calorie values from fast_food_test, and the calculated residuals
# into a new dataset ff_lm_results.
# Check the head of ff_lm_results once the dataset is created.
# Hint: refer to the code from the in-class exercise for guidance.


#================================================-
#### Question 3 ####
# Calculate the residual sum of sqaures for the predicted data and save it to ff_pred_RSS
# Then use it to calculate the mean sum of squared of the predicted values and save it to ff_pred_MSE.
# Then use it to calculate the root mean squared error and save it to ff_pred_RMSE_lin_reg.
# What is the RMSE of the predicted data?


#================================================-
#### Question 4 ####
# What is the RMSE of the predicted values in percent values in respect to Calories' range?


