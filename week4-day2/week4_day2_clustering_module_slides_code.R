#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK4 DAY2 CLUSTERING MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 2: Loading the packages  ####

# This removes scientific notation. 
# It is helpful to keep all numbers formatted similarly.
options(scipen = 999)

# Load libraries.
library(caret)
library(ggplot2)
library(tidyverse)
# install.packages("factoextra")
library(factoextra)



#=================================================-
#### Slide 9: K-means: loading temp heart rate data  ####

# Set working directory to folder where we have our datasets.
setwd(data_dir)

# Read the data we will be working with from a CSV file.
temp_heart = read.csv("temp_heart_rate.csv")

# View the first few entries in the dataset.
head(temp_heart)


#=================================================-
#### Slide 13: K-means data prep:  remove labels  ####

# We are removing the Male/Female labels, or the first column. 
# Let's name the new dataset `temp_heart_cluster`
temp_heart_cluster = temp_heart[ ,2:3]
head(temp_heart_cluster)


#=================================================-
#### Slide 14: K-means data prep:  clean NAs  ####

# Compute means of NAs in columns.
NA_cols = colMeans(is.na(temp_heart_cluster))
NA_cols
# Keep all the columns where the mean of NAs in 
# that column is less than or equal to 50%.
temp_heart_cluster = temp_heart_cluster[ , NA_cols <= 0.5]
dim(temp_heart_cluster)


#=================================================-
#### Slide 15: K-means data prep: numeric variables  ####

# Check whether columns in data are numeric.
is_numeric = sapply(temp_heart_cluster, is.numeric)
is_numeric

# Identifying numeric variables
numeric_data = temp_heart_cluster[is_numeric]
head(numeric_data,2)

dim(numeric_data)


#=================================================-
#### Slide 18: K-means data prep: scale the data  ####

# Scale the data.
temp_heart_scaled = scale(temp_heart_cluster)

# Inspect scaled values.
head(temp_heart_scaled)

# We can see, the new object is a matrix.
class(temp_heart_scaled)


#=================================================-
#### Slide 20: Exercise 1  ####




#=================================================-
#### Slide 27: K-means: kmeans with k=2  ####

# Set random seed to get 
# reproducible results.
set.seed(1)

# Run `kmeans` on `temp_heart_scaled` 
# data with k = 2.
k2 = kmeans(temp_heart_scaled, 
            centers = 2)


#=================================================-
#### Slide 28: K-means: kmeans output  ####

# View kmeans output.
k2


#=================================================-
#### Slide 29: K-means: kmeans attributes  ####

# View kmeans object attributes
attributes(k2)


#=================================================-
#### Slide 34: K-means: evaluate explained variance  ####

# To calculate amount of explained variance divide 
# Inter-cluster distance (i.e. between cluster 
# sum of squares) by Total sum of squares.
ex_var = k2$betweenss/k2$totss
ex_var


#=================================================-
#### Slide 36: K-means: visualize clusters theme  ####

# Save our custom `ggplot` theme to a variable.
my_ggtheme = theme_bw() +                     
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16),
        legend.text = element_text(size = 16),              
        legend.title = element_text(size = 18),             
        plot.title = element_text(size = 25),               
        plot.subtitle = element_text(size = 18))          
# In case you ever wondered what is a theme or a `ggplot` object, well, 
# it's just a big nested list!
str(my_ggtheme)


#=================================================-
#### Slide 37: K-means: visualize 2D data  ####

# Change the cluster component of kmeans object to a factor,
# because `ggplot` likes factors for distinction between
# groups of observations.
k2$cluster = as.factor(k2$cluster)

# Convert scaled dataset to a data frame, because `ggplot`
# works well with data frames.
temp_heart_scaled = as.data.frame(temp_heart_scaled)

# Use `cluster` component from kmeans output to color the points 
# based on which cluster they belong to.
k2_clusters = ggplot(temp_heart_scaled,     #<- set data
                     aes(x = Body.Temp,     #<- map body temp to x-axis
                         y = Heart.Rate,    #<- map heart rate to y-axis    
                     color = k2$cluster)) + #<- color points by cluster number
  geom_point() +                            #<- use  `geom_point` to create a scatterplot
  my_ggtheme


