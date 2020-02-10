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

# Answer: No.

# Set working directory.
setwd(data_dir)

# Read in data
diabetes = read.csv("diabetes.csv", header = TRUE)

View(diabetes)
str(diabetes)

# Use `select` function.
# One of the ways to do it is to tell `select`
# which variable(s) NOT to include.
diabetes_sub = diabetes %>% 
  select(-Outcome)          #<- select all BUT `Outcome` variable.

str(diabetes_sub)

#================================================-
#### Question 2 ####

# Make a correlation matrix.
# Construct a correlation plot using `corrplot`.
# Which variablels seem to be the most strongly correlated with `SkinThickness`?

# Answer: Insulin and BMI.

# Make a correlation matrix.
cor(diabetes_sub)
# Make correlation plot.
corrplot(cor(diabetes_sub))

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
# We expect to see eight principal components, because there were eight original variables.
# The components will be of class `matrix`.

# Create PCA.
diabetes_pca = prcomp(diabetes_sub, scale = TRUE)
diabetes_pca

# Extract principal components data.
diabetes_components = diabetes_pca$x

# Check class of the principal components.
class(diabetes_components)

# Check principal components.
diabetes_components

#================================================-
#### Question 4 ####

# Take a look at the summary of the PCA.
# From looking only at the summary, which principal component explains 8.5% of the variance?

# Answer: PC6
summary(diabetes_pca)

#================================================-
#### Question 5 ####

# Extract and calculate the eigenvalues from `diabetes_pca` results.
# What is the eigenvalue of the third principal component?

# Answer: 1.029
diabetes_eigenvalues = diabetes_pca$sdev^2
diabetes_eigenvalues[3]

#================================================-
#### Question 6 ####

# Compute amount of variance explained by each principal component.
# Using your calculations confirm the percent varaince explained by PC6.
# Does the sum of all the percent variance explained equal 1? Please confirm.

# Answer: Yes, it equals 8.5%. Yes, they sum to 1.
diab_percent_var_explained = diabetes_eigenvalues/sum(diabetes_eigenvalues)
diab_percent_var_explained[6]

# The sum of all variance should be 1.
sum(diab_percent_var_explained)

#================================================-
#### Question 7 ####

# Calculate the cumulative percent of varaince explained for each principal component?
# How much cumulative variance is explained by the 8th principal component?
# How many principal components do you need to use to retain 80% of the original variance in the data?
# What is the value of the final entry in the cumulative variance explained vector?

# Answer:
# Cumulative variance explained for PC8 is 100%. 
# Keep the first five principal components to retain about 80% of the variance.

# Compute the cumulative percent of variance explained
diab_cum_percent_var_explained = cumsum(diabetes_eigenvalues)/sum(diabetes_eigenvalues)
diab_cum_percent_var_explained[8]

# You need to retain 5 PCs to get about 80% variance explained by the principal components.
diab_cum_percent_var_explained[5]

# The final value in `diab_cum_percent_var_explained` should be 1.
# We can easily check that!
diab_cum_percent_var_explained[length(diab_cum_percent_var_explained)]

#### Question 8 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a screeplot of `diabetes_pca`.
# Between which two principal components does the variance explained decrease the sharpest?

# Answer:
# Between PC2 and PC3.

fviz_screeplot(diabetes_pca,          #<- pca output
               ggtheme = my_ggtheme)  #<- ggplot theme

#================================================-
#### Question 9 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a plot of individuals of `diabetes_pca`.

# Answer:
fviz_pca_ind(diabetes_pca,          #<- pca output
             ggtheme = my_ggtheme)  #<- ggplot theme

#### Question 10 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a plot of variables of `diabetes_pca`.

# Answer:
fviz_pca_var(diabetes_pca,          #<- pca output
             ggtheme = my_ggtheme)  #<- ggplot theme

#================================================-
#### Question 11 ####

# Use the `my_ggtheme` from the in-class exercises, to produce a biplot of `diabetes_pca`.

# Answer:
fviz_pca_biplot(diabetes_pca,          #<- pca output
                ggtheme = my_ggtheme)  #<- ggplot theme

