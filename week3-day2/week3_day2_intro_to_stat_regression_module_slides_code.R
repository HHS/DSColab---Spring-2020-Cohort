#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK3 DAY2 INTRO TO STAT REGRESSION MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 3: Installing packages  ####

# install.packages("caret")
library(caret)
# install.packages("car")
library(car)
# install.packages("corrplot")
library(corrplot)
# install.packages("AppliedPredictiveModeling")
library(AppliedPredictiveModeling)


#=================================================-
#### Slide 7: Datasets in R: state.x77 data  ####

# This dataset is of type `matrix`. We don't want to modify the original dataset,
# so let's set this dataset to a variable, so that we can manipulate it freely.
state_data = as.data.frame(state.x77)

# The dataset contains 50 rows (i.e. 50 states) and 8 columns.
# It's easy to check the dimensions of any object in R with a simple `dim` function.
dim(state_data)

# Since matrix is a 2-dimensional object we get a vector with 2 entries:
# 1. The first one corresponds to the number of rows
dim(state_data)[1]

# 2. The second tells us how many columns we have
dim(state_data)[2]


#=================================================-
#### Slide 8: Datasets in R: state.x77 data  ####

state_data_sub = state_data[,c(2,6)]


#=================================================-
#### Slide 10: Summary statistics: income & HS graduation rate  ####

# State data subset - Income
summary(state_data_sub$Income)

# Univariate plot: box-and-whisker plot.
boxplot(state_data_sub$Income)
# State data subset - HS Grad
summary(state_data_sub$`HS Grad`)

# Univariate plot: box-and-whisker plot.
boxplot(state_data_sub$`HS Grad`)


#=================================================-
#### Slide 12: Summary statistics: covariance in R  ####

cov(state_data_sub$Income,state_data_sub$`HS Grad`)


#=================================================-
#### Slide 13: Summary statistics: correlation is scaled cov  ####

cor(state_data_sub$Income,state_data_sub$`HS Grad`)

# And we can save a correlation matrix
state_cor = cor(state_data_sub)

# Create correlation plot.
corrplot(state_cor)


#=================================================-
#### Slide 16: Exercise 1  ####




#=================================================-
#### Slide 18: Linear regression: state data  ####

# Look at the data we will be working with
head(state_data_sub)


#=================================================-
#### Slide 21: EDA: improved scatterplot  ####

plot(state_data_sub$Income,    
     state_data_sub$`HS Grad`,
     col = "steelblue",     
     pch = 19,              
     xlab = "Income",       
     ylab = "HS Grad Rate", 
     main = "Income vs HS Grad Rate in 50 US States") 



#=================================================-
#### Slide 22: EDA: histogram  ####

par(mfrow = c(1,2))            #<- show two plots in one row
hist(state_data_sub$Income)    #<- histogram of income
hist(state_data_sub$`HS Grad`) #<- histogram of hs grad



#=================================================-
#### Slide 23: EDA: improved histogram  ####

par(mfrow = c(1,2))  
hist(state_data_sub$Income,    
     col = "steelblue",               #<- add color 
     xlab = "Income",                 #<- name the x-axis
     main = "Income in 50 US states") #<- name the plot
hist(state_data_sub$`HS Grad`,    
     col = "steelblue",                           #<- add color 
     xlab = "HS grad Percentage",                 #<- name the x-axis
     main = "HS grad rate in 50 US states")       #<- name the plot


#=================================================-
#### Slide 26: Data cleaning: NAs  ####

whichNA = function(dataset){      
  for(i in 1:ncol(dataset)){                  
    is_na = is.na(dataset[, i])               
    if(any(is_na)){                           
      na_ids = which(is_na)                   
      message = paste0(                       
            colnames(dataset)[i],
            "they are",
            na_ids)            
      print(message)                         
    }
    else(print(paste0(colnames(dataset)[i]," has no NAs")))
  }                         
}


#=================================================-
#### Slide 27: Data cleaning: use NA function  ####

whichNA(state_data_sub)


#=================================================-
#### Slide 29: Data cleaning: testing for near zero variance  ####

nearZeroVar(state_data_sub, 
            saveMetrics = TRUE)  #<- we set saveMetrics = TRUE 


#=================================================-
#### Slide 32: Implement: build a linear model  ####

# Build linear model.
lin_model = lm(`HS Grad` ~ Income, 
               data = state_data_sub)

# Inspect the output of the `lm` function.
lin_model


#=================================================-
#### Slide 38: Exercise 2  ####




#=================================================-
#### Slide 41: Evaluate: using summary  ####

# Interpreting the summary of linear model
summary(lin_model)


#=================================================-
#### Slide 42: Evaluate: call    ####

summary(lin_model)$call


#=================================================-
#### Slide 43: Evaluate: residuals    ####

summary(lin_model$residuals)



#=================================================-
#### Slide 44: Evaluate: coefficients estimate  ####

summary(lin_model)$coefficient


#=================================================-
#### Slide 45: Evaluate: coefficients standard error  ####

summary(lin_model)$coefficient


#=================================================-
#### Slide 46: Evaluate: coefficient t-value  ####

summary(lin_model)$coefficient


#=================================================-
#### Slide 47: Evaluate: coefficients p-value  ####

summary(lin_model)$coefficient


#=================================================-
#### Slide 48: Evaluate: residual standard error  ####

# Residual standard error
summary(lin_model)$sigma

# Degrees of freedom (total rows - number of variables)
summary(lin_model)$df



#=================================================-
#### Slide 49: Evaluate: r-squared  ####

# R-squared
summary(lin_model)$r.squared


#=================================================-
#### Slide 50: Evaluate: Adjusted r-squared  ####

# Adjusted r-squared
summary(lin_model)$adj.r.squared


#=================================================-
#### Slide 51: Evaluate: f-statistic  ####

summary(lin_model)$fstatistic


#=================================================-
#### Slide 52: Final evaluation of summary metrics  ####

summary(lin_model)


#=================================================-
#### Slide 56: Assumptions: plot  ####

par(mfrow=c(2,2))
plot(lin_model)


#=================================================-
#### Slide 58: Meets assumpion: Linear satisfied  ####

plot(lin_model, which = c(1))


#=================================================-
#### Slide 62: Meets assumption: Normality satisfied  ####

plot(lin_model, which = c(2))


#=================================================-
#### Slide 64: Meets assumption: Equal residual variance satisfied  ####

plot(lin_model, which = c(3))


#=================================================-
#### Slide 66: Influential cases: no highlighted outliers  ####

plot(lin_model, which = c(4))


#=================================================-
#### Slide 69: Exercise 3  ####




#=================================================-
#### Slide 74: Multiple regression: adding a variable  ####

# Let's look at the original state data
head(state_data)

# We are going to add the variable Life Exp to our subset
# and run a multiple regression 
state_data_sub$`Life Exp` = state_data$`Life Exp`



#=================================================-
#### Slide 75: Data Cleaning: NAs   ####

# Check which entry(s) in in `Life Exp` column are NAs.
which(is.na(state_data_sub$`Life Exp`) == TRUE)


#=================================================-
#### Slide 76: Data Cleaning: near zero variance   ####

nearZeroVar(state_data_sub$`Life Exp`, 
            saveMetrics = TRUE)


#=================================================-
#### Slide 77: Build a multiple regression model  ####

# The formula for `n` predictor variables now looks like this: 
# response_var ~ predictor_var_1 + predictor_var_2 + ... + predictor_var_n

# Build a multiple linear regression model using Income and `Life Exp` as
# predictor variables and `HS Grad` as the response variable.
mult_lin_model = lm(`HS Grad`~ Income + `Life Exp`, #<- formula with 2 predictor & 1 response variables
                    data = state_data_sub)                 #<- dataset

# Check the model's coefficients.
mult_lin_model


#=================================================-
#### Slide 78: Evaluate multiple regression: model performance  ####

summary(mult_lin_model)


#=================================================-
#### Slide 79: Evaluate: model performance part 1  ####

summary(mult_lin_model)


#=================================================-
#### Slide 80: Evaluate: model performance part 2  ####

summary(mult_lin_model)


#=================================================-
#### Slide 82: Assumptions of multiple regression: plot  ####

par(mfrow=c(2,2))
plot(mult_lin_model)


#=================================================-
#### Slide 83: Assumption: linear  ####

plot(mult_lin_model, which = c(1))


#=================================================-
#### Slide 84: Assumption: normality  ####

plot(mult_lin_model, which = c(2))


#=================================================-
#### Slide 85: Assumption: equal variance  ####

plot(mult_lin_model, which = c(3))


#=================================================-
#### Slide 86: Influential: residuals vs. leverage  ####

plot(mult_lin_model, which = c(4))


#=================================================-
#### Slide 90: Variance inflation factor: testing the model  ####

vif(mult_lin_model)


#=================================================-
#### Slide 93: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
