#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK2 DAY2 STATIC VIS MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-


#### Question 1 ####

# Read the fast_food_data.csv into a dataset named "fast_food_data". 
# Set both the header and stringsAsFactors as equal to TRUE. 
# Subset the data set to be named "fast_food_subset" and include columns 3, 5, 6, 10, 11. 
# Then rename those columns "type", "calories","totfat","carbs", & "sugars".

# Answer: 

#================================================-
#### Question 2 ####

# Create a dataset named `fast_food_num`, which consists of only the numeric variables from fast_food_subset.
# Then retrieve the number of columns from `fast_food_num` and store it in the variable `num_col`.
# Sample `num_col` number of colors from `colors` and store it in `color_sam`. 
# Make sure to set the seed to 2 before sampling.
# What four colors did sample choose?

# Answer: 

#================================================-
#### Question 3 ####

# Make a boxplot of the varibles in `fast_food_num` using the colors stored in `color_sam`. 
# Which variable has the widest range?

# Answer: 

#================================================-
#### Question 4 ####

# Create a 2x2 grid of histograms of all 4 variables in `fast_food_num`, using colors in  `color_sam`.
# appropriately labeled with xlabel and title for each.

# Answer:

#### Exercise 2 ####
# =================================================-

#### Question 1 ####
# Begin with plotting total fat against carbohydrate. Have total fat be on the x-axis and carbohydrate on the y-axis.
#Please use the column index to specify the variables. Create appropriate labels for x and y axis and title.
#Fill in with triangle symbol and at scale 1 in the color "salmon2".

# Answer:

#### Question 2 ####
# Create a scatterplot matrix of all the variables in fast_food_num with symbol +.
#choose random color from colors() and set the color of the points each time the plot is generated.
# Answer:


#### Exercise 3 ####
# =================================================-


#### Question 1 ####
# To find the correlation coefficient between the variables in fast_food_num, execute `cor` on the fast_food_num data set, making sure to tell it to use columns 1:4. 
# Assign the output to a variable named "fast_food_cor".View the output of fast_food_cor. 
# What is the correlation between calories and total fat content?
# Is there a strong or weak correlation between calories and total fat content?

# Answer:


#================================================-
#### Question 2 ####
# Visualize the correlation matrix using corrplot in the three ways demoed in class.
# Use the documentation within corrplot to make another corrplot using a method we did not demo in class.
# Which two variables are the least correlated?
# Hint: use ?corrplot for assistance.

# Answer: 


#### Exercise 4 ####
# =================================================-


#### Question 1 ####
# Begin to create a the foundation of a plot by executing ggplot on fast_food_num, without any specification added yet as to what type of plot it will be.
# Set x  to equal calories. 
# Assign ggplot's output to the variable ffplot1.

# Answer:


#================================================-
#### Question 2 ####
# Specify that the plot is going to be a historgram by adding geom_histogram() to ffplot1 to see the plotted histogram.
# Answer:

#================================================-
#### Question 3 ####
# Modify the histogram within its specifications to make it a density plot, and set the binwdth to 50.
# Enhance the histogram further by setting the color tp "salmon2" and the fill color to "salmon3".
# Then save the adjusted ffplot1, by reassigning the output of ffplot + geom_histogram back to ffplot1.
# Make sure to view your plot after you save it.

# Answer:

#================================================-
#### Question 4 ####
# Create a new density plot object and add it to ffplot1. Then save ffplot1.
# Hint: ?geom_density
# Specify that the density plot should have a 20% opaque gray fill and a steelblue border.
# Make sure to view your final plot. How many layers are there on the plot?

# Answer: 

#================================================-
#### Question 5 ####
# Specify what size text you want on the plot labels by adding Add theme_bw() to ffplot1. 
# Set the axis title text to size 22 and the axis text to size 18.
# Save the theme to ff_theme.

# Answer:



#================================================-
#### Question 6 ####
# Using ggplot and geom_point(), create a scatter plot of total fat on the x axis and calories on the y and save it to ffplot2.
# Enhance the scatter plot, ffplot2, with the ff_theme.
# Then change the point color to tomato2, and add a trend line to the scatter plot.

# Answer:


