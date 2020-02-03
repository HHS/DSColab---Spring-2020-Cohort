#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK4 DAY1 BEST PRACTICES MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 2: Load packages  ####

library(tidyverse)
library(car)
library(caret)


#=================================================-
#### Slide 11: Prep: loading dataset  ####

# Set working directory to where we store data.
setwd(data_dir)

# Read CSV file called "ChemicalManufacturingProcess.csv"
CMP = read.csv("ChemicalManufacturingProcess.csv",
               header = TRUE,
               stringsAsFactors = FALSE)



#=================================================-
#### Slide 13: Summary statistics: CMP overview  ####

# Select only columns that contain "Bio" in their name.
CMP_bio = CMP %>% select(contains("Bio"))

# Check the dimensions of the resulting data frame.
dim(CMP_bio)

# Select only columns that contain "Man" in their name.
CMP_man = CMP %>% select(contains("Man"))

# Check the dimensions of the resulting data frame.
dim(CMP_man)


#=================================================-
#### Slide 14: Summary statistics: CMP_bio & CMP_man  ####

summary(CMP_bio)
summary(CMP_man[ , 1:12])



#=================================================-
#### Slide 16: Data cleaning: helpful function sapply   ####

# Let's check all of the types of variables in 
# this data by using the `sapply` function and 
# then see how many unique ones we have.
data_types = sapply(CMP, class)
head(data_types)
# Check for unique types.
unique(data_types)


#=================================================-
#### Slide 17: Data cleaning: NA options  ####

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


#=================================================-
#### Slide 18: Data cleaning: impute NAs  ####

# Apply the function to each variable in the data frame.
CMP_imputed = ImputeNAsWithMean(CMP)

# Take a look at the structure of the transformed data.
str(CMP_imputed)


#=================================================-
#### Slide 19: Best practices: near zero variance  ####

# Check for near-zero and zero variance in CMP data.
nzv = nearZeroVar(CMP_imputed)


# We look at the one column that seems to have nzv.
nearZeroVar(CMP, saveMetrics = TRUE)[8, ]

# We remove the nzv columns and rename CMP_imputed to CMP_cleaned 
# so we know we have completed our data cleansing steps.
CMP_cleaned = CMP_imputed[,-nzv]


#=================================================-
#### Slide 22: Exercise 1  ####




#=================================================-
#### Slide 31: Best practice: create CMP train  ####

# Set the seed.
set.seed(1)

# We will use this to split the actual CMP dataset.
train_index = createDataPartition(CMP_cleaned$Yield,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)            #<- 70% training, 30% test

# Subset the data to include only train set observations.
CMP_train = CMP_cleaned[train_index, ]

# Check number of rows for 70% of `CMP_cleaned` data.
0.7 * nrow(CMP_cleaned)

# Check number of rows of training set.
nrow(CMP_train)


#=================================================-
#### Slide 32: Best practice: create CMP test  ####

# Subset the data to include only test set observations.
CMP_test = CMP_cleaned[-train_index, ]

# Check number of rows for 30% of `CMP_cleaned` data.
0.3 * nrow(CMP_cleaned)

# Check number of rows of test set.
nrow(CMP_test)


#=================================================-
#### Slide 33: Model: multiple linear regression on CMP  ####

# Build linear model on training data.
mult_lin_model = lm(Yield ~ ., data = CMP_train)
mult_lin_model


#=================================================-
#### Slide 34: Model: summarize performance  ####

# Check summary of the model.
summary(mult_lin_model)


#=================================================-
#### Slide 35: Model: evaluate residuals  ####

summary(mult_lin_model$residuals)
# Residual standard error
summary(mult_lin_model)$sigma


#=================================================-
#### Slide 37: Model: evaluate r and adj r squared  ####

# R-squared
summary(mult_lin_model)$r.squared
# Adjusted R-squared.
summary(mult_lin_model)$adj.r.squared


#=================================================-
#### Slide 38: Model: evaluate f-statistic  ####

# Check summary of the model.
summary(mult_lin_model)$fstatistic

# Code to extract model p-value.
anova(mult_lin_model)$'Pr(>F)'[1]



#=================================================-
#### Slide 41: Exercise 2  ####




#=================================================-
#### Slide 43: Best practices: check assumptions  ####

par(mfrow = c(2, 2))
plot(mult_lin_model)


#=================================================-
#### Slide 44: Assumptions: linear  ####

# Plot the first plot of linear model:
# Residuals vs. Fitted.
plot(mult_lin_model, which = c(1))


#=================================================-
#### Slide 45: Assumptions: independent residuals  ####

# Plot the first plot of linear model:
# Residuals vs. Fitted.
plot(mult_lin_model, which = c(1))


#=================================================-
#### Slide 46: Assumptions: normality  ####

# Plot the second plot of linear model:
# Normal QQ plot.
plot(mult_lin_model, which = c(2))


#=================================================-
#### Slide 47: Assumptions: equal variance  ####

# Plot the third plot of linear model:
# Scale location.
plot(mult_lin_model, which = c(3))


#=================================================-
#### Slide 48: Influential: residuals vs. leverage  ####

# Plot the 5th plot of linear model:
# Residuals vs. leverage.
plot(mult_lin_model, which = c(5))


#=================================================-
#### Slide 51: Influential points: distance for all points  ####

