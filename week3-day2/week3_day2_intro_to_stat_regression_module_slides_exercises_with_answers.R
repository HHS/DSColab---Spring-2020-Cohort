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
str(state_data)
keep = c('Murder', 'Life Exp')
subset2 = state_data[,keep]

#================================================-
#### Question 2 ####
# Check the covariance and correlation of state murder rate and life expectancy.
# What are they?
# Are they related?
# Answer:
# Covariance: -3.86948
# Correlation: -0.7808458
# They are highly negatively correlated.

cov(subset2$Murder, subset2$`Life Exp`)
cor(subset2$Murder, subset2$`Life Exp`)

#================================================-
#### Question 3 ####
# Create a correlation plot of all variables in stat_data, excluding Frost and Area.
# Which set of variables are the least positively correlated? (closest to zero on the positive side)
# Answer:
# Illiteracy and Population have the smallest positive correlation.

subset3 = state_data[ , 1:6]
full_cor = cor(subset3)
corrplot(full_cor)



#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Create a scatter plot of Murder Rate vs Life Expectancy, with Murder Rate on the x axis.
# Make sure it looks nice and includes all the right labels and titles.
# We suggest "tomato4" as a color, but feel free to choose your own.
# Answer:

# Simple version 1:
plot(subset2$Murder,    
     subset2$`Life Exp`)

# Enhanced version 2:
plot(subset2$Murder,    
     subset2$`Life Exp`,
     col = "tomato4",                                          #<- add color to the point
     pch = 19,                                                 #<- choose point style* 
     xlab = "Murder Rate",                                     #<- make a clean label for x-axis
     ylab = "Life Exepctancy",                                 #<- make a clean label for y-axis 
     main = "Murder Rate vs Life Expectancy in 50 US States")  #<- name the plot

#================================================-
#### Question 2 ####
# Ehance the EDA of Murder and Life Expectancy, by showing
# fully enhanced histograms of Murder Rate and Life Expectancy,
# along side of the scatter plot in one row.

par(mfrow=c(1,3))                                               #<- show three plots in one row
               
plot(subset2$Murder,                   
     subset2$`Life Exp`,               
     col = "tomato4",                                           #<- add color to the point
     pch = 19,                                                  #<- choose point style* 
     xlab = "Murder Rate",                                      #<- make a clean label for x-axis
     ylab = "Life Exepctancy",                                  #<- make a clean label for y-axis 
     main = "Murder Rate vs Life Expectancy in 50 US States")   #<- name the plot

hist(subset2$Murder,    
     col = "lightblue",                                         #<- add color 
     xlab = "Murder Rate",                                      #<- name the x-axis
     main = "Murder Rate in 50 US states")                      #<- name the plot

hist(subset2$`Life Exp`,    
     col = "lightblue3",                                        #<- add color 
     xlab = "Life Expectancy",                                  #<- name the x-axis
     main = "Life Expectancy in 50 US states")                  #<- name the plot

#### Question 3 ####
# USe the whichNA() function to check for NAs in the subset2 dataset.
# Are there any NAs?
# Answer:
# No
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

whichNA(subset2)

#================================================-
#### Question 4 ####
# How about are there any NAs in entire state_data?
# How about in the temp_heart_data.csv dataset?
# Or in the fast_food_data.csv dataset?
# Are there any NAs in those datasets?
# Answer:
# There are no NAs in either the heart rate data dataset or the full state data.
# As expected there are NAs in the Trans Fat column of the fast_food_data.

# Read in data sets
fast_food = read.csv("fast_food_data.csv")
heart_data = read.csv("temp_heart_rate.csv")

# Check for NAs
whichNA(state_data)
whichNA(heart_data)
whichNA(fast_food)

#================================================-
#### Question 5 ####
# Which variables in subset2, the whole state dataset, the heart dataset, 
# and fast food dataset have zero variance?
# Answer:
# None!

nearZeroVar(subset2, saveMetrics = TRUE) 
nearZeroVar(state_data, saveMetrics = TRUE)
nearZeroVar(heart_data, saveMetrics = TRUE)
nearZeroVar(fast_food, saveMetrics = TRUE)

#### Question 6 ####
# Create a linear model, lin_model2, that predicts state life exectancy based on state murder rate.
# What are the coefficients of the linear model produced?
# How can you interpret the model coefficents?
# Answer:
# Intercept: 72.9736 Coefficent: -0.2839 
# Interpretation: There is a baseline life expectancy of 72.9 years
# And with each percent increase in murder rate the life expectancy decreases by .28 years.

