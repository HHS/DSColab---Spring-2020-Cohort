#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK7 DAY1 INTRO TO CLASSIFICATION MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 3: Loading packages  ####

#install.packages("ROCR")
#install.packages("e1071")
library(e1071)
library(caret)
library(ROCR)


#=================================================-
#### Slide 13: Exercise 1  ####




#=================================================-
#### Slide 17: Load the dataset  ####

setwd(data_dir)
temp_heart = read.csv("temp_heart_rate.csv", TRUE)
head(temp_heart)


#=================================================-
#### Slide 19: The data at first glance  ####

# Look at the structure of the data
str(temp_heart)

# Examine the distribution of gender from the sample population

# prop.table creates a table of proportions
prop.table(
  table(              # <- creates a table of counts related to each variable
    temp_heart[,1]))  # <- denotes the variable that is being evaluated



#=================================================-
#### Slide 20: Check for NAs  ####

# Let's find all NAs in the dataset.
is_NA = is.na(temp_heart)

# Are there NAs in the dataset?
sum(is_NA) / sum(!is_NA)


#=================================================-
#### Slide 21: Scaling the predictors  ####

# Scale the predictors, transform the data to a data frame so 
# that we can add gender back in
temp_heart_scaled = as.data.frame(sapply(temp_heart[,2:3],scale))

# Make sure to add gender back to the scaled data set
gender = temp_heart[,1]
temp_heart_scaled$Gender = gender

# Inspect scaled values
head(temp_heart_scaled)


#=================================================-
#### Slide 24: Prepare for prediction: labeling the target  ####

# Setting levels for both training and test data
levels(temp_heart_scaled$Gender) =
  make.names(levels(factor(temp_heart_scaled$Gender)))
       
levels(temp_heart_scaled$Gender) =
  make.names(levels(factor(temp_heart_scaled$Gender)))


#=================================================-
#### Slide 27: Train & test: small scale before n-fold  ####

# Set the seed.
set.seed(1)

# We will use this to split the temp_heard dataset.
train_index = createDataPartition(temp_heart_scaled$Gender,  #<- outcome variable
                                  list = FALSE,              #<- avoid returning the data as a list
                                  times = 1,                 #<- split 1 time 
                                  p = 0.7)                   #<- 70% training, 30% test

# Subset the scaled and cleaned data to include only train set observations.
temp_heart_train = temp_heart_scaled[train_index, ]
# Subset the scaled and cleaned data to include only test set observations.
temp_heart_test = temp_heart_scaled[-train_index, ]


#=================================================-
#### Slide 29: kNN: train the model  ####

# We first train the model on just the training data, without using cross validation
knn_fit = train(Gender ~., 
                 data = temp_heart_train, 
                 method = "knn")


#=================================================-
#### Slide 30: kNN: predict on test  ####

test_pred = predict(knn_fit, 
                     newdata = temp_heart_test)


#=================================================-
#### Slide 32: Exercise 2  ####




#=================================================-
#### Slide 43: Exercise 3  ####




#=================================================-
#### Slide 46: Finding optimal k  ####

ctrl = trainControl(method="repeatedcv",  
                     repeats = 3,         
                     classProbs=TRUE)     
knn_fit_cv = train(Gender ~ ., 
                data = temp_heart_train, 
                method = "knn", 
                trControl = ctrl,
                tuneLength = 20)


#=================================================-
#### Slide 49: Using the optimized model to predict  ####

test_pred_cv = predict(knn_fit_cv,newdata = temp_heart_test )


#=================================================-
#### Slide 53: kNN on CMP: data pre-processing  ####

setwd(data_dir)
CMP = 
  read.csv("ChemicalManufacturingProcess.csv",
           header = TRUE,
           stringsAsFactors = FALSE)

# Scale `CMP` dataset
CMP_scale = scale(CMP)

# Save it as a data frame
CMP_scale = as.data.frame(CMP_scale)
# Impute NAs in CMP dataset
CMP_NA_impute = ImputeNAsWithMean(CMP_scale)

# rename it as CMP_cleaned
CMP_cleaned = CMP_NA_impute


#=================================================-
#### Slide 54: kNN on CMP: converting Yield  ####

# What are the summary stats of `Yield`?
summary(CMP_cleaned$Yield)

# Median
summary(CMP_cleaned$Yield)[3]

# To convert Yield to binary, lets make everything greater than or equal
# to the median using an ifelse statement
CMP_cleaned$Yield = ifelse(CMP_cleaned$Yield >= summary(CMP_cleaned$Yield)[3],
                           "High yield",
                           "Low yield" )
# Convert Yield to a factor
CMP_cleaned$Yield = as.factor(CMP_cleaned$Yield)

head(CMP_cleaned$Yield)


#=================================================-
#### Slide 55: kNN: train model using cv  ####

# Let's split the cleaned dataset into test and train:
# Set the seed.
set.seed(1)

# We will use this to split the actual CMP dataset.
train_index = createDataPartition(CMP_cleaned$Yield,  #<- outcome variable
                                  list = FALSE,       #<- avoid returning the data as a list
                                  times = 1,          #<- split 1 time 
                                  p = 0.7)  

# Subset the data to include only train set observations.
CMP_train = CMP_cleaned[train_index, ]

# Subset the data to include only test set observations.
CMP_test = CMP_cleaned[-train_index, ]
# Make sure to name the levels
levels(CMP_train$Yield) =
  make.names(levels(factor(CMP_train$Yield)))

levels(CMP_test$Yield) =
  make.names(levels(factor(CMP_test$Yield)))



#=================================================-
#### Slide 56: kNN: train model using cv  ####

# Run kNN, set cv as train control first, include two class summary:
CMP_ctrl = trainControl(method="repeatedcv",
                     repeats = 3,
                     classProbs=TRUE,
                     summaryFunction = twoClassSummary)

CMP_knn = train(Yield ~ ., data = CMP_train, 
                method = "knn", 
                trControl = CMP_ctrl,  
                tuneLength = 20)


#=================================================-
#### Slide 57: kNN: predict   ####

knnPredict = predict(CMP_knn,newdata = CMP_test )


#=================================================-
#### Slide 59: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