# Store cooks.distance() output as a 
# variable - `cooksd`.
cooksd = cooks.distance(mult_lin_model)
head(cooksd)

# Plot the 4th plot of linear model:
# Cook's distance.
plot(mult_lin_model, which = c(4))


#=================================================-
#### Slide 52: Influential points: identify & remove  ####

# Influential row numbers.
influential = as.numeric(names(cooksd)[(cooksd > 4 * mean(cooksd, na.rm = T))]) 
influential

# We label our new training dataset and remove the influential points.
CMP_train_cooks_d = CMP_train[-influential, ]

# And we re-run the regression
mult_lin_model_cd = lm(Yield ~ ., data = CMP_train_cooks_d)


#=================================================-
#### Slide 57: Aliased coefficients: identifying  ####

# Identify aliased variables in the model.
aliased = alias(mult_lin_model_cd)
names(aliased)


#=================================================-
#### Slide 58: Aliased coefficients: extracting  ####

# Extract `Complete` matrix of results.
aliased_complete = aliased$Complete
rownames(aliased_complete)
# Transpose this matrix and save it as a vector.
aliased_vars = as.vector(t(aliased_complete))

# Let's name the entries.
names(aliased_vars) = colnames(aliased_complete)

# Save only the aliased variables 
# (where the correlation coefficient is not 0).
aliased_vars = aliased_vars[which(aliased_vars != 0)]
aliased_vars


#=================================================-
#### Slide 59: Aliased coefficients: adjust data  ####

# Making a custom operator (the opposite of `%in%`).
'%not in%' = Negate('%in%') #<- use `Negate` function to return 
                            #<- the opposite of the `%in%` function.

# Subset the train dataset by removing aliased variables.
CMP_train_adj = CMP_train_cooks_d[ , colnames(CMP_train_cooks_d) %not in% names(aliased_vars)]
dim(CMP_train_adj)

# Subset the test dataset by removing aliased variables.
CMP_test_adj = CMP_test[ , colnames(CMP_test) %not in% names(aliased_vars)]
dim(CMP_test_adj)


#=================================================-
#### Slide 60: Model: rerun after clean up  ####

# Re-run the linear model.
cmp_lin_model_adjusted = lm(Yield ~ ., data = CMP_train_adj)

summary(cmp_lin_model_adjusted)


#=================================================-
#### Slide 61: Assumptions: check again  ####

par(mfrow = c(2, 2))
plot(cmp_lin_model_adjusted, cex.axis = 1.5, cex.lab = 1.5)


#=================================================-
#### Slide 62: Assumptions: adjusted CMP vif  ####

# Let's see if we can now compute the VIF 
# scores without getting an error.
vif_scores = data.frame(names = 
                  names(vif(cmp_lin_model_adjusted)),
                  vif = vif(cmp_lin_model_adjusted))

# Let's order the VIF scores and 
# take a look at the ones above 10.
vif_scores = vif_scores %>%
  filter(vif >= 10) %>%
  arrange(vif)

# How many variables are there 
# with a vif over 10?
nrow(vif_scores)



#=================================================-
#### Slide 64: Exercise 3  ####




#=================================================-
#### Slide 68: Predict: a basic example  ####

# Import and run model from last session.
state_data = as.data.frame(state.x77)
state_data_sub = state_data[ , c(2, 6)]
state_lin_model = lm(`HS Grad` ~ Income, 
                     data = state_data_sub)

# Create vector of two values.
scenario = data.frame('Income' = c(5000, 5750))

# Predict scenario outcomes.
outcomes = predict(state_lin_model, 
                   newdata = scenario)

# View predicted values and calculate the difference. 
outcomes
diff(outcomes)



#=================================================-
#### Slide 69: Predict: yield in test data  ####

# Predict values of `Yield` using the test data.
predicted_values = predict(cmp_lin_model_adjusted,          #<- linear model object
                           newdata = CMP_test_adj[ , -1 ])  #<- test data without response variable
predicted_values


#=================================================-
#### Slide 70: Predict: residuals of model  ####

# Compute residuals and save them into a data frame.
cmp_lm_results = data.frame(predicted = predicted_values,        #<- values predicted by model
                            actual = CMP_test_adj[ , 1],         #<- actual values from data
                            residuals = CMP_test_adj[ , 1] - predicted_values) #<- residuals

head(cmp_lm_results)


#=================================================-
#### Slide 71: Predict: mean squared error  ####

# Residual sum of squares for predicted data.
pred_RSS = sum(cmp_lm_results$residuals^2)
pred_RSS

# Mean squared error from predicted values.
pred_MSE = pred_RSS / length(cmp_lm_results$residuals)
pred_MSE


#=================================================-
#### Slide 72: Predicting: root mean square error (RMSE)  ####

pred_RMSE_lin_reg = sqrt(pred_MSE)
pred_RMSE_lin_reg

# Let's get the range of yield values.
yield_range = max(CMP_test_adj$Yield) - 
  min(CMP_test_adj$Yield)
yield_range

# RMSE in percent values with 
# respect to yield's range.
pred_RMSE_lin_reg_precent = 
  (pred_RMSE_lin_reg/yield_range)*100

pred_RMSE_lin_reg_precent


#=================================================-
#### Slide 74: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