#### Question 12 ####
# Which of the 3 plots would you choose to demonstrate the relationships between variables
# in the space created by the first and second principal components?
# What is the most striking pattern you've notices when looking at that plot?
# How would you interpret that?
# What is the drawback of some of the plots you've produced?

# Answer: 

# The variable plot (`fviz_pca_var`).
# All vectors of original variables are facing in similar direction.
# Some pairs of variables like Age and Pregnancies, 
# Blood Pressure and Glucose, BMI and Diabetes Pedigree Function, 
# Insulin and SkinThickness appear to have extremely similar (almost overlapping) directions.
# Values in those pairs of variables are most similar and have high positive correlation.
# Since the dataset is bigger than a handful of observations, the plots that contain a the individuals
# (i.e. individuals plot and biplot) are very crowded and hard to read.



#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Let's now perform PCA on the fast food dataset.
# Read in "fast_food_data.csv" to `fast_food`. 
# Given the structure of `fast_food` and that PCA only works on numeric variables,
# which variables will need to be removed?

# Answer:
# The categorical/factor variables will need to be removed.

# Read CSV file called "fast_food_data.csv"
fast_food = 
  read.csv("fast_food_data.csv",
           header = TRUE)

# View fast_food dataset in tabular data explorer.
View(fast_food)
str(fast_food)

#================================================-
#### Question 2 ####

# Use the positions of the columns within `fast_food` to remove the the factor variables to create `fast_food_sub`. 
# `fast_food_sub` should only include variables related to nutrition.
# Then use `str_replace_all` to remove the "." in the column names.

# Answer:

# Subset fast_food to not include the factor variables and to not include Revenue.
# The factor variables are the first three columns and revenue is the last.
fast_food_sub = fast_food[ , 4:(length(fast_food)-1)]

str(fast_food_sub)

# Use colnames and str_replace_all to remove the "." and replace with "".
colnames(fast_food_sub) = str_replace_all(colnames(fast_food_sub), "[.]", "")
str(fast_food_sub)

#================================================-
#### Question 3 ####

# Now prepare the fast_food_data to be ready for PCA: scale and replace missing values.
# Scale `fast_food_sub` and assign the output to `fast_food_scale`.
# Assign the output of `ImputeNAsWithMean`  to `ff_imputed`.
# Then remove Calories `from ff_imputed`.

# Answer:

# Scale data using `scale` function.
fast_food_scale = scale(fast_food_sub)

# Retrieve NA imputation function we wrote in Fundamentals of R.
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

# Impute the data.
ff_imputed = ImputeNAsWithMean(fast_food_scale)

# Remove `Calories` variable.
# Remember that it is the second column in the dataset.
ff_imputed = ff_imputed[ , -2]
ff_imputed

#================================================-
#### Question 4 ####

set.seed(2)

# Assign the output of `prcomp` to `ff_pca`. 
# Do you need to set scale to true when running `prcomp` on fastfood data?
# Using the summary of `ff_pca`, how many principal components should we use to retain about 90% of of the variance?

# Answer:
# No, `ff_imputed` has already been scaled.
# We should retain the first three principal components to retain 90% of the variance.

# Run PCA (no need to set scale = TRUE, because we already scaled the data.)
ff_pca = prcomp(ff_imputed)

# View the summary of PCA.
summary(ff_pca)

#================================================-
#### Question 5 ####

# Use `fviz_screeplot` to plot `ff_pca` and display the percent of variance explained by each principal component.
# Make screeplot to look at variation explained by each principal component.
# Use `my_ggtheme`.

# Answer:
fviz_screeplot(ff_pca,                     #<- PCA object
               ncp = length(ff_pca$sdev),  #<- number of components to plot 
               ggtheme = my_ggtheme)       #<- ggtheme

#================================================-
#### Question 6 ####

# Having to manually check the % of variance retained each time is messy.
# To dynamically retain only the necessary principal components, we need to make some calculations.
# Use the standard deviations of `ff_pca` to calculate the eigenvalues `ff_eigenvalues`.
# Then use the `ff_eigenvalues` to calculate the cumulative percent of variance explained by each eigenvalue in `ff_eigenvalues`.
# Assign the output of this calculation to `ff_cum_percent_var_explained`.

