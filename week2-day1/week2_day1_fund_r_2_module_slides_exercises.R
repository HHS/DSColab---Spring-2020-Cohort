#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK2 DAY1 FUND R 2 MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

# Load the datasets we will be using for this exercise:
# (this dataset is native to R)
install.packages("babynames")
library(babynames)

#### Exercise 2 ####
# =================================================-


#### Question 1 ####
# Filter all values from `babynames` from 2015.


#================================================-
#### Question 2 ####
# Filter all values that are from 2015 and F.


#================================================-
#### Question 3 ####
#Filter all values that are below 1000 counts (`n`) and that are between 1947-1975.


#================================================-
#### Question 4 ####
# Filter all values that are either F or above 1000 counts, all from 1975.


#================================================-
#### Question 5 #### 
# Arrange `babynames` by year, starting with 2015.

#================================================-
#### Question 6 ####
# Arrange now by year then by sex. What is the name and year in row 1?


#================================================-
#### Question 7 ####
# Arrange now by sex, then by year starting with 2015, then by name decending. What name is the name in first row?




#### Exercise 3 ####
# =================================================-


#### Question 1 ####
# Select only year,name and count (`n`) from `babynames`.


#================================================-
#### Question 2 ####
# Now select the same columns, but by specifying which NOT to include in the subset.


#================================================-
#### Question 3 #### 
# Use the helper functions of `select` to find all columns that contain the letter `e`.



##### Question 4 ####
# Subset `babynames` to be all names from 2015, keep all columns, save the subset as babynames_small.


#================================================-
#### Question 5 ####
# Using the newly created subset and `mutate`, create a new column "rank" that ranks by the count (`n`). Save the new subset as `babynames_mutate`.


#================================================-
##### Question 6 ####
# Arrange the mutated dataset by rank, descending, then by name. What is the rank,name and sex in the first row?


#================================================-
#### Question 7 ####
# Now instead of the `babynames_mutate` subset, use a function that will simply create one column that gives you the rank of the counts - "RANK". Use the dataset `babynames_small`.





#### Exercise 4 ####
# =================================================-


#### Question 1 #### 
# Only using `summarise`, find the sum of `n`, name it "total_counts". You will see that is not very useful... Let's try it with `group_by`.


#================================================-
#### Question 2 ####
# Use `group_by` and `summarise` to find the sum of F and M names by year. Name the final dataframe 'summary' and the variable 'by_year'.


#================================================-
#### Question 3 ####
# Perform the same summary function, this time subsetting the data to only 2010 and later. Also, arrange the output by year, starting with 2010.
#	Use pipes this time. Name the new dataframe 'pipes'


#================================================-
# Load the datasets we will be using for the following questions:
# (this dataset is native to R)

data(USPersonalExpenditure)

##### Question 4 ####
# What is the class of the data we just loaded?


#================================================-
#### Question 5 ####
# Change this to a tibble, so we can begin to turn it into tidy data. Make sure to include the current row.names as a column. Name that column `areas_of_expense`.


#================================================-
#### Question 6 ####
# Use `gather` to convert this data to `tidy` format. There should be two new columns, you can decide on names based on what these columns will contain. Save the gathered tibble as `gathered`.


#================================================-
#### Question 7 ####
# Use `spread` to convert the tibble back to its original state.



#================================================-
# For the following questions, we are going to create a dataframe for the purpose of using `separate` and `unite`

date = as.Date('2016-01-01') + 0:14
hour = sample(1:24, 15)
min = sample(1:60, 15)
second = sample(1:60, 15)
event = sample(letters, 15)
data = tibble(date, hour, min, second, event)

#================================================-
#### Question 8 ####
# Let us unite the date, hour, minute and second. Name this new dataset - `data_unite`.


#================================================-
#### Question 9 ####
# Let us now separate the `data_unite` into these columns: year, month, day, time, event.




