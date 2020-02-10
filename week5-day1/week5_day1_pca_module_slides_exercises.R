#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK5 DAY1 PCA MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####

# Set working directory to `data_dir`.
# Read "diabetes.csv" to the data set `diabetes`.
# Subset `diabetes` to not include the `Outcome` and name the subset `diabetes_sub`.
# While there are many ways to do this, use one of the functions form `tidyverse` to select variables.
# Are there any factors in the dataset?
# Confirm the structure of the dataset.

# Answer: 

#================================================-
#### Question 2 ####

# Make a correlation matrix.
# Construct a correlation plot using `corrplot`.
# Which variablels seem to be the most strongly correlated with `SkinThickness`?

# Answer: 


#================================================-
#### Question 3 ####
set.seed(2)

# Use `prcomp` to perform PCA on `diabetes_sub` to create `diabetes_pca`. 
# Set `scale = TRUE`.
# Extract the components from `diabetes_pca` and assign them to `diabetes_components`.
# How many components do we expect to see from `diabetes_pca`?
# What will be the class of `diabetes_components`?
# Confirm both.

# Answer:


#================================================-
#### Question 4 ####

# Take a look at the summary of the PCA.
# From looking only at the summary, which principal component explains 8.5% of the variance?

# Answer: 


#================================================-
#### Question 5 ####

# Extract and calculate the eigenvalues from `diabetes_pca` results.
# What is the eigenvalue of the third principal component?

# Answer: 



#================================================-
#### Question 6 ####

# Compute amount of variance explained by each principal component.
# Using your calculations confirm the percent varaince explained by PC6.
# Does the sum of all the percent variance explained equal 1? Please confirm.

# Answer: 



#================================================-
#### Question 7 ####

# Calculate the cumulative percent of varaince explained for each principal component?
# How much cumulative variance is explained by the 8th principal component?
# How many principal components do you need to use to retain 80% of the original variance in the data?
# What is the value of the final entry in the cumulative variance explained vector?

# Answer:


#================================================-
#### Question 8 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a screeplot of `diabetes_pca`.
# Between which two principal components does the variance explained decrease the sharpest?

# Answer:


#================================================-
#### Question 9 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a plot of individuals of `diabetes_pca`.

# Answer:

#================================================-
#### Question 10 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a plot of variables of `diabetes_pca`.

# Answer:


#================================================-
#### Question 11 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a biplot of `diabetes_pca`.

# Answer:

#================================================-
#### Question 12 ####
# Which of the 3 plots would you choose to demonstrate the relationships between variables
# in the space created by the first and second principal components?
# What is the most striking pattern you've notices when looking at that plot?
# How would you interpret that?
# What is the drawback of some of the plots you've produced?

# Answer: 


#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Let's now perform PCA on the fast food dataset.
# Read in "fast_food_data.csv" to `fast_food`. 
# Given the structure of `fast_food` and that PCA only works on numeric variables,
# which variables will need to be removed?

# Answer:



#================================================-
#### Question 2 ####

# Use the positions of the columns within `fast_food` to remove the the factor variables to create `fast_food_sub`. 
# `fast_food_sub` should only include variables related to nutrition.
# Then use `str_replace_all` to remove the "." in the column names.

# Answer:



#================================================-
#### Question 3 ####

# Now prepare the fast_food_data to be ready for PCA: scale and replace missing values.
# Scale `fast_food_sub` and assign the output to `fast_food_scale`.
# Assign the output of `ImputeNAsWithMean`  to `ff_imputed`.
# Then remove Calories `from ff_imputed`.

# Answer:



#================================================-
#### Question 4 ####

set.seed(2)

# Assign the output of `prcomp` to `ff_pca`. 
# Do you need to set scale to true when running `prcomp` on fastfood data?
# Using the summary of `ff_pca`, how many principal components should we use to retain about 90% of of the variance?

# Answer:


#================================================-
#### Question 5 ####

# Use `fviz_screeplot` to plot `ff_pca` and display the percent of variance explained by each principal component.
# Make screeplot to look at variation explained by each principal component.
# Use `my_ggtheme`.

# Answer:


#================================================-
#### Question 6 ####

