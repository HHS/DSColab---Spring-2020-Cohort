#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK2 DAY2 STATIC VIS MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 8: Loading CMP dataset for EDA  ####

# Set working directory to where we store data.
setwd(data_dir)

# Read CSV file called "ChemicalManufacturingProcess.csv"
CMP = read.csv("ChemicalManufacturingProcess.csv",
               header = TRUE,
               stringsAsFactors = FALSE)


#=================================================-
#### Slide 11: Recap: subsetting data  ####

# Let's make a vector of column indices we would like to save.
column_ids = c(1:4,  #<- concatenate a range of ids
               14:16)#<- with another a range of ids
column_ids

# Let's save the subset into a new variable.
CMP_subset = CMP[ , column_ids]
str(CMP_subset)


#=================================================-
#### Slide 14: Univariate plots: boxplot  ####

# Yield summary.
summary(CMP_subset$Yield)


#=================================================-
#### Slide 16: R base colors  ####

# There are a total of 657 colors in 
# the `colors()` vector.
str(colors())



#=================================================-
#### Slide 18: Make a sample of colors for variables  ####

# Set random seed to get the same sample every time!
set.seed(1)

# We have as many variables as columns in our data.
# Save number of columns to a variable using `ncol` function.
n_cols = ncol(CMP_subset)

# Pick a sample of colors for each
# variable in our data set
col_sample = sample(colors(),#<- vector of colors
                    n_cols)  #<- n elements to sample 
col_sample


#=================================================-
#### Slide 19: Compare variables: boxplots combined  ####

# Make a box plot of all variables and give a vector of colors for each of them.
boxplot(CMP_subset, col = col_sample) 


#=================================================-
#### Slide 20: Univariate plots: histogram  ####

# Histogram data without plot.
hist(CMP_subset$Yield, plot = FALSE)

# Univariate plot: histogram.
hist(CMP_subset$Yield)


#=================================================-
#### Slide 21: Univariate plots: histogram  ####

# Customize your histogram.
hist(CMP_subset$Yield,
     col = col_sample[1]) #<- set color

# Customize your histogram.
hist(CMP_subset$Yield,
     col = col_sample[1],
     xlab = "Yield",   #<- set x-axis label
     main = "Dist. of Yield") #<- set title


#=================================================-
#### Slide 22: Compare variables: histograms combined  ####

# Make a combined histogram plot.
par(                                    #<- set plot area parameters with `par`
    mfrow = c(1, 2))                    #<- split area into 1 row 2 columns with `mfrow` 
hist(CMP_subset$BiologicalMaterial01,   #<- add 1st histogram
     col = col_sample[2],
     xlab = "Bio Material #1",   
     main = "Dist. of Bio Material #1")
hist(CMP_subset$BiologicalMaterial02,   #<- add 2nd histogram
     col = col_sample[3],
     xlab = "Bio Material #2",   
     main = "Dist. of Bio Material #2")


#=================================================-
#### Slide 25: Bivariate plots: scatterplot  ####

# Generic scatterplot.
plot(CMP_subset[ , 2], #<- variable for x-axis
     CMP_subset[ , 1]) #<- variable for y-axis

# Add axis labels and title.
plot(CMP_subset[ , 2], 
     CMP_subset[ , 1],
     xlab = "Bio Material 01",
     ylab = "Yield",
     main = "Bio Material 01 vs Yield") 


#=================================================-
#### Slide 26: Bivariate plots: scatterplot  ####

# Customize your scatterplot.
plot(CMP_subset[ , 2], 
     CMP_subset[ , 1],
     xlab = "Bio Material 01",
     ylab = "Yield",
     main = "Bio Material 01 vs Yield",
     pch = 8,   #<- type of symbol to use
     cex = 2,   #<- scale of the point
     col = "steelblue") 


#=================================================-
#### Slide 28: Exercise 1  ####




#=================================================-
#### Slide 31: Multivariate plots: scatterplot matrix  ####

# Plot scatterplots for many variables.
pairs(CMP_subset[, 1:4], #<- select variables
      pch = 19,          #<- set symbol
      col = "steelblue") #<- set color


