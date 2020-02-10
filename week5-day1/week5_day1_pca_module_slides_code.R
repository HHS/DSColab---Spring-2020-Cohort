#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK5 DAY1 PCA MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 2: Load libraries  ####

# This removes scientific notation. 
# It is helpful to keep all numbers formatted similarly.
options(scipen = 999)

# Load libraries.
library(tidyverse)
library(corrplot)
# For scree-plots.
library(factoextra)
# For train and test.
library(caret)


#=================================================-
#### Slide 3: Directory settings  ####

# Set `main_dir` to the location of your `af-werx` folder (for Mac/Linux).
main_dir = "~/Desktop/hhs-r-2020"
# Set `main_dir` to the location of your `af-werx` folder (for Windows).
main_dir = "C:/Users/[username]/Desktop/hhs-r-2020"
# Make `data_dir` from the `main_dir` and 
# remainder of the path to data directory.
data_dir = paste0(main_dir, "/data")
# Make `plots_dir` from the `main_dir` and 
# remainder of the path to plots directory.
plot_dir = paste0(main_dir, "/plots")


#=================================================-
#### Slide 23: Case study: a can of tomato soup  ####

tomato_cans = matrix(c(2, 4, 3, 1, 5, 7, 3, 5, 5, 3.5, 6, 5.6), 
                     nrow = 4, 
                     ncol = 3)
# Name columns.
colnames(tomato_cans) = c("height", "price", "pos. on shelf")

# Take a look at the data.
tomato_cans


#=================================================-
#### Slide 28: Tomato can: correlation  ####

# Take a look at the correlation matrix of all 3 variables.
cor(tomato_cans)

# Make correlation plot.
corrplot(cor(tomato_cans))


#=================================================-
#### Slide 29: Tomato can: run PCA  ####

# Run PCA, set `scale` paramenter to TRUE if you want to scale your data.
tomato_pca = prcomp(tomato_cans, scale = TRUE)
# Take a look at the attributes of the PCA output.
attributes(tomato_pca)


#=================================================-
#### Slide 30: Tomato can: view results of prcomp  ####

# Take a look at the default PCA output.
tomato_pca
# Extract principal components data.
tomato_components = tomato_pca$x
tomato_components

# Check class of the principal components.
class(tomato_components)


#=================================================-
#### Slide 31: Tomato can: extracting result elements  ####

# Take a look at the summary of the PCA.
summary(tomato_pca)

# Get eigenvalues from PCA results.
tomato_eigenvalues = tomato_pca$sdev^2
tomato_eigenvalues



#=================================================-
#### Slide 32: Tomato can: calculating percent variance  ####

# Compute amount of variance explained by each principal component.
percent_var_explained = tomato_eigenvalues/sum(tomato_eigenvalues)
percent_var_explained

# The sum of all variance should be 1.
sum(percent_var_explained)


#=================================================-
#### Slide 33: New function: cumsum  ####

# Make a vector of numbers from 1 through 10,
test_vec = 1:10

# Test the total sum of all values.
sum(test_vec)

# Get cumulative sums for each value.
cumsum(test_vec)



#=================================================-
#### Slide 34: Tomato can: calculating cumulative variance  ####

# Compute cumulative amount of variance explained by components.
cum_percent_var_explained = cumsum(tomato_eigenvalues)/sum(tomato_eigenvalues)
cum_percent_var_explained


#=================================================-
#### Slide 36: Tomato can: confirming uncorrelated  ####

# Build correlation matrix from 
# principal components.
cor(tomato_components)

# Plot the correlation matrix.
corrplot(cor(tomato_components))


#=================================================-
#### Slide 37: Factoextra and screeplot for variance  ####

?fviz_screeplot

# Since we can use the `ggtheme` argument, 
# we can save ggplot2 theme to variable 
# and pass it to screeplot function.
my_ggtheme = theme_bw() + 
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16))



#=================================================-
#### Slide 38: Tomato can: visualizing variance  ####

# Construct a scree plot from PCA results.
fviz_screeplot(tomato_pca,          #<- pca output
               ggtheme = my_ggtheme)



#=================================================-
#### Slide 39: Factoextra to visualize points  ####

?fviz_pca



