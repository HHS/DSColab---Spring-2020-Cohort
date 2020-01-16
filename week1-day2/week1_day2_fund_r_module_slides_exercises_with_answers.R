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



# Answer: 
logvar = FALSE
typeof(logvar)
new_char2 = as.character(logvar)
class(new_char2)

#================================================-
#### Question 2 ####

test = 234.3

# What is the class of the `test` variable?
# What is the type of the `test` variable?
# Convert `test` to an `integer` and assign it to variable `test2`.
# Then confirm the new class of `test2`.

# Answer: numeric and double.
class(test)
typeof(test)
test2 = as.integer(test)
class(test2)


#================================================-
#### Question 3 ####

# Create a numeric vector named `numvec` that contains the values 2.3, 4, 5.63, and 4.623.
# Return the values of `numvec`.
# Convert the vector `numvec` to a vector of integers named `intvec`.
# Then confirm if the vector contains integers or not. 
# The answer should be either TRUE or FALSE.

# Answer:
numvec = c(2.3, 4, 5.63, 4.623)
numvec
intvec = as.integer(numvec)
is.integer(intvec)

#================================================-
#### Question 4 ####

# Check how many items are in `intvec`.
# Then append the values 7, 14, and 8 to the vector `intvec`.
# Check the length of intvec again. What changed?

# Answer: length increased by 3.
length(intvec)
intvec = c(intvec, 7, 14, 8)
length(intvec)

#================================================-
#### Question 5 ####

# Add the value 3 to all values in `intvec`.

# Answer:
intvec + 3

#================================================-
#### Question 6 ####

# Create another vector named `seqvec` that starts at 2, ends at 14, and the numbers increase by 2.
# What is the length of `seqvec`?
# Assign the result of subtracting `intvec` from `seqvec` to the vector `resvec`. 

# Answer: 7
seqvec = seq(from = 2, to = 14, by = 2)
length(seqvec)
resvec = seqvec - intvec
resvec

#================================================-
#### Question 7 ####

# What is the product of resvec?
# What is the minimum value in resvec?
# What is the mean of resvec?

# Answer: 0, -3, 0.7142857
prod(resvec)
min(resvec)
mean(resvec)


#================================================-
#### Question 8 ####

# Bind the vectors `intvec`, `seqvec`, and `resvec` together as columns to create `matrix_c`.
# Separately bind the vectors together as rows to create `matrix_r`.
# Confirm the class of both `matrix_c` and` matrix_r`.
# How many rows and columns are there in `matrix_c` and `matrix_r` ?

# Answer: The class for both should be "matrix".
matrix_c = cbind(intvec, seqvec, resvec) #<- cbind binds as columns
matrix_r = rbind(intvec, seqvec, resvec) #<- rbind binds as rows

class(matrix_c)
class(matrix_r)

# `matrix_c` has 7 rows and 3 columns. `matrix_r` has 3 rows and 7 columns.
dim(matrix_c)
dim(matrix_r)

#================================================-
#### Question 9 ####

# Check the type of matrix (hint: is it numeric, character, integer?)

# Answer:
is.integer(matrix_r)
is.numeric(matrix_r)

#================================================-
#### Question 10 ####

# Check the attributes of `matrix_c`. 
# Which dimension of `matrix_c` has names? Rows or columns?
# Rename the columns in `matrix_c` to be "var1", "var2", and "var3".

# Answer: columns
attributes(matrix_c)
colnames(matrix_c) = c("var1", "var2", "var3")
matrix_c


#================================================-
#### Question 11 ####

# Return a matrix that is a 2x2 subset of `matrix_c` starting at the upper left corner of `matrix_c`.
# Name this new matrix `mat_sub`.
# Confirm the class of `mat_sub`.
# What is the average value of `mat_sub`?

# Answer: 2.5
mat_sub = matrix_c[1:2, 1:2] #<- use : to create a continuous subset
class(mat_sub)
mean(mat_sub)

#================================================-
#### Question 12 ####

# Convert `matrix_c` to a data frame and name the new data frame `matrix_df`.
# When you create the data frame, assign the row names numbers 15:21.
# Confirm the work by checking the attributes of `matrix_df`.
# Then use three different ways to access the third column of `matrix_df`.


# Answer:
matrix_df = as.data.frame(matrix_c, row.names = 15:21)
attributes(matrix_df)

matrix_df$var3
matrix_df[[3]]
matrix_df[ , 3]

#================================================-
#### Question 13 ####

var4 = c("learning", "R", "studio", "is", "so", "much", "fun")

# Add var4 as a column to `matrix_df` using `cbind` function.
# Add var5 as a column to `matrix_df`, using the `$` operator, and set it equal to "constant".
# Confirm your work using attributes.
# Then return the fourth row of matrix_df using two different methods.


