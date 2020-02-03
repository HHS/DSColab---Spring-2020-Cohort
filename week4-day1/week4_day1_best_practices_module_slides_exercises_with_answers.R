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
# Answer:

# Set working directory:
setwd(data_dir)

# Read CSV file called "fast_food_data"
fast_food_data = read.csv("fast_food_data.csv",
                          header = TRUE)

# Subset fast_food_data
str(fast_food_data)

#================================================-
#### Question 2 ####
# Select all the variables except Revenue, Sodium, Restuarant, & Item.
# There are many ways to subset the dataset in this fashion.
# For this problem, please use a combination of the `select` and `starts_with` functions.
# Name the subsetted dataset, "fast_food_sub"
# Replace all the "." with " ". Remove the . in the column names.
# Answer:

fast_food_sub = fast_food_data %>%
  select(-starts_with("Rev"), -starts_with("So"), -starts_with("Fa"), -Item)
names(fast_food_sub) = sapply(names(fast_food_sub), function(x) str_replace_all(x, "[.]", ""))

#================================================-
#### Question 3 ####
# Use the method from the class exercise to find the unique data types in fast_food_sub.
# Name the list of data types "var_data_types"
# Answer:

# Types of variables in fast_food_sub
var_data_types = sapply(fast_food_sub, class)

# Check for unique types.
unique(var_data_types)

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

# Answer:
ImputeNAsWithMean(fast_food_sub[,2:9])

# Nest the output of ImputeNAsWithMean
fast_food_imp = cbind("Type" = fast_food_sub$Type, ImputeNAsWithMean(fast_food_sub[,2:9]))

#================================================-
#### Question 5 ####
# Check for variables with near zero variance within fast_food_imp. 
# save the output of the function to nzv_check.
# Are there any variables with near zero variance?
# Answer: No.

# Use `nearZeroVar`
nzv_check = nearZeroVar(fast_food_imp)
nzv_check


#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Set the seed.
set.seed(2)

# Create a data partition index with a 70% split and name it "ff_train_index"
# We will use this to split the actual fast_food_imp dataset.
# Answer:

ff_train_index = createDataPartition(fast_food_imp$Calories,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)            #<- 70% training, 30% test

#================================================-
#### Question 2 ####
# Subset fast_food_imp to include only ff_train_index observations.
# Name the training dataset "fast_food_train".
# Then check the number of rows should be in fast_food_train, based on the number of rows in fast_food_imp.
# How does it compare to the actual number of rows in fast_food_train?
# Answer: 
# Test has about 2 observations more.

# Subset fast_food_imp
fast_food_train = fast_food_imp[ff_train_index, ]
  
# Check number of rows for 70% of `fast_food_imp` data.
0.7 * nrow(fast_food_imp)

# Check number of rows of training set.
nrow(fast_food_train)

#================================================-
#### Question 3 ####
# Continue to subset fast_food_imp to create the test set.
# How many rows does fast_food_test have compared to what is 30% of the observations of fast_food_imp?
# Answer:
# Test set has 36 observations. 30% of fast_food_imp observations is 37.8

# Subset the data to include only test set observations.
fast_food_test = fast_food_imp[ -ff_train_index, ]

# Check number of rows for 30% of `fast_food_imp` data.
0.3 * nrow(fast_food_imp)

# Check number of rows of test set.
nrow(fast_food_test)



#### Exercise 3 ####
# =================================================-


#### Question 1 ####
# Create a linear model named ff_model, using fast_food_train, and all of the variables to predict Calories.
# Check the summary of ff_model.
# How many of the coefficients in ff_model are statistically significant?
# Yet, how does the model perform compared to the null hypothesis? 
# How much diference is there between multiple R-squared and the Adjusted R-squared?
# Answer: 
# Five coefficients have p-values less than 0.05. 
# Yet the p-value on the F statistic is much less than 0.05.
# There is a .0013 difference between the R squared and the adjusted R squared.

# Create model.
ff_model = lm(Calories ~ ., data = fast_food_train)

# Check summary of the model.
summary(ff_model)

#================================================-
#### Question 2 ####
# Check to see if ff_model meets the assumptions of LINE.
# Does it meet the assumptions?
# Answer:
# Yes.
par(mfrow = c(2, 2))
plot(ff_model)

# Plot the first plot of linear model:
# Residuals vs. Fitted.
plot(ff_model, which = c(1))

# Plot the second plot of linear model:
# Normal QQ plot.
plot(ff_model, which = c(2))

# Plot the third plot of linear model:
# Scale location.
plot(ff_model, which = c(3))

# Plot the 5th plot of linear model:
# Residuals vs. leverage.
plot(ff_model, which = c(5))

#================================================-
#### Question 3 ####
# Save the output of running `cooks.distance` on ff_model to ff_cooksd.
# Check the head of ff_cooksd.
# What does plotting the fourth plot of the assumptions suggest about influential points in the model?
# Answer:
# The plot suggests that there are some influential points in the training dataset. 

# Run cooks.distance
ff_cooksd = cooks.distance(ff_model)
head(ff_cooksd)