#=================================================-
#### Slide 40: Tomato can: visualizing new coordinates  ####

# Plot inidividual datapoints in the principal
# component coordinate system.
fviz_pca_ind(tomato_pca, 
             ggtheme = my_ggtheme)

# Plot variables in the principal
# component coordinate system.
fviz_pca_var(tomato_pca, 
             ggtheme = my_ggtheme)


#=================================================-
#### Slide 41: Viewing results of prcomp  ####

# Plot both variables and datapoints in 
# principal component coordinate system.
fviz_pca_biplot(tomato_pca, 
                ggtheme = my_ggtheme)



#=================================================-
#### Slide 43: Exercise 1  ####




#=================================================-
#### Slide 45: Loading dataset  ####

# Set working directory to where we store data.
setwd(data_dir)

# Read CSV file called 
# "ChemicalManufacturingProcess.csv"
CMP = 
  read.csv("ChemicalManufacturingProcess.csv",
           header = TRUE)

# View CMP dataset in tabular data explorer.
View(CMP)


#=================================================-
#### Slide 47: Prepare data for PCA  ####

# Scale data using `scale` function.
CMP_scaled = scale(CMP)

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
CMP_imputed = ImputeNAsWithMean(CMP_scaled)

# Remove `Yield` variable (we are going to need it unchanged for 
# running linear model on newly generated principle components instead
# original predictor variables.)
CMP_imputed = CMP_imputed[, -1]


#=================================================-
#### Slide 48: Choosing the dimensions to retain  ####

# Set random seed to make results reproducible.
set.seed(1)

# Run PCA (no need to set scale = TRUE, because we already scaled the data.)
CMP_pca = prcomp(CMP_imputed)

# View the summary of PCA.
summary(CMP_pca)



#=================================================-
#### Slide 49: Choosing the dimensions to retain  ####

# Make screeplot to look at variation explained by each principal component.
fviz_screeplot(CMP_pca,                    #<- PCA object
               ncp = length(CMP_pca$sdev), #<- number of components to plot 
               ggtheme = my_ggtheme)       #<- ggtheme


#=================================================-
#### Slide 50: Calculating percentage data  ####

# Get eigenvalues from PCA results.
CMP_eigenvalues = CMP_pca$sdev^2
str(CMP_eigenvalues)

# Compute cumulative amount of variance explained by components.
cum_percent_var_explained = cumsum(CMP_eigenvalues)/sum(CMP_eigenvalues)
str(cum_percent_var_explained)


#=================================================-
#### Slide 51: Variance percentage data  ####

# Save eigenvalues & percentage data.
CMP_eigen_data = data.frame(component = as.factor(1:length(CMP_eigenvalues)),     #<- index of PC
                            cum_percent_var_explained = cum_percent_var_explained)#<- cumulative percentage
head(CMP_eigen_data)


#=================================================-
#### Slide 52: Variance percentage data  ####

# Make a bar plot of cumulative variation explained by principal components.
ggplot(CMP_eigen_data, aes(x = component,                    #<- plot PC id on x-axis
                           y = cum_percent_var_explained)) + #<- plot cumulative percentage on y-axis
  geom_bar(stat = "identity",   #<- add geom bar identity (plot a raw number on y-axis)
           fill = "steelblue",  #<- set bar fill
           color = "steelblue", #<- set bar color
           alpha = 0.5) +       #<- set opacity
  my_ggtheme                    #<- add theme


#=================================================-
#### Slide 53: Choosing the dimensions to retain  ####

# Count number of rows where cumulative % of var explained is <= 90%.
n_var90 = nrow(CMP_eigen_data[CMP_eigen_data$cum_percent_var_explained <= 0.90, ])
n_var90

# Count number of rows where cumulative % of var explained is <= 95%.
n_var95 = nrow(CMP_eigen_data[CMP_eigen_data$cum_percent_var_explained <= 0.95, ])
n_var95


#=================================================-
#### Slide 55: Retaining 90% of variation in data  ####

# Subset only as many principal components as necessary
# to retain 90% of variation in data.
CMP_90var = CMP_pca$x[, 1:n_var90]
class(CMP_90var)