# Answer:
matrix_df = cbind(matrix_df, var4)
matrix_df$var5 = "constant"
attributes(matrix_df)

matrix_df[4, ]
matrix_df["18", ]

#================================================-
#### Question 14 ####

# Use `data.frame` to create a new data frame named `new_df`, from scratch, 
# using the vectors `numvec`, `intvec`, `seqvec,` `var4`, and `var5`. 
# Set the row names to be a sequnce from 23 to 26 within the `data.frame` command.
# You will get an error.
# Why can R not join those vectors into a data frame?

# Answer: columns of different lengths. 
new_df = data.frame(numvec, intvec, seqvec, var4, var5 = "constant", row.names = 22:26)

#================================================-
#### Question 15 ####

# Use length to find the vectors that are longer than 4 entries.
# Adjust the code you just wrote to use only the first four rows of the vectors that are too long.
# Remove the 'var5 =' and write only "constant".
# Check the attributes, structure, and dimensions of `new_df` to confirm your work.

# Answer:
length(numvec)
length(intvec)
length(seqvec)
length(var4)

new_df = data.frame(numvec, 
                    intvec[1:4], 
                    seqvec[1:4], 
                    var4[1:4],
                    "constant", 
                    row.names = 23:26)

attributes(new_df)
str(new_df)
dim(new_df)



#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Clear the environemnt of variables from previous exercises using `rm`, `list`, and `ls`.
# Use "?rm" to refresh your knowledge of the usage.

# Answer:
?rm
rm(list = ls())

#================================================-
#### Question 2 ####

# Check your working directory to confirm it is the same for exercises as you have used during class.
# If your working directory is not the data directory used in class, please set it now.
# What is the name of the file that starts with the letter f?

# Answer: `fast_food_data.csv`
getwd()
setwd()  #<- students answer here will be unique
# Students can look in the Files window to confirm the file name once setting the correct working directory
# Or students can check using R commands:
list.files(pattern="F")


#================================================-
#### Question 3 ####

# Use `read.csv` to read `fast_food_data.csv` into R and name it `fastfood`. 
# Set headers to TRUE and do not read in strings as factors.
# What is the class of `fastfood`?

# Answer: data frame
fastfood = read.csv("fast_food_data.csv",     #<- provide file name
                    header = TRUE,            #<- if file has header set to TRUE
                    stringsAsFactors = FALSE) #<- read strings as characters. 
class(fastfood)

#================================================-
#### Question 4 ####

# Inspect the structure, attributes, and dimensions of `fastfood`.
# How many rows and columns does fastfood have?

# Answer: 126 rows and 13 columns.
str(fastfood)
dim(fastfood)
attributes(fastfood)

#================================================-
#### Question 5 #### 

# What's the difference in protein content between the 12th and 56th observation?
# What's the type of item 12 and item 56? 
# What is the specific item of each?

# Answer: -56 difference between items. Both are Burgers. One is a bacon double cheese burger and the other is still ust "burger".
fastfood[12, 12] - fastfood[56, 12]

# multiple ways to reference specific entries.
fastfood[12, ]$Type
fastfood[56, ]$Type
fastfood[12, ]$Item
fastfood[56, ]$Item

#================================================-
#### Question 6 ####

# Create a subset of `fastfood` named `fastfood_sub` that contains rows 12:56 and the columns 
# "Fast.Food.Restaurant", "Item", "Type", "Protein..g.", and "Total.Fat..g.".
# Hint: Create a vector of column names you wish to keep.

# Answer:
keep = c("Fast.Food.Restaurant", "Item", "Type", "Protein..g.", "Total.Fat..g.")
fastfood_sub = fastfood[12:56, keep]

#================================================-
#### Question 7 ####

# Use `head` and `tail` to return only the top and last observation of `fastfood_sub`.
# Which restaurant made each burger?

# Answer: Burger King and Sonic.
head(fastfood_sub, 1)
tail(fastfood_sub, 1)

#================================================-
#### Question 8 ####

# Save `fastfood_sub` to your data directory as "fast_food_subset.csv".

# Answer: 

# Set working directory to where the data is.
setwd() #<- will vary

# Write data to a CSV file providing 3 arguments:
write.csv(fastfood_sub,            #<- name of variable to save 
          "fast_food_subset.csv", #<- name of file where to save
          row.names = FALSE)  

#================================================-
#### Question 9 ####

# Delete "fast_food_subset.csv" from your data directory.
# Answer:
# Students can manually delete the file from the File window in RStudio.
# Or students can use the following code:
file.remove("fastfood_sub.csv")


#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Create a vector of column indices named "column_keep" with columns 24:26 and 52:55.
# Subset CMP using `column_keep` to retain the specified columns in a smaller dataset named `sub_cmp`.
# Confirm the structure of `sub_cmp`. 
# How many columns are in `sub_cmp`? How many columns are integers?

# Answer: 7 columns, 1 column of integers.
column_keep = c(24:26, 52:55)
sub_cmp = CMP[ , column_keep]
str(sub_cmp)

#================================================-
#### Question 2 ####

# Summarize the variables in `sub_cmp`.
# Which variable has the most NA's?

# Answer: ManufacturingProcess11
summary(sub_cmp)

#================================================-
#### Question 3 ####

# Create a list of logical values where NA's in ManufacturingProcess11 are TRUE.
# Save this list of logical values to a variable names `also_na`.
# Use `which` to find the row indexes of the NA values and save that list of row indexes to `idofnas`.

# Answer:
also_na = is.na(sub_cmp$ManufacturingProcess11)
idsofnas = which(also_na)

#================================================-
#### Question 4 ####

# Compute the mean of the `ManufacturingProcess11` with the NAs removed.

# Answer:
mean_process11 = mean(sub_cmp$ManufacturingProcess11, na.rm = TRUE)
mean_process11

#================================================-
#### Question 5 ####

# Assign the mean to the entry(s) with the `NA` in ManufacturingProcess11.
# Check the result.

# Answer:
sub_cmp$ManufacturingProcess11[idsofnas] = mean_process11
sub_cmp$ManufacturingProcess11[idsofnas]



#### Exercise 4 ####
# =================================================-

#### Question 1 ####

temp_var = c(24, 26, 4, 12, 52, 3, 16)

# Write an `ifelse` statement that states:

# If entries in `temp_var` is greater than 15
#   Then subtract 15 from `temp_var`
# Otherwise return temp_var unchanged.

# Answer:
ifelse(temp_var > 15, temp_var - 15, temp_var)

#================================================-
#### Question 2 ####

vec1 = c(24, 26, 4, 12, 52, 3, 16)

# Find the length of `vec1` and store it a variable `vec1_len`.

# Answer:
vec1_len = length(vec1)
vec1_len

#================================================-
#### Question 3 ####

# Write the first part of the for loop for `i` from 1 to `vec1_len`, 
# with closed curly braces at the end.

# Answer:
for(i in 1:vec1_len){
  
}

#================================================-
#### Question 4 ####

# Upate the code from Question 1 to make the `ifelse` statement dynamic. 
# Replace `temp_var` with `vec1[i]`.
# Then assign `vec1[i]` to equal the output of the `ifelse` statement.

# Answer:
ifelse(vec1[i] > 15, vec1[i] - 15, vec1[i])

vec1[i] = ifelse(vec1[i] > 15, vec1[i] - 15, vec1[i])

#================================================-
#### Question 5 ####

# Combine the answers for Question 3 and Question 4 to create a completed for loop.
# Execute the code.
# What is the new value of the first entry in `vec1`?

# Answer: 9
for(i in 1:vec1_len){
  vec1[i] = ifelse(vec1[i] > 15, vec1[i] - 15, vec1[i])
}

vec1[1]

#================================================-
#### Question 6 ####


vec1 = c(24, 26, 4, 12, 52, 3, 16)

# Adjust the code from Question 5 to create a new vector, `vec2`, that 
# assigns the transformed version of `vec1` created by the for loop to `vec2` and `vec2` maintains it original value.
# Confirm that the value of the first entry in `vec1` remains the same and that the value of the first entry in `vec2` equals nine.

# Answer:
vec2 = c()

for(i in 1:vec1_len){
    vec2[i] = ifelse(vec1[i] > 15, vec1[i] - 15, vec1[i])
}

vec1[1]
vec2[1]

#================================================-
#### Question 7 ####

namelist = c("Susie", "Nick", "Kate", "Simon", "Jamal", "Eduardo")

# Create a function named `Greetings` that takes a `listofnames` as an argument.
# The function should go through a vector of names one by one, and print:

# "Welcome to coding in RStudio, NAME!" 

# Where NAME is the entry in `listofnames` vector.
# Hint: You will need to use `length`, `paste0`, `print`, and a `for` loop.

# Answer:

Greetings = function(listofnames){
  
  for(i in 1:length(listofnames)){
    
    greet_name = paste0("Welcome to coding in RStudio, ", #<- concatenate "Hello "
                        listofnames[i],                   #<-  with the `name` from function argument, and
                        "!")                              #<-  with the remainder of the message to print
    
    print(greet_name)
  }
}

#================================================-
#### Question 8 ####

# Execute `Greetings` using `namelist`.

# Answer:
Greetings(namelist)



