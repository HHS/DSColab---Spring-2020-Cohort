#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK1 DAY2 FUND R MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####

# Create logical variable named logvar and assign it the value FALSE.
# Confirm the type of variable for logvar.
# Then convert the locgial variable to a character variable named `new_char2`.
# Check the value of the new variable in the Global Environment. 
# Then confim the class of the new variable.


#================================================-
#### Question 2 ####

test = 234.3

# What is the class of the `test` variable?
# What is the type of the `test` variable?
# Convert `test` to an `integer` and assign it to variable `test2`.
# Then confirm the new class of `test2`.


==============================================-
#### Question 3 ####

# Create a numeric vector named `numvec` that contains the values 2.3, 4, 5.63, and 4.623.
# Return the values of `numvec`.
# Convert the vector `numvec` to a vector of integers named `intvec`.
# Then confirm if the vector contains integers or not. 
# The answer should be either TRUE or FALSE.


#================================================-
#### Question 4 ####

# Check how many items are in `intvec`.
# Then append the values 7, 14, and 8 to the vector `intvec`.
# Check the length of intvec again. What changed?


#================================================-
#### Question 5 ####

# Add the value 3 to all values in `intvec`.


#================================================-
#### Question 6 ####

# Create another vector named `seqvec` that starts at 2, ends at 14, and the numbers increase by 2.
# What is the length of `seqvec`?
# Assign the result of subtracting `intvec` from `seqvec` to the vector `resvec`. 


#================================================-
#### Question 7 ####

# What is the product of resvec?
# What is the minimum value in resvec?
# What is the mean of resvec?


#================================================-
#### Question 8 ####

# Bind the vectors `intvec`, `seqvec`, and `resvec` together as columns to create `matrix_c`.
# Separately bind the vectors together as rows to create `matrix_r`.
# Confirm the class of both `matrix_c` and` matrix_r`.
# How many rows and columns are there in `matrix_c` and `matrix_r` ?


#================================================-
#### Question 9 ####

# Check the type of matrix (hint: is it numeric, character, integer?)


#================================================-
#### Question 10 ####

# Check the attributes of `matrix_c`. 
# Which dimension of `matrix_c` has names? Rows or columns?
# Rename the columns in `matrix_c` to be "var1", "var2", and "var3".



#================================================-
#### Question 11 ####

# Return a matrix that is a 2x2 subset of `matrix_c` starting at the upper left corner of `matrix_c`.
# Name this new matrix `mat_sub`.
# Confirm the class of `mat_sub`.
# What is the average value of `mat_sub`?


#================================================-
#### Question 12 ####

# Convert `matrix_c` to a data frame and name the new data frame `matrix_df`.
# When you create the data frame, assign the row names numbers 15:21.
# Confirm the work by checking the attributes of `matrix_df`.
# Then use three different ways to access the third column of `matrix_df`.



#================================================-
#### Question 13 ####

var4 = c("learning", "R", "studio", "is", "so", "much", "fun")

# Add var4 as a column to `matrix_df` using `cbind` function.
# Add var5 as a column to `matrix_df`, using the `$` operator, and set it equal to "constant".
# Confirm your work using attributes.
# Then return the fourth row of matrix_df using two different methods.


#================================================-
#### Question 14 ####

# Use `data.frame` to create a new data frame named `new_df`, from scratch, 
# using the vectors `numvec`, `intvec`, `seqvec,` `var4`, and `var5`. 
# Set the row names to be a sequnce from 23 to 26 within the `data.frame` command.
# You will get an error.
# Why can R not join those vectors into a data frame?


#================================================-
#### Question 15 ####

# Use length to find the vectors that are longer than 4 entries.
# Adjust the code you just wrote to use only the first four rows of the vectors that are too long.
# Remove the 'var5 =' and write only "constant".
# Check the attributes, structure, and dimensions of `new_df` to confirm your work.





#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Clear the environemnt of variables from previous exercises using `rm`, `list`, and `ls`.
# Use "?rm" to refresh your knowledge of the usage.


#================================================-
#### Question 2 ####

# Check your working directory to confirm it is the same for exercises as you have used during class.
# If your working directory is not the data directory used in class, please set it now.
# What is the name of the file that starts with the letter f?



#================================================-
#### Question 3 ####

# Use `read.csv` to read `fast_food_data.csv` into R and name it `fastfood`. 
# Set headers to TRUE and do not read in strings as factors.
# What is the class of `fastfood`?



#================================================-
#### Question 4 ####

# Inspect the structure, attributes, and dimensions of `fastfood`.
# How many rows and columns does fastfood have?


#================================================-
#### Question 5 #### 

# What's the difference in protein content between the 12th and 56th observation?
# What's the type of item 12 and item 56? 
# What is the specific item of each?



#================================================-
#### Question 6 ####

# Create a subset of `fastfood` named `fastfood_sub` that contains rows 12:56 and the columns 
# "Fast.Food.Restaurant", "Item", "Type", "Protein..g.", and "Total.Fat..g.".
# Hint: Create a vector of column names you wish to keep.



#================================================-
#### Question 7 ####

# Use `head` and `tail` to return only the top and last observation of `fastfood_sub`.
# Which restaurant made each burger?


#================================================-
#### Question 8 ####

# Save `fastfood_sub` to your data directory as "fast_food_subset.csv".


#================================================-
#### Question 9 ####

# Delete "fast_food_subset.csv" from your data directory.


#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Create a vector of column indices named "column_keep" with columns 24:26 and 52:55.
# Subset CMP using `column_keep` to retain the specified columns in a smaller dataset named `sub_cmp`.
# Confirm the structure of `sub_cmp`. 
# How many columns are in `sub_cmp`? How many columns are integers?



#================================================-
#### Question 2 ####

# Summarize the variables in `sub_cmp`.
# Which variable has the most NA's?



#================================================-
#### Question 3 ####

# Create a list of logical values where NA's in ManufacturingProcess11 are TRUE.
# Save this list of logical values to a variable names `also_na`.
# Use `which` to find the row indexes of the NA values and save that list of row indexes to `idofnas`.


#================================================-
#### Question 4 ####

# Compute the mean of the `ManufacturingProcess11` with the NAs removed.



#================================================-
#### Question 5 ####

# Assign the mean to the entry(s) with the `NA` in ManufacturingProcess11.
# Check the result.




#### Exercise 4 ####
# =================================================-

#### Question 1 ####

temp_var = c(24, 26, 4, 12, 52, 3, 16)

# Write an `ifelse` statement that states:

# If entries in `temp_var` is greater than 15
#   Then subtract 15 from `temp_var`
# Otherwise return temp_var unchanged.



#================================================-
#### Question 2 ####

vec1 = c(24, 26, 4, 12, 52, 3, 16)

# Find the length of `vec1` and store it a variable `vec1_len`.


#================================================-
#### Question 3 ####

# Write the first part of the for loop for `i` from 1 to `vec1_len`, 
# with closed curly braces at the end.


#================================================-
#### Question 4 ####

# Upate the code from Question 1 to make the `ifelse` statement dynamic. 
# Replace `temp_var` with `vec1[i]`.
# Then assign `vec1[i]` to equal the output of the `ifelse` statement.



#================================================-
#### Question 5 ####

# Combine the answers for Question 3 and Question 4 to create a completed for loop.
# Execute the code.
# What is the new value of the first entry in `vec1`?



#================================================-
#### Question 6 ####


vec1 = c(24, 26, 4, 12, 52, 3, 16)

# Adjust the code from Question 5 to create a new vector, `vec2`, that 
# assigns the transformed version of `vec1` created by the for loop to `vec2` and `vec2` maintains it original value.
# Confirm that the value of the first entry in `vec1` remains the same and that the value of the first entry in `vec2` equals nine.



#================================================-
#### Question 7 ####

namelist = c("Susie", "Nick", "Kate", "Simon", "Jamal", "Eduardo")

# Create a function named `Greetings` that takes a `listofnames` as an argument.
# The function should go through a vector of names one by one, and print:

# "Welcome to coding in RStudio, NAME!" 

# Where NAME is the entry in `listofnames` vector.
# Hint: You will need to use `length`, `paste0`, `print`, and a `for` loop.



#================================================-
#### Question 8 ####

# Execute `Greetings` using `namelist`.




