#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK4 DAY2 CLUSTERING MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1:  ####

# Read in the fast food dataset and assign it to `fast_food_temp`. 
# Use `head` to look at it again.

# Answer: 


#================================================-
#### Question 2 ####

# Create a dataseet named `fast_food_num` that has only the numeric variables from `fast_food_temp`.

# Answer: 


#================================================-
#### Question 3 ####

# Confirm the dimensions of fast_food_num. 
# Clean the data set of columns that are more than 5% NA (Remove such columns)
# Check the dimensions of the dataset again. 
# How many columns did you remove?

# Answer: One


#================================================-
#### Question 4 ####

# Scale fast_food_num and assign it to a new data set named `fast_food_scaled` and confirm the class of the new data set.

# Answer: 



#### Exercise 2 ####
# =================================================-

#### Question 1 ####

# Subset the scaled dataset to be just "Calories" and "Sodium..mg." as it was in the first exercise. 
# Name it "fast_food_scaled_2v".

# Answer:

#================================================-
#### Question 2 ####

# Use kmeans function on fast_food_scaled_2v with four clusters.

# Answer:


#================================================-
#### Question 3 ####

# Calculate the variance explained by k4. How much variance do these clusters explain?

# Answer:

#================================================-
#### Question 4 ####

# Caculate the explained variance using 3, 5, and 6 clusters respectively. 
# Compare the explained variance of each. 
# Based on the answers, what numbmer of clusters would you use for this analysis?

# Answer: 

#================================================-
#### Question 5 ####
# Use k4 from the last exercise using the fast food data set. 
# Convert the cluster column of k4 to a factor variable.

# Answer:

#================================================-
#### Question 6 ####

# Convert `fast_food_scaled_2v` back into a dataframe 
# so you can visualize the clusters in `ggplot`.

# Answer:

#================================================-
#### Question 7 ####

# Use and adjust the code from the class exercises, to plot the points when k = 4.

# Answer:


#================================================-
#### Question 8 ####

# Convert k4$centers to a data frame named `k4_centers`.

# Answer:

#================================================-
#### Question 9 ####

# Use and adjust the code from the class exercises to add the centers to the plot `k4_clusters`.

# Answer:



#### Exercise 3 ####
# =================================================-

#### Question 1 ####
# Apply both the "WSS method" and the "Silhouette method" to `fast_food_scaled_2v` in separate `fviz_nbclust` statements. 
# What do the silhouette method and wss suggest for the optimum number of clusters?
# Are they the same?

# Answer: 

#================================================-
#### Question 2 ####
# Use and adjust the code from the class to run `eclust` on `fast_food_scaled_2v` and set graph argument to 
# TRUE to visualize the graph using k = 2 and k = 6 respectively.

# Answer:


#================================================-
#### Question 3 ####
# Add the column of cluster labels fom k6 to the original `fast_food_temp` dataset to create a new dataset named `fast_food_temp_k6`. 
# See code from class exercises for assistance. 
# Then look at the head and the tail of `fast_food_temp_k6`.

# Answer:



#=============================================-
#### Question 4 ####

# Use and adjust the code from the exercise in class to create an object "final_k6". 
# Group the variables "Calories", "Sodium..mg.", and "Toal.Fat..g" by cluster within `fast_food_temp_k6`.
# Show their mean, min, and max.
# What is the max fat of group 4?

# Answer: 



#================================================-
#### Question 5 ####

# Create a table that shows the distribution of Type over the 6 clusters. 
# Which Type of food item maps perfectly to cluster 6?
# What Type of food is spread out across all 5 remaining groups?

# Answer