# Create the model lin_model2:
lin_model2 = lm(`Life Exp` ~ Murder, 
               data = subset2)

# Inspect the output of the `lm` function.
lin_model2

#================================================-
#### Question 7 ####
# Replot the scatter plot of life expectancy and murder rate. 
# Add the abline in a nice bright red.
# Pick a different line type than the one used in the class example.
# Answer:

# Check abine options
?abline

# Plot from before:
plot(subset2$Murder,    
     subset2$`Life Exp`,
     col = "tomato4",                                            #<- add color to the point
     pch = 19,                                                   #<- choose point style* 
     xlab = "Murder Rate",                                       #<- make a clean label for x-axis
     ylab = "Life Exepctancy",                                   #<- make a clean label for y-axis 
     main = "Murder Rate vs Life Expectancy in 50 US States")    #<- name the plot
# Fit line
abline(lin_model2$coefficients[1],                               #<- intercept from the model
       lin_model2$coefficients[2],                               #<- slope from the model
       col = "red",                                              #<- color of the line
       lwd = 3,                                                  #<- line width
       lty = 4)                                                  #<- line type


#### Exercise 3 ####
# =================================================-


#================================================-
#### Question 1 ####
# What is the performance of the coefficient for Murder? 
# Does its t-value suggest that it is statistically significant?
# Answer:
# Yes. The t-value is -8.65 and the p-vallue is much less than 0.05

# Check coefficient summary.
summary(lin_model2)$coefficient

#================================================-
#### Question 2 ####
# By how much do the R-squared and the adjusted R-squared differ for lin_model2?
# Why are they so close? What needs to happen for adjusted R-squared to be much smaller?
# What does adjusted R-squared account for?
# Answer:
# They only differ by about 0.007. 
# They would differ more if there were more variables in the model. 
# Adjusted R-squared controls for adding more variables and over fitting.

# R-squared
summary(lin_model2)$r.squared

# Adjusted r-squared
summary(lin_model2)$adj.r.squared

#================================================-
#### Question 3 ####
# How does the model perform overall?
# Demonstrate use of the code to see information related to the F-statistic.
# Without seeing the p-value, what can you say about the F-statistic?
# Answer:
# The F-statistic is 74.99. The farther it is from 1, the better it is.

#Check the F-statistic
summary(lin_model2)$fstatistic

#================================================-
##### Question 4 ####
# Plot the lin_model2 to answer the following questions:
# Is the relationship between the variables linear?
# Are the residuals independent?
# Are the residuals normally distributed?
# Do the residuals have equal variance?
# Are there any influential outliers?
# Answer:
# Yes, yes, yes, yes, and no.

# Set up plot space
par(mfrow=c(2,2))

# Plot model.
plot(lin_model2)

#================================================-
#### Question 5 ####
# Repeat the model development process for prediciting the amount of calories in a food based on the total fat.
# Use the Fast Food dataset.
# Create the model ffood_mdl and report the model coefficients, if the coefficient is statistically significant,
# The r-squared and the adjusted R squared.
# Based on the overall model performance, is the model significant?
# Answer: 
# Yes, the model is significant. 
# As fat increases, so does the calories in the food. There is a positive relationship.
# With each increase in total fat, calories increases by 12.
# Yes, p values show they are significant. 

ffood_mdl = lm(fast_food$Calories ~ fast_food$Total.Fat..g.)

summary(ffood_mdl)

#================================================-
#### Questions 6 ####
# Does the model meet the correct assumptions?
# Answer:
# Yes!

plot(ffood_mdl)



#### Exercise 4 ####
# =================================================-


#### Question 1 ####
# Create a multivariate model using the fast food data set that includes all the nutritional variables.
# Include only Total Fat and Carbs, no need to include subset of those variables (Sugar, saturdated fat, transfat, etc)

mult_food = lm(Calories ~ Total.Fat..g. + Sodium..mg.+ Carbs..g.+Protein..g., data = fast_food)

#================================================-
#### Question 2 ####
# Which variable in the model is not statistially significant? 
# Which could we drop from the model?
# Answer:
# We could drop Sodium from the model, as its p-value is much greater than 0.05.
summary(mult_food)

#================================================-
#### Question 3 ####
# Does the model meet the assumptions?
# Answer:
# Yes.

plot(mult_food)

#================================================-
#### Question 4 ####
# How contained in the variance inflation factor? 
# Answer:
# Yes, all are under 10.

vif(mult_food)


