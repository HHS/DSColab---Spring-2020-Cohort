#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK3 DAY2 INTRO TO STAT REGRESSION MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-


#### Question 1 ####
# Check the structure of state_data.
# Create a list of variables you want to keep and include Murder and Life Exp.
# Subset the state_data to only retain the variables in keep and save it to subset2.
# Answer:


#================================================-
#### Question 2 ####
# Check the covariance and correlation of state murder rate and life expectancy.
# What are they?
# Are they related?
# Answer:


#================================================-
#### Question 3 ####
# Create a correlation plot of all variables in stat_data, excluding Frost and Area.
# Which set of variables are the least positively correlated? (closest to zero on the positive side)
# Answer:


#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Create a scatter plot of Murder Rate vs Life Expectancy, with Murder Rate on the x axis.
# Make sure it looks nice and includes all the right labels and titles.
# We suggest "tomato4" as a color, but feel free to choose your own.
# Answer:


#================================================-
#### Question 2 ####
# Ehance the EDA of Murder and Life Expectancy, by showing
# fully enhanced histograms of Murder Rate and Life Expectancy,
# along side of the scatter plot in one row.

#Answer:

#### Question 3 ####
# USe the whichNA() function to check for NAs in the subset2 dataset.
# Are there any NAs?
# Answer:
whichNA = function(dataset){      
  for(i in 1:ncol(dataset)){                  
    is_na = is.na(dataset[, i])               
    if(any(is_na)){                           
      na_ids = which(is_na)                   
      message = paste0(                       
        colnames(dataset)[i],
        "they are ",
        na_ids)            
      print(message)                         
    }
    else(print(paste0(colnames(dataset)[i]," has no NAs")))
  }                         
}


#================================================-
#### Question 4 ####
# How about are there any NAs in entire state_data?
# How about in the temp_heart_data.csv dataset?
# Or in the fast_food_data.csv dataset?
# Are there any NAs in those datasets?
# Answer:


#================================================-
#### Question 5 ####
# Which variables in subset2, the whole state dataset, the heart dataset, 
# and fast food dataset have zero variance?
# Answer:


#### Question 6 ####
# Create a linear model, lin_model2, that predicts state life exectancy based on state murder rate.
# What are the coefficients of the linear model produced?
# How can you interpret the model coefficents?

# Answer:


#================================================-
#### Question 7 ####
# Replot the scatter plot of life expectancy and murder rate. 
# Add the abline in a nice bright red.
# Pick a different line type than the one used in the class example.

# Answer:

                                           #<- line type


#### Exercise 3 ####
# =================================================-


#================================================-
#### Question 1 ####
# What is the performance of the coefficient for Murder? 
# Does its t-value suggest that it is statistically significant?
# Answer:


#================================================-
#### Question 2 ####
# By how much do the R-squared and the adjusted R-squared differ for lin_model2?
# Why are they so close? What needs to happen for adjusted R-squared to be much smaller?
# What does adjusted R-squared account for?
# Answer:


#================================================-
#### Question 3 ####
# How does the model perform overall?
# Demonstrate use of the code to see information related to the F-statistic.
# Without seeing the p-value, what can you say about the F-statistic?
# Answer:


#================================================-
##### Question 4 ####
# Plot the lin_model2 to answer the following questions:
# Is the relationship between the variables linear?
# Are the residuals independent?
# Are the residuals normally distributed?
# Do the residuals have equal variance?
# Are there any influential outliers?
# Answer:


#================================================-
#### Question 5 ####
# Repeat the model development process for prediciting the amount of calories in a food based on the total fat.
# Use the Fast Food dataset.
# Create the model ffood_mdl and report the model coefficients, if the coefficient is statistically significant,
# The r-squared and the adjusted R squared.
# Based on the overall model performance, is the model significant?
# Answer: 


#================================================-
#### Questions 6 ####
# Does the model meet the correct assumptions?
# Answer:



#### Exercise 4 ####
# =================================================-


#### Question 1 ####
# Create a multivariate model using the fast food data set that includes all the nutritional variables.
# Include only Total Fat and Carbs, no need to include subset of those variables (Sugar, saturdated fat, transfat, etc)

# Answer:

#================================================-
#### Question 2 ####
# Which variable in the model is not statistially significant? 
# Which could we drop from the model?
# Answer:


#================================================-
#### Question 3 ####
# Does the model meet the assumptions?
# Answer:


#================================================-
#### Question 4 ####
# How contained in the variance inflation factor? 
# Answer:



