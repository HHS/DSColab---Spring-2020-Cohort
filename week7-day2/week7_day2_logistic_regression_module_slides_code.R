#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK7 DAY2 LOGISTIC REGRESSION MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 2: Loading packages  ####

# Load `caret` package for working with ML methods.
library(caret)

# Load `ROCR` package for classifier assessment.
library(ROCR)


#=================================================-
#### Slide 15: Logistic regression: sample data  ####

# Let's make an example with 1 explanatory variable 
# `rating` and a binary response variable `sold`.
data_points = data.frame(rating = c(1, 2, 2.5, 3.3, 
                                    4.1, 4.5, 4.9, 5),
                         sold =  c(0, 0, 0, 0, 
                                   1, 1, 1, 1))
data_points

plot(data_points,
     pch = 19,
     cex = 2,
     col = "steelblue",
     main = "Tomato soup cans sold based on rating")


#=================================================-
#### Slide 16: Logistic regression: Using glm function  ####

# Let's run a logistic regression model on sample data.
glm_res = glm(sold ~ rating,      #<- formula
              data = data_points, #<- data 
              family = "binomial")#<- family of functions

attributes(glm_res)


#=================================================-
#### Slide 18: Logistic regression: Summary of glm  ####

summary(glm_res)


#=================================================-
#### Slide 19: Logistic performance: model coefficients  ####

summary(glm_res)$coefficients


#=================================================-
#### Slide 20: Logistic performance: Deviance  ####

# Null deviance.
glm_res$null.deviance

# Residual deviance.
glm_res$deviance

# Difference between them shows
# improvement in prediction by adding 
# predictor variables.
glm_res$null.deviance - 
  glm_res$deviance


#=================================================-
#### Slide 21: Logistic performance: aic  ####

glm_res$aic



#=================================================-
#### Slide 24: Exercise 1  ####




#=================================================-
#### Slide 27: Load the dataset  ####

# Set workding directory to `data_dir`.
setwd(data_dir)

# Load temperature-heart rate dataset.
temp_heart = read.csv("temp_heart_rate.csv", 
header = TRUE)

# Inspect the dataset.
head(temp_heart)


#=================================================-
#### Slide 28: Logistic regression: Pre-modeling EDA  ####

# Look at the strucutre of the data.
str(temp_heart)
# Creates a table of proportions using `prop.table`.
prop.table(
table(                   # <- creates a table of counts related to each variable
temp_heart[, 1]))  # <- denotes the variable that is being evaluated



#=================================================-
#### Slide 29: Model development: Train and Test  ####

# Set the seed.
set.seed(1)

# Split the `temp_heart_scaled` into test and train partitions.
train_index = createDataPartition(temp_heart$Gender,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data 
                                                      #   as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)            #<- 70% training, 30% test

# Subset the scaled and cleaned data to include only train set observations.
temp_heart_train = temp_heart[train_index, ]

# Subset the scaled and cleaned data to include only test set observations.
temp_heart_test = temp_heart[-train_index, ]


#=================================================-
#### Slide 30: GLM gender: Training data  ####

# Run logistic regression on `temp_heart_train` data.
temp_heart_logit = glm(Gender ~ ., family = "binomial", data = temp_heart_train)
summary(temp_heart_logit)


#=================================================-
#### Slide 31: GLM gender: Interpreting performance  ####

# Null deviance - residual deviance
temp_heart_logit$null.deviance - 
temp_heart_logit$deviance
# Extract AIC.
temp_heart_logit$aic


#=================================================-
#### Slide 33: Logistic regression: We pick a threshold  ####

summary(temp_heart_logit$fitted.values)


#=================================================-
#### Slide 37: ROC & AUC: For training data  ####

ROCR_pred = prediction(temp_heart_logit$fitted.values, temp_heart_train$Gender)
# Build performance object for plotting TPR vs FPR.
ROCR_perf = performance(ROCR_pred, 'tpr','fpr')
plot(ROCR_perf, col = 'darkblue',lwd = 3)
abline(a = 0, b = 1, col = "red",lwd = 3,lty = 2)
ROCR_auc = performance(ROCR_pred,
measure = "auc")
ROCR_auc@y.values[[1]]


#=================================================-
#### Slide 38: Confusion matrix: With .5 cutoff (Threshold)  ####

temp_heart_train$pred_class = factor(ifelse(temp_heart_logit$fitted.values > 0.5, "Male", "Female"))
conf_matrix = confusionMatrix(temp_heart_train$pred_class, temp_heart_train$Gender)
conf_matrix


#=================================================-
#### Slide 39: Logistic regression: Best cut off?  ####

acc.perf = performance(ROCR_pred, measure = "acc")
plot(acc.perf)
ind = which.max(slot(acc.perf, "y.values")[[1]] )
acc = slot(acc.perf, "y.values")[[1]][ind]
cutoff = slot(acc.perf, "x.values")[[1]][ind]
print(c(accuracy= acc, cutoff = cutoff))


#=================================================-
#### Slide 41: Exercise 2  ####




#=================================================-
#### Slide 43: Logistic regression: Predict on test data  ####

# Predict gender using the logistic regression model.
temp_heart_test$pred_prob = predict(temp_heart_logit, 
                                    newdata = temp_heart_test[, -1], 
                                    type = "response")
head(temp_heart_test$pred_prob)


#=================================================-
#### Slide 44: Convert predicted probabilities into class  ####

# Convert probabilities into class:
# Anything above 0.5080435 is classified as "Male" and below 0.5080435 as "Female".
temp_heart_test$pred_class = factor(ifelse(temp_heart_test$pred_prob > 0.5080435, 
                                           "Male", "Female")) 
head(temp_heart_test, 2)
tail(temp_heart_test, 2)


#=================================================-
#### Slide 45: Build Confusion matrix  ####

conf_matrix = confusionMatrix(temp_heart_test$pred_class, temp_heart_test$Gender)
conf_matrix


#=================================================-
#### Slide 46: Interpret confusion matrix  ####

# Extract just the confusion matrix.
conf_matrix$table


#=================================================-
#### Slide 47: Compute metrics for ROC curve  ####

# Get prediction probabilities using `prediction` from ROCR package.
ROCR_pred = prediction(temp_heart_test$pred_prob, temp_heart_test$Gender)

# Build performance object for plotting TPR vs FPR.
ROCR_perf = performance(ROCR_pred, 'tpr','fpr')



#=================================================-
#### Slide 48: Plot ROC curve and compute AUC  ####

plot(ROCR_perf, 
     col = 'darkblue',
     lwd = 3)
abline(a = 0, 
       b = 1,
       col = "red",
       lwd = 3,
       lty = 2)

# Compute area under the curve.
ROCR_auc = performance(ROCR_pred,
                       measure = "auc")
ROCR_auc@y.values[[1]]


#=================================================-
#### Slide 50: Exercise 3  ####




#=================================================-
#### Slide 52: Load and scale CMP data  ####

# Set working directory to `data_dir`.
setwd(data_dir)

# Set working directory to `data_dir`.
CMP = read.csv("ChemicalManufacturingProcess.csv",
               header = TRUE,
               stringsAsFactors = FALSE)

# Scale `CMP` dataset.
CMP_scale = scale(CMP)

# Save it as a data frame.
CMP_scale = as.data.frame(CMP_scale)


#=================================================-
#### Slide 53: Impute NAs in CMP data  ####

# NA imputation function.
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

# Impute NAs in CMP dataset.
CMP_cleaned = ImputeNAsWithMean(CMP_scale)



#=================================================-
#### Slide 54: Logistic regression on CMP: Converting Yield  ####

# What are the summary stats of `Yield`?
summary(CMP_cleaned$Yield)

# Look up the median of the `Yield`.
summary(CMP_cleaned$Yield)[3]


#=================================================-
#### Slide 55: Logistic regression on CMP: Converting Yield  ####

# To convert `Yield` to binary, lets make everything greater than or equal
# to the median using an `ifelse` statement.
CMP_cleaned$Yield = ifelse(CMP_cleaned$Yield >= summary(CMP_cleaned$Yield)[3],
                           "High yield",
                           "Low yield" )

# Convert `Yield` to a factor.
CMP_cleaned$Yield = as.factor(CMP_cleaned$Yield)
head(CMP_cleaned$Yield)


#=================================================-
#### Slide 56: Split CMP into train and test  ####

# Set the seed.
set.seed(1)

# Split CMP dataset into train and test data.
train_index = createDataPartition(CMP_cleaned$Yield,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)  

# Subset the data to include only train set observations.
CMP_train = CMP_cleaned[train_index, ]

# Subset the data to include only test set observations.
CMP_test = CMP_cleaned[-train_index, ]

# Check levels of the `Yield` variable in train and test partitions.
levels(CMP_train$Yield)
levels(CMP_test$Yield)


#=================================================-
#### Slide 61: Logistic regression on PCA reduced CMP data  ####

setwd(data_dir)

# Load the reduced CMP dataset.
CMP_90var = read.csv("CMP_pca_reduced.csv", header = TRUE)
head(CMP_90var, 2)



#=================================================-
#### Slide 62: PCA logistic: Train and test  ####

# Set the seed.
set.seed(1)

# Split CMP dataset into train and test data.
train_index = createDataPartition(CMP_90var$Yield,  #<- outcome variable
list = FALSE,     #<- avoid returning the data as a list
times = 1,        #<- split 1 time 
p = 0.7)  

# Subset the data to include only train set observations.
CMP_pca_train = CMP_90var[train_index, ]

# Subset the data to include only test set observations.
CMP_pca_test = CMP_90var[-train_index, ]

# Check levels of the `Yield` variable in train and test partitions.
levels(CMP_pca_train$Yield)
levels(CMP_pca_test$Yield)


#=================================================-
#### Slide 63: PCA logistic: Create model  ####

# Run logistic regression on `temp_heart_train` data.
CMP_pca_logit = glm(Yield ~ .,
family = "binomial",
data = CMP_pca_train)


#=================================================-
#### Slide 65: Coefficients and odds: Logistic regression on reduced CMP  ####

# Extract model coefficients.
model_coeff = coef(CMP_pca_logit)
# Compute odds ratios.
odds = exp(model_coeff)
odds
# Show odds ratios for variables that give over 50% change in predicted
# variable vs the change in a single unit of the explanatory variable.
odds[odds > 1.5]


#=================================================-
#### Slide 66: Deviance of logistic model: Reduced CMP  ####

# Take a look at null deviance.
CMP_pca_logit$null.deviance

# Look at the residual deviance.
CMP_pca_logit$deviance

# Evaluate difference between the residual deviance for the model 
# with predictors and the null model.
CMP_pca_logit$null.deviance - CMP_pca_logit$deviance


#=================================================-
#### Slide 67: Predict Yield with logistic: Reduced CMP data  ####

# Predict gender using the logistic regression model.
CMP_pca_test$pred_prob = predict(CMP_pca_logit, 
                                 newdata = CMP_pca_test[, -21], 
                                 type = "response")
CMP_pca_test$pred_prob


#=================================================-
#### Slide 68: Convert predicted probabilities into class  ####

# Find out which was 0 and which 1.
table(CMP_pca_logit$y, 
      CMP_pca_train[, 21])

# Convert probabilities into class:
# anything above 0.5 is classified as "Low yield" and below 0.5 as "High yield".
CMP_pca_test$pred_class = factor(ifelse(CMP_pca_test$pred_prob > 0.5, "Low yield", "High yield")) 
head(CMP_pca_test, 2)


#=================================================-
#### Slide 69: Build confusion matrix for test CMP data  ####

conf_matrix_pca = confusionMatrix(CMP_pca_test$pred_class, CMP_pca_test$Yield)
conf_matrix_pca


#=================================================-
#### Slide 70: Compute metrics for ROC curve: Reduced CMP data  ####

# Get prediction probabilities using `prediction` from ROCR package.
ROCR_pca_pred = prediction(CMP_pca_test$pred_prob, CMP_pca_test$Yield)

# Make performance object to plot TPR vs FPR.
ROCR_pca_perf = performance(ROCR_pca_pred, 'tpr','fpr')



#=================================================-
#### Slide 71: Plot ROC curve and compute AUC: reduced CMP  ####

# Build ROC curve with random guess reference line.
plot(ROCR_pca_perf, 
     col = 'darkgreen',
     lwd = 3)
abline(a = 0, 
       b = 1,
       col = "red",
       lwd = 3,
       lty = 2)
# Compute area under the curve.
ROCR_pca_auc = performance(ROCR_pca_pred,
                           measure = "auc")
ROCR_pca_auc@y.values[[1]]


#=================================================-
#### Slide 73: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