# Answer:
# Get eigenvalues from PCA results.
ff_eigenvalues = ff_pca$sdev^2

# Compute cumulative amount of variance explained by components.
ff_cum_percent_var_explained = cumsum(ff_eigenvalues)/sum(ff_eigenvalues)
ff_cum_percent_var_explained

#================================================-
#### Question 7 ####

# Create a data frame `ff_eigen_data` that includes two columns.
# The first column contains factor variables and is named `component`.
# component equals the index value of each eigenvalue in `ff_eigenvalues`.
# The second column is `ff_cum_percent_var_explained` and equals itself.
# How many rows do you expect our `ff_eigen_data` to have?
# Return `ff_eigen_data` to confirm.

# Answer: We expect to have 8 rows because there are 8 PC.
ff_eigen_data = data.frame(component = as.factor(1:length(ff_eigenvalues)),            #<- index of PC
                           ff_cum_percent_var_explained = ff_cum_percent_var_explained)#<- cumulative percentage
ff_eigen_data

#================================================-
#### Question 8 ####

# Make a bar plot of cumulative variation expalined by principal components.
ggplot(ff_eigen_data, aes(x = component,                    #<- plot PC id on x-axis
                           y = ff_cum_percent_var_explained)) + #<- plot cumulative percentage on y-axis
  geom_bar(stat = "identity",   #<- add geom bar identity (plot a raw number on y-axis)
           fill = "steelblue",  #<- set bar fill
           color = "steelblue", #<- set bar color
           alpha = 0.5) +       #<- set opacity
  my_ggtheme 

#================================================-
#### Question 9 ####

# Use nrow on `ff_eigen_data` to return the row index where the percent cumulative variance explained is LESS THAN or EQUAL to 90%.
# Assign this number to `n_var90ff`.
# How many principal components should we retained according to `n_var90ff`?

# Answer: 2
n_var90ff = nrow(ff_eigen_data[ff_eigen_data$ff_cum_percent_var_explained <= 0.90, ])
n_var90ff

#================================================-
#### Question 10 ####

# Create a subset of the components of `ff_pca` that uses `n_var90ff` as the cut-off for how many columns to retain.
# Name the subset `ff_90var`. 
# What class of variable is `ff_90var`?

# Answer: matrix

# Subset only as many principal components as necessary to retain 90% of variation in data.
ff_90var = ff_pca$x[ , 1:n_var90ff]
class(ff_90var)

#================================================-
#### Question 11 ####

# Bind the `Calories` column from `fast_food_scale` on to `ff_90var`.
# When binding `Calories`, assign output to the same name `ff_90var`, but make sure to convert it to a `data.frame`.
# How many columns are now in `ff_90var`? And what is the first observation in ff_90var?

# Answer: There are three columns.

# The first observation is:
#       Calories         PC1         PC2
# 1 -1.166030363 -2.48197402 -0.12407828

ff_90var = as.data.frame(cbind(Calories = fast_food_scale[, 2], ff_90var))
class(ff_90var)
head(ff_90var)



#### Exercise 3 ####
# =================================================-


#### Question 1 ####

# Set random seed.
set.seed(2)

# Create a vector of IDs of observations to be used in the training sample, using a 70% split.
# Use the ids to subset the data to creat a training and test set, named `ff_90var_train` and `ff_90var_test`.
# How many rows are in each dataset?

# Answer: 90 in training set, 36 in test set.

# Use createDataPartition
ids = createDataPartition(ff_90var$Calories, 
                          p = 0.7, 
                          list = FALSE)
head(ids)

# Subset the data for train sample.
ff_90var_train = ff_90var[ids, ]
nrow(ff_90var_train)

# Subset the data for test sample.
ff_90var_test = ff_90var[-ids, ]
nrow(ff_90var_test)

#================================================-
#### Question 2 ####

# Build a multiple linear regression model `ff_90var_lm` to predict `Calories` from the remaining variables in the training dataset.
# Which of the two coefficients is statisticaly significant?
# What is the F-statistic of the model?
# What is the adjusted r-squared?