#=================================================-
#### Slide 34: Exercise 2  ####




#=================================================-
#### Slide 38: Computing correlations between variables  ####

# Compute a correlation matrix of first 4
# variables using `cor` function.
CMP_cor = cor(CMP_subset[, 1:4])



#=================================================-
#### Slide 39: Computing correlations between variables  ####

# Create correlation plot.
corrplot(CMP_cor)


#=================================================-
#### Slide 40: Multivariate plots: correlation plot  ####

# The default method is "circle", to
# display the correlation coefficient 
# instead, use method "number".
corrplot(CMP_cor, method = "number")

# To display correlation coefficient as 
# a portion of a circle proportionate to 
# correlation coefficient use method "pie".
corrplot(CMP_cor, method = "pie")


#=================================================-
#### Slide 42: Exercise 3  ####




#=================================================-
#### Slide 51: Making a plot with `geom_histogram`  ####

# Let's create a base plot.
ggp1 = ggplot(CMP_subset,    #<-Set data
              aes(x = Yield))#<-Set aesthetics  
ggp1

# Let's add a layer.
# Each layer is called a `geom`, we need to use
# `geom_histogram` to add a histogram layer.
ggp1 + geom_histogram()


#=================================================-
#### Slide 54: Making a plot with `geom_histogram`: adjust  ####

# Say instead of frequency counts we want
# probability density estimates, we can:
ggp1 +
  # 1. Make `y-axis` of type `density`
  geom_histogram(aes(y = ..density..),
  # 2. Adjust binwidth for better smoothness.
                 binwidth = 0.75)

ggp1 = ggp1 +    #<- save adjusted plot
  geom_histogram(aes(y = ..density..),
                 binwidth = 0.75,
                 # 3. Add color & fill.
                 color = "steelblue",
                 fill = "gray")
ggp1             #<- view saved plot


#=================================================-
#### Slide 56: Making a plot with `geom_histogram`: polish  ####

ggp1 = ggp1 + 
  # Add density layer with 50% opaque fill 
  # in "steelblue" and gray color (border).
  geom_density(alpha = .5, 
               color = "gray",
               fill = "steelblue")
ggp1

ggp1  = ggp1 + 
# Add plot title and subtitle.
labs(title = "Yield Distribution",
     subtitle = "Histogram & Density")
ggp1


#=================================================-
#### Slide 57: Making a plot with `geom_histogram`: polish  ####

# Add a black and white theme to
# overwrite default.
ggp1 = ggp1 + 
  
  # Add a black and white theme.
  theme_bw() +
  
  # Customize elements of the theme.
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16),
        plot.title = element_text(size = 25),
        plot.subtitle = element_text(size = 18))

# Display polished plot.
ggp1


#=================================================-
#### Slide 59: Making a scatterplot with `geom_point`: set up  ####

# Let's create a base plot.
ggp2 = ggplot(CMP_subset,                   
              aes(x = BiologicalMaterial01,
                  y = Yield)) 
ggp2

# Let's add a layer.
# Each layer is called a `geom`, we need to use
# `geom_point` to add a histogram layer.
ggp2 = ggp2 + geom_point()
ggp2


#=================================================-
#### Slide 61: Making a scatterplot with `geom_point`  ####

ggp2 = ggp2 + 
  
  # Adjust the color of the points.
  geom_point(color = "darkorange") + 
  
  # Add linear regression line (`lm`). 
  geom_smooth(method = lm) +
  
  # Add a title and a subtitle.
  labs(title = "Bio. Material 1 vs. Yield",
       subtitle = "Scatterplot with linear fit")

# View the plot.
ggp2


#=================================================-
#### Slide 63: Saving a theme to a variable  ####

my_ggtheme = theme_bw() + 
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16),
        plot.title = element_text(size = 25),
        plot.subtitle = element_text(size = 18))

# Add saved theme and re-save the plot.
ggp2 = ggp2 + my_ggtheme
ggp2



#=================================================-
#### Slide 65: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
