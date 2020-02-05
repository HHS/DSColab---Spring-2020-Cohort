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
fast_food_temp = read.csv("fast_food_data.csv")
head(fast_food_temp)

#================================================-
#### Question 2 ####

# Create a dataseet named `fast_food_num` that has only the numeric variables from `fast_food_temp`.

# Answer: 
fast_food_num = fast_food_temp[sapply(fast_food_temp, is.numeric)]
head(fast_food_num)

#================================================-
#### Question 3 ####

# Confirm the dimensions of fast_food_num. 
# Clean the data set of columns that are more than 5% NA (Remove such columns)
# Check the dimensions of the dataset again. 
# How many columns did you remove?

# Answer: One

dim(fast_food_num)

fast_food_num = fast_food_num[, colMeans(is.na(fast_food_num)) <= .05]

dim(fast_food_num)

#================================================-
#### Question 4 ####

# Scale fast_food_num and assign it to a new data set named `fast_food_scaled` and confirm the class of the new data set.

# Answer: 
fast_food_scaled = scale(fast_food_num)

head(fast_food_scaled)

class(fast_food_scaled)


#### Exercise 2 ####
# =================================================-

#### Question 1 ####

# Subset the scaled dataset to be just "Calories" and "Sodium..mg." as it was in the first exercise. 
# Name it "fast_food_scaled_2v".

# Answer:
fast_food_scaled_2v = fast_food_scaled[ , c("Calories", "Sodium..mg.")]

#================================================-
#### Question 2 ####

# Use kmeans function on fast_food_scaled_2v with four clusters.

# Answer:
k4 = kmeans(fast_food_scaled_2v, centers = 4)
k4

#================================================-
#### Question 3 ####

# Calculate the variance explained by k4. How much variance do these clusters explain?

# Answer: ~ 81.9%
ex_var = k4$betweenss/k4$totss
ex_var

#================================================-
#### Question 4 ####

# Caculate the explained variance using 3, 5, and 6 clusters respectively. 
# Compare the explained variance of each. 
# Based on the answers, what numbmer of clusters would you use for this analysis?

# Answer: 6 clusters
k3 = kmeans(fast_food_scaled_2v, centers = 3)
k3

ex_var3 = k3$betweenss/k3$totss
ex_var3

k5 = kmeans(fast_food_scaled_2v, centers = 5)
k5

ex_var5 = k5$betweenss/k5$totss
ex_var5

k6 = kmeans(fast_food_scaled_2v, centers = 6)
k6

ex_var6 = k6$betweenss/k6$totss
ex_var6

#================================================-
#### Question 5 ####
# Use k4 from the last exercise using the fast food data set. 
# Convert the cluster column of k4 to a factor variable.

# Answer:
k4$cluster = as.factor(k4$cluster)

#================================================-
#### Question 6 ####

# Convert `fast_food_scaled_2v` back into a dataframe 
# so you can visualize the clusters in `ggplot`.

# Answer:
fast_food_scaled_2v = as.data.frame(fast_food_scaled_2v)

#================================================-
#### Question 7 ####

# Use and adjust the code from the class exercises, to plot the points when k = 4.

# Answer:
k4_clusters = ggplot(fast_food_scaled_2v, 
                     aes(Sodium..mg., Calories, color = k4$cluster)) + 
  geom_point() 
k4_clusters

#================================================-
#### Question 8 ####

# Convert k4$centers to a data frame named `k4_centers`.

# Answer:
k4_centers = as.data.frame(k4$centers)

#================================================-
#### Question 9 ####

# Use and adjust the code from the class exercises to add the centers to the plot `k4_clusters`.

# Answer:
k4_clusters + geom_point(data = k4_centers, 
                         aes(Sodium..mg., Calories), 
                         size = 7, 
                         color = "black", 
                         shape="o")


#### Exercise 3 ####
# =================================================-

#### Question 1 ####
# Apply both the "WSS method" and the "Silhouette method" to `fast_food_scaled_2v` in separate `fviz_nbclust` statements. 
# What do the silhouette method and wss suggest for the optimum number of clusters?
# Are they the same?

# Answer: Not the same. Silhouette = 2, wws is anywhere from 4-6 clusters.
fviz_nbclust(fast_food_scaled_2v, 
             kmeans, 
             method = "wss") +
  labs(subtitle = "WSS method")

fviz_nbclust(fast_food_scaled_2v, 
             kmeans, 
             method = "silhouette") +
  labs(subtitle = "Silhouette method")

#================================================-
#### Question 2 ####
# Use and adjust the code from the class to run `eclust` on `fast_food_scaled_2v` and set graph argument to 
# TRUE to visualize the graph using k = 2 and k = 6 respectively.

# Answer:
eclust(fast_food_scaled_2v, "kmeans", k = 6, nstart = 25, graph = TRUE)

eclust(fast_food_scaled_2v, "kmeans", k = 2, nstart = 25, graph = TRUE)

#================================================-
#### Question 3 ####
# Add the column of cluster labels fom k6 to the original `fast_food_temp` dataset to create a new dataset named `fast_food_temp_k6`. 
# See code from class exercises for assistance. 
# Then look at the head and the tail of `fast_food_temp_k6`.

# Answer:
fast_food_temp_k6 = cbind(fast_food_temp, 
                          k6$cluster)

head(fast_food_temp_k6 )

tail(fast_food_temp_k6 )
#=============================================-
#### Question 4 ####

# Use and adjust the code from the exercise in class to create an object "final_k6". 
# Group the variables "Calories", "Sodium..mg.", and "Toal.Fat..g" by cluster within `fast_food_temp_k6`.
# Show their mean, min, and max.
# What is the max fat of group 4?

# Answer: 30
final_k6 = fast_food_temp_k6 %>%           #<- incorporate cluster numbers
  group_by(k6$cluster) %>%                   #<- group by cluster number
  summarise(mean_calories = mean(Calories),  #<- mean calories across cluster number
            mean_sodium = mean(Sodium..mg.), #<- mean sodium across cluster number
            mean_fat = mean(Total.Fat..g.),  #<- mean total fat across cluster number
            max_calories = max(Calories),    #<- max calories across cluster number
            max_sodium = max(Sodium..mg.),   #<- max sodium across cluster number
            max_fat = max(Total.Fat..g.),    #<- max total fat across cluster number
            min_calories = min(Calories),    #<- min calories across cluster number
            min_sodium = min(Sodium..mg.),   #<- min sodium across cluster number
            min_fat = min(Total.Fat..g.),    #<- min total fat across cluster number
            n())  

final_k6 
#================================================-
#### Question 5 ####

# Create a table that shows the distribution of Type over the 6 clusters. 
# Which Type of food item maps perfectly to cluster 6?
# What Type of food is spread out across all 5 remaining groups?

# Answer
mytable = table(fast_food_temp_k6$`k6$cluster`, fast_food_temp_k6$Type)
mytable