#=================================================-
#### Slide 56: Retaining 90% of variation in data  ####

# Make sure to add back the `Yield` variable and save as data frame.
CMP_90var = as.data.frame(cbind(Yield = CMP_scaled[, 1], CMP_90var))
class(CMP_90var)



#=================================================-
#### Slide 58: Exercise 2  ####




#=================================================-
#### Slide 60: Split into train and test  ####

# Set random seed.
set.seed(1)

# Create a vector of IDs of observations to 
# be used in the training sample.
ids = createDataPartition(CMP_90var$Yield, 
                          p = 0.7, 
                          list = FALSE)
head(ids)

# Subset the data for train sample.
CMP_90var_train = CMP_90var[ids, ]
nrow(CMP_90var_train)

# Subset the data for test sample.
CMP_90var_test = CMP_90var[-ids, ]
nrow(CMP_90var_test)


#=================================================-
#### Slide 61: Linear model on reduced data (90% of variation)  ####

# Run linear model on principal components data.
CMP_90var_lm = lm(Yield ~ ., data = CMP_90var_train)

# Review the summary.
summary(CMP_90var_lm)



#=================================================-
#### Slide 62: Other metrics of lm performance  ####

# Calculate residual sum of squares.
cmp_RSS_var90 = sum(CMP_90var_lm$residuals^2)

# Calculate mean squared error.
cmp_MSE_var90 = cmp_RSS_var90 / 
  length(CMP_90var_lm$residuals)

# Calculate root mean squared error.
cmp_RMSE_var90 = sqrt(cmp_MSE_var90)
cmp_RMSE_var90

# Let's get the range of yield values.
yield_range = max(CMP_90var_train$Yield) - 
  min(CMP_90var_train$Yield)
yield_range

# RMSE in percent values with 
# respect to yield's range.
cmp_RMSE_percent_var90 = 
  (cmp_RMSE_var90/yield_range)*100

cmp_RMSE_percent_var90


#=================================================-
#### Slide 63: Testing for lm assumptions  ####

# Plot linear model graphs.
par(mfrow = c(2, 2))
plot(CMP_90var_lm)


#=================================================-
#### Slide 64: Predicting the Yield (90% of variation)  ####

# Predict values of `Yield` using the test data.
predicted_values = predict(CMP_90var_lm,                     #<- `lm` model object
                           newdata = CMP_90var_test[ , -1 ]) #<- test data without response variable
predicted_values


#=================================================-
#### Slide 65: Predicting the Yield (90% of variation)  ####

# Compute residuals.
cmp_lm_var90_results = data.frame(predicted = predicted_values,
                                  actual = CMP_90var_test[ , 1 ],
                                  residuals = CMP_90var_test[ , 1 ] - predicted_values)
head(cmp_lm_var90_results)


#=================================================-
#### Slide 67: Visualizing results  ####

# Let's plot the fitted values vs residuals along with
# the distribution of the residuals to see how well our model performed.
par(mfrow = c(1, 2))
plot(cmp_lm_var90_results$predicted,
     cmp_lm_var90_results$residuals,
     col = "red",
     xlab = "Fitted",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0,
       col = "gray",
       lty = 2,
       lwd = 2)
hist(cmp_lm_var90_results$residuals,
     xlab = "Residuals",
     col = "grey",
     main = "Distribution of Residuals")


#=================================================-
#### Slide 68: Computing RMSE for predicted data  ####

# Calculate residual sum of squares.
cmp_RSS_var90 = sum(cmp_lm_var90_results$residuals^2)

# Calculate mean squared error.
cmp_MSE_var90 = cmp_RSS_var90 / 
  length(cmp_lm_var90_results$residuals)

# Calculate root mean squared error.
cmp_RMSE_var90 = sqrt(cmp_MSE_var90)
cmp_RMSE_var90

# Let's get the range of yield values.
yield_range = max(CMP_90var_test$Yield) - 
  min(CMP_90var_test$Yield)
yield_range

# RMSE in percent values with 
# respect to yield's range.
cmp_RMSE_percent_var90 = 
  (cmp_RMSE_var90/yield_range)*100

cmp_RMSE_percent_var90


#=================================================-
#### Slide 70: Exercise 3  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