plot(ff_model, which = c(4))

#================================================-
#### Question 4 ####
# Replicate the code from the in-class exercises to identify the row numbers with influential observations.
# Name the list of row numbers "influential_ff"
# How many observations are influential to the model in fast_food_train?
# Answer:
# Eight observations are influential to the model.

# Influential row numbers.
influential_ff = as.numeric(names(ff_cooksd)[(ff_cooksd > 4 * mean(ff_cooksd, na.rm = T))]) 
length(influential_ff)

#================================================-
#### Question 5 ####
# Remove the observations in influential_ff from fast_food_train.
# Name the adjusted dataset ff_train_cooks
# Answer:

# We label our new training dataset and remove the influential points
ff_train_cooks = fast_food_train[-influential_ff, ]

#================================================-
#### Question 6 ####
# Re-run the model on the adjusted dataset ff_train_cooks.
# Name the new model ff_model_cooks.
# How does the adjusted r-squared change between ff_model and ff_model_cooks?
# Answer: 
# Adjusted R squared decreases by less than 0.01

# And then re-run the regression.
ff_model_cooks = lm(Calories ~ ., data = ff_train_cooks)

data.frame(original = summary(ff_model)$adj.r.squared,
           cooks_d = summary(ff_model_cooks)$adj.r.squared)

#================================================-
#### Question 7 ####
# Check the plots of the residuals to see if ff_model_cooks to see if it meets the necessary assumptions.
# Answer:
# It appears that it meets the assumptions.

# Plot residuals.
par(mfrow = c(2,2))
plot(ff_model_cooks)


#### Question 8 ####
# To check for aliased coefficients use `alias` on ff_model_cooks and save the output to aliased_ff.
#Answer:

# Identify aliased variables in the model.
aliased_ff = alias(ff_model_cooks)

#================================================-
#### Question 9 ####
# Save the output of aliased_ff$Complete to aliased_complete_ff to the variable aliased_complete_ff
# Check the row names of aliased_complete_ff to see how many variables are perfectly correlated.
# Answer:
# rownames on aliased_complete_ff returns NULL, which means there are no perfectly correlated variables in the dataset.

# Extract `Complete` matrix of results.
aliased_complete_ff = aliased_ff$Complete
rownames(aliased_complete_ff)

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
# Answer:
# 6 variables have high VIF scores.
# Type has the highest VIF score.

# Let's order the VIF scores and # take a look at the ones above 10.
vif_scores = vif_scores %>%
  filter(values >= 10) %>%
  arrange(values)

# How many variables are there 
# with a vif over 10?
nrow(vif_scores)
vif_scores



#### Exercise 4 ####
# =================================================-

#### Question 1 ####
# Use the ff_model_cooks to predict the Calorie values in the fast_food_test dataset.
# Save the output to the variable pred_ff_val
# Hint: Remember to not include the calories column in fast_food_test, when you use `predict`
#Answer:

# Predict values of `Calories` using the test data.
pred_ff_val = predict(ff_model_cooks,          #<- linear model object
                           newdata = fast_food_test[ , -3])  #<- test data without response variable
pred_ff_val

#================================================-
#### Question 2 ####
# Use `data.frame` to combine pred_ff_val, the actual Calorie values from fast_food_test, and the calculated residuals
# into a new dataset ff_lm_results.
# Check the head of ff_lm_results once the dataset is created.
# Hint: refer to the code from the in-class exercise for guidance.
# Answer:

# Compute residuals and save them into a data frame.
ff_lm_results = data.frame(predicted = pred_ff_val,        #<- values predicted by model
                            actual = fast_food_test[ , 3],         #<- actual values from data
                            residuals = fast_food_test[ , 3] - pred_ff_val) #<- residuals

# Check output
head(ff_lm_results)

#================================================-
#### Question 3 ####
# Calculate the residual sum of sqaures for the predicted data and save it to ff_pred_RSS
# Then use it to calculate the mean sum of squared of the predicted values and save it to ff_pred_MSE.
# Then use it to calculate the root mean squared error and save it to ff_pred_RMSE_lin_reg.
# What is the RMSE of the predicted data?
# Answer:
# ~ 25.1

# Residual sum of squares for predicted data.
ff_pred_RSS = sum(ff_lm_results$residuals^2)
ff_pred_RSS

# Mean squared error from predicted values.
ff_pred_MSE = ff_pred_RSS / length(ff_lm_results$residuals)
ff_pred_MSE


ff_pred_RMSE_lin_reg = sqrt(ff_pred_MSE)
ff_pred_RMSE_lin_reg

#================================================-
#### Question 4 ####
# What is the RMSE of the predicted values in percent values in respect to Calories' range?
# Answer:
# 2.509

# Let's get the range of yield values.
Calories_range = max(fast_food_test$Calories) - 
  min(fast_food_test$Calories)
Calories_range

# RMSE in percent values with 
# respect to Calories's range.
ff_pred_RMSE_lin_reg_precent = 
  (ff_pred_RMSE_lin_reg/Calories_range)*100

ff_pred_RMSE_lin_reg_precent