# Having to manually check the % of variance retained each time is messy.
# To dynamically retain only the necessary principal components, we need to make some calculations.
# Use the standard deviations of `ff_pca` to calculate the eigenvalues `ff_eigenvalues`.
# Then use the `ff_eigenvalues` to calculate the cumulative percent of variance explained by each eigenvalue in `ff_eigenvalues`.
# Assign the output of this calculation to `ff_cum_percent_var_explained`.

# Answer:


#================================================-
#### Question 7 ####

# Create a data frame `ff_eigen_data` that includes two columns.
# The first column contains factor variables and is named `component`.
# component equals the index value of each eigenvalue in `ff_eigenvalues`.
# The second column is `ff_cum_percent_var_explained` and equals itself.
# How many rows do you expect our `ff_eigen_data` to have?
# Return `ff_eigen_data` to confirm.

# Answer: 


#================================================-
#### Question 8 ####

# Make a bar plot of cumulative variation expalined by principal components.

# Answer:


#================================================-
#### Question 9 ####

# Use nrow on `ff_eigen_data` to return the row index where the percent cumulative variance explained is LESS THAN or EQUAL to 90%.
# Assign this number to `n_var90ff`.
# How many principal components should we retained according to `n_var90ff`?

# Answer: 


#================================================-
#### Question 10 ####

# Create a subset of the components of `ff_pca` that uses `n_var90ff` as the cut-off for how many columns to retain.
# Name the subset `ff_90var`. 
# What class of variable is `ff_90var`?

# Answer: 


#================================================-
#### Question 11 ####

# Bind the `Calories` column from `fast_food_scale` on to `ff_90var`.
# When binding `Calories`, assign output to the same name `ff_90var`, but make sure to convert it to a `data.frame`.
# How many columns are now in `ff_90var`? And what is the first observation in ff_90var?

# Answer: 





#### Exercise 3 ####
# =================================================-


#### Question 1 ####

# Set random seed.
set.seed(2)

# Create a vector of IDs of observations to be used in the training sample, using a 70% split.
# Use the ids to subset the data to creat a training and test set, named `ff_90var_train` and `ff_90var_test`.
# How many rows are in each dataset?

# Answer: 



#================================================-
#### Question 2 ####

# Build a multiple linear regression model `ff_90var_lm` to predict `Calories` from the remaining variables in the training dataset.
# Which of the two coefficients is statisticaly significant?
# What is the F-statistic of the model?
# What is the adjusted r-squared?

# Answer:


#================================================-
#### Question 3 ####

# Calculate the residual sum of squares `ff_RSS_var90`, 
# the root mean squared error `ff_MSE_var90`,
# and the root mean squared error for ff_90var_lm.

# What is the RMSE in percent values with 
# respect to Calories's range?

# Answer:



#================================================-
#### Question 4 ####

# Check to see if `ff_90var_lm` meets the assumptions required of linear regression.
# Do any of the plots look suspect?

# Answer:
# The plots generated look fairly good, except for the thick lower tail of the Normal Q-Q plot.
# and a slightly thicker left portion of the residual plot vs the rest of it. 
# Since we are not striving for perfection, but having a good-enough model, we can say that 
# the model meets the LINE assumtions.

# Plot linear model graphs.


#================================================-
#### Question 5 ####

# Apply the model `ff_90var_lm` to the test values to create a new set of predicted vales `ff_predicted_values`.
# Remember to exclude Calories from the test set when using `predict`.
# What is the first predicted value in the dataset?

# Answer: 


#================================================-
#### Question 6 ####

# Create a data frame, `ff_lm_var90_results`, that includes:
# the predicted values, the actual values, and the residuals from applying `ff_90var_lm` to the test set.
# What is the residual for that first predicted value in the test set?

# Answer: 


#================================================-
#### Question 7 ####

# To visually see how well the model performed on the test data, 
# Let's plot the fitted values vs residuals along with the distribution of the residuals
# What is the largest residual in the data?
# Do the residuals look distributed normally or a bit skewed?

# Answer: 


#================================================-
#### Question 8 ####

# What is the RMSE for predicted data and the corresponding percent value?

# Answer: 