# Answer:
# The coefficient for PC1 is statistically significant.
# The f-statistic of the model is 1124.
# The adjusted R squared is 96.19%

# Build the linear model.
ff_90var_lm = lm(Calories ~ ., data = ff_90var_train)

# Review the summary.
summary(ff_90var_lm)

#================================================-
#### Question 3 ####

# Calculate the residual sum of squares `ff_RSS_var90`, 
# the root mean squared error `ff_MSE_var90`,
# and the root mean squared error for ff_90var_lm.

# What is the RMSE in percent values with 
# respect to Calories's range?

# Answer:
# RSS = 3.426868
# MSE = 0.03807631
# RMSE = 0.1951315
# Range of Calories = 4.425056
# RMSE % of range = 4.409697

# Calculate residual sum of squares.
ff_RSS_var90 = sum(ff_90var_lm$residuals^2)
ff_RSS_var90

# Calculate mean squared error.
ff_MSE_var90 = ff_RSS_var90 / length(ff_90var_lm$residuals)
ff_MSE_var90

# Calculate root mean squared error.
ff_RMSE_var90 = sqrt(ff_MSE_var90)
ff_RMSE_var90

# Let's get the range of Calories values.
Calories_range = max(ff_90var_train$Calories) - min(ff_90var_train$Calories)
Calories_range

# RMSE in percent values with respect to Calories's range.
ff_RMSE_percent_var90 = (ff_RMSE_var90/Calories_range)*100
ff_RMSE_percent_var90

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
par(mfrow = c(2, 2))
plot(ff_90var_lm)

#================================================-
#### Question 5 ####

# Apply the model `ff_90var_lm` to the test values to create a new set of predicted vales `ff_predicted_values`.
# Remember to exclude Calories from the test set when using `predict`.
# What is the first predicted value in the dataset?

# Answer: -1.129

# Predict values of `Calories` using the test data.
ff_predicted_values = predict(ff_90var_lm,                     #<- `lm` model object
                              newdata = ff_90var_test[ , -1 ]) #<- test data without response variable
head(ff_predicted_values)

#================================================-
#### Question 6 ####

# Create a data frame, `ff_lm_var90_results`, that includes:
# the predicted values, the actual values, and the residuals from applying `ff_90var_lm` to the test set.
# What is the residual for that first predicted value in the test set?

# Answer: -0.0365

# Compute residuals.
ff_lm_var90_results = data.frame(predicted = ff_predicted_values,
                                 actual = ff_90var_test[ , 1 ],
                                 residuals = ff_90var_test[ , 1 ] - ff_predicted_values)
head(ff_lm_var90_results)

#================================================-
#### Question 7 ####

# To visually see how well the model performed on the test data, 
# Let's plot the fitted values vs residuals along with the distribution of the residuals
# What is the largest residual in the data?
# Do the residuals look distributed normally or a bit skewed?

# Answer: About 0.6, and a bit skewed.

# Create plots of residuals.
par(mfrow = c(1, 2))
plot(ff_lm_var90_results$predicted,
     ff_lm_var90_results$residuals,
     col = "red",
     xlab = "Fitted",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0,
       col = "gray",
       lty = 2,
       lwd = 2)
hist(ff_lm_var90_results$residuals,
     xlab = "Residuals",
     col = "grey",
     main = "Distribution of Residuals")

#### Question 8 ####

# What is the RMSE for predicted data and the corresponding percent value?

# Answer: 
# RMSE: 0.1942
# Percent: 4.872

# Calculate residual sum of squares.
ff_RSS_var90 = sum(ff_lm_var90_results$residuals^2)
# Calculate mean square error.
ff_MSE_var90 = ff_RSS_var90 / length(ff_lm_var90_results$residuals)
# Calculate root mean squared error.
ff_RMSE_var90 = sqrt(ff_MSE_var90)
ff_RMSE_var90

# RMSE in percent values with repect to calories range.
# Calculate the range of calories.
calories_range = max(ff_90var_test$Calories) - min(ff_90var_test$Calories)
calories_range

# Percent
ff_RMSE_percent_var90 = (ff_RMSE_var90/calories_range)*100
ff_RMSE_percent_var90