#=================================================-
#### Slide 38: K-means: visualize heart rate & temp  ####

k2_clusters

# Let's save the centers as a dataframe and 
# add them to the existing `clusters` plot.
k2_centers = as.data.frame(k2$centers)
k2_centers


#=================================================-
#### Slide 39: K-means: save visualization   ####

# Save plot with added centroids.
k2_clusters = k2_clusters +           
  geom_point(data = k2_centers,   #<- set data
             aes(x = Body.Temp,   #<- map temp
                 y = Heart.Rate), #<- map rate
             size = 7,            #<- set size
             color = "black",     #<- set color
             shape = "o")         #<- set shape

k2_clusters


#=================================================-
#### Slide 41: Exercise 2  ####




#=================================================-
#### Slide 46: K-means: plots to optimize k  ####

# Set random seed to get reproducible results.
set.seed(1)

# Create WSS "elbow plot".
fviz_nbclust(temp_heart_scaled, 
             kmeans, 
             method = "wss") +
  labs(subtitle = "WSS method")

# Set random seed to get reproducible results.
set.seed(1)

# Create silhouette plot.
fviz_nbclust(temp_heart_scaled, 
             kmeans, 
             method = "silhouette") +
  labs(subtitle = "Silhouette method")


#=================================================-
#### Slide 50: K-means: testing out alternate values of k  ####

# Set random seed to get reproduceable results.
set.seed(1)

# Run `kmeans` using `eclust` function and set k = 2.
km_2 = eclust(temp_heart_scaled, #<- scaled and numeric dataframe
              "kmeans",          #<- clustering method
              k = 2,             #<- optimal number of clusters: k = 2
              graph = FALSE)     #<- don't graph the output just yet

# Run `kmeans` using `eclust` function and set k = 3.
km_3 = eclust(temp_heart_scaled, #<- ...
              "kmeans",          #<- ...
              k = 3,             #<- optimal number of clusters: k = 3
              graph = FALSE)     #<- ...


#=================================================-
#### Slide 51: K-means: visualize clusters  ####

# Plot results of `kmeans` with k = 2.
fviz_cluster(km_2) + #<- visualization function
  # Add title just like with ggplot.
  labs(title = "Cluster plot for k = 2") +
  # Add theme just like with ggplot.
  my_ggtheme         

# Plot results of `kmeans` with k = 3.
fviz_cluster(km_3) + #<- visualization function
  # Add title just like with ggplot.
  labs(title = "Cluster plot for k = 3") +
  # Add theme just like with ggplot.
  my_ggtheme         


#=================================================-
#### Slide 54: K-means: compare clusters to labels  ####

# Bind cluster labels with original data.
temp_heart_cluster_k2 = cbind(temp_heart,  #<- data
                              km_2$cluster)#<- labels

head(temp_heart_cluster_k2,2)

tail(temp_heart_cluster_k2,2)


#=================================================-
#### Slide 55: K-means: analyze clusters  ####

final_k2 = temp_heart_cluster_k2 %>%            #<- incorporate cluster numbers
  group_by(km_2$cluster,Gender) %>%             #<- group by cluster number and gender
  summarise(mean_temp = mean(Body.Temp),        #<- mean temp across gender and cluster number
            mean_heart_rate = mean(Heart.Rate), #<- mean heart rate across gender and cluster number
            max_temp = max(Body.Temp),          #<- max temp across gender and cluster number
            max_heart_rate = max(Heart.Rate),   #<- max heart rate across gender and cluster number
            min_temp = min(Body.Temp),          #<- min temp across gender and cluster number
            min_heart_rate = min(Heart.Rate),   #<- heart rate across gender and cluster number
            n())                                #<- get the count of each



#=================================================-
#### Slide 56: K-means: analyze clusters  ####

final_k2


#=================================================-
#### Slide 59: Exercise 3  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
