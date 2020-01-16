#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK1 DAY2 FUND R MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 5: Basic data classes: integer  ####

# Create an integer type variable.
integer_var = 234L

# Check type of variable.
typeof(integer_var)

# Check if the variable is integer.
is.integer(integer_var)

# Check length of variable 
# (i.e. how many entries).
length(integer_var)


#=================================================-
#### Slide 6: Basic data classes: numeric  ####

# Create a numeric class variable.
numeric_var = 24.24
typeof(numeric_var)
# Check length of variable 
# (i.e. how many entries).
length(numeric_var)


#=================================================-
#### Slide 7: Basic data classes: character  ####

# Create a character class variable.
character_var = "Hello"
# Check if the variable is character.
is.character(character_var)

# Check metadata/attributes of variable.
attributes(character_var)

# Check length of variable 
# (i.e. how many entries).
length(character_var)


#=================================================-
#### Slide 8: Some useful character operations  ####

# Create another character class variable.
case_study = "JUmbLEd CaSE"

# Convert a character string to lower case.
tolower(case_study)

# Convert a character string to upper case.
toupper(case_study)

# Count number of characters in a string.
nchar(case_study)

# Compare to the output of the `length` command.
length(case_study)

# Get just a part of character string.
substr(case_study, #<- original string
       1,          #<- start index of substring
       7)          #<- end index of substring


#=================================================-
#### Slide 9: Basic data classes: logical  ####

# Create a logical class variable.
logical_var = TRUE

# Check type of variable.
typeof(logical_var)



#=================================================-
#### Slide 13: Basic data structures: atomic vectors  ####

# To make an empty vector in R, 
# you have a few options:
# Option 1: use `vector()` command.
# The default in R is an empty vector of 
# `logical` mode!
vector()

# Option 2: use `c()` command 
# (`c` stands for concatenate).
# The default empty vector produced by `c()` 
# has a single entry `NULL`!
c()

# Make a vector from a set of char. strings
c("My", "name", "is", "Vector")

# Make a vector out of given set of numbers
c(1, 2, 3, 765, -986, 0.5)


#=================================================-
#### Slide 14: Basic data structures: atomic vectors  ####

# Create a vector of mode `character` from 
# pre-defined set of character strings.
character_vec = c("My", "name", "is", "Vector")
character_vec

# Check if the variable is character.
is.character(character_vec)

# Check metadata/attributes of variable.
attributes(character_vec)

# Check length of variable 
# (i.e. how many entries).
length(character_vec)


#=================================================-
#### Slide 15: Basic data structures: access vectors values  ####

# To access an element inside of the
# vector use `[]` and the index of the element.
character_vec[1]

# To access multiple elements inside of
# a vector use the start and end indices
# with `:` in-between.
character_vec[1:3]

# A special form of a vector in R is a sequence.
number_seq = seq(from = 1, to = 5, by = 1)
number_seq

# Check class.
class(number_seq)

# Subset the first 3 elements.
number_seq[1:3]


#=================================================-
#### Slide 16: Basic data structures: operations on vectors  ####

number_seq      #<- Let's take our vector.


number_seq + 5  #<- Add a number to every entry.


number_seq - 5  #<- Subtract a number from every entry.


number_seq * 2  #<- Multiply every entry by a number.

# To sum all elements use `sum`.
sum(number_seq)

# To multiply all elements use `prod`.
prod(number_seq)

# To get the mean of all vector 
# values use `mean`.
mean(number_seq)

# To get the smallest value
# in a vector use `min`.
min(number_seq)



#=================================================-
#### Slide 17: Basic data structures: appending & naming  ####

# To name each entry in a vector use `names`.
names(number_seq) = c("First", "Second", 
                      "Third", "Fourth", 
                      "Fifth")

# Check the attributes of vector.
attributes(number_seq)

# Check the length of vector.
length(number_seq)
# To append elements to a vector, just
# wrap the vector and additional element(s)
# into `c` again!
character_vec = c(character_vec, "!")
character_vec


#=================================================-
#### Slide 18: Basic data structures: why ATOMIC vectors?  ####

# Create a vector with entries of different type.
atomic_vec = c(333, "some text", TRUE, NULL)
atomic_vec

# Check class of the resulting vector.
class(atomic_vec)


#=================================================-
#### Slide 20: Basic data structures: making matrices  ####

# Create a matrix with 3 rows and 3 columns.
sample_matrix1 = matrix(nrow = 3, #<- n rows
                        ncol = 3) #<- m cols
sample_matrix1

# Notice that by default an empty matrix 
# will be filled with `NA`s.

# Check matrix dimensions.
dim(sample_matrix1)

# Notice that the `length` command will produce
# the total number elements in the matrix 
# (length = n rows x m cols).
length(sample_matrix1)

# Another way to create a matrix is to make
# it out of a vector of numbers.
sample_matrix2 = 1:9 #<- another way to make
                     #   a sequence of numbers!

# Assign dimensions to matrix:
# 1st number is for rows, 2nd is for columns.
dim(sample_matrix2) = c(3, #<- n rows
                        3) #<- m cols

sample_matrix2

# Check matrix dimensions.
dim(sample_matrix1)


#=================================================-
#### Slide 21: Basic data structures: making matrices  ####

# Create a matrix from a sequence of numbers
# with 3 rows & 3 columns.
sample_matrix3 = matrix(1:9,      #<- entries
                        nrow = 3, #<- n rows
                        ncol = 3) #<- m cols
sample_matrix3

# Create a matrix from a sequence of numbers
# with 3 rows & 3 columns arranged by row.
sample_matrix4 = matrix(1:9, 
                        nrow = 3, 
                        ncol = 3,
                        byrow = TRUE)
sample_matrix4


#=================================================-
#### Slide 22: Basic data structures: working with matrices  ####

# Check type of variable.
typeof(sample_matrix4)

# Check class of variable.
class(sample_matrix4)

# Check if the variable of type `integer`.
is.integer(sample_matrix4)

# Check metadata/attributes of variable.
attributes(sample_matrix4)


#=================================================-
#### Slide 23: Basic data structures: working with matrices  ####

# To append rows to a matrix, use `rbind`.
new_matrix1 = rbind(sample_matrix4,
                    10:12)
new_matrix1

# To append columns to a matrix, use `cbind`.
new_matrix2 = cbind(sample_matrix3,
                    10:12)
new_matrix2

# To access an element of a matrix use
# the row and column indices separated
# by a comma inside of `[]`.
new_matrix1[1, 2] #<- element in row 1, col 2

# To access a row leave the space in
# column index empty.
new_matrix1[1 , ] 

# To access a column leave the space in
# row index empty.
new_matrix1[ , 2] 


#=================================================-
#### Slide 24: Basic data structures: operations on matrices  ####

# Let's take a sample matrix.
sample_matrix2

# Add a number to every entry.
sample_matrix2 + 5

# Multiply every entry by a number.
sample_matrix2 * 2

# To sum all elements use `sum`.
sum(sample_matrix2)

# To multiply all elements use `prod`.
prod(sample_matrix2)

# To get the mean of all matrix 
# values use `mean`.
mean(sample_matrix2)

# To get the smallest value
# in a matrix use `min`.
min(sample_matrix2)



#=================================================-
#### Slide 25: Basic data structures: names & attributes  ####

# To name columns of a matrix use `colnames`.
colnames(sample_matrix2) = c("Col1", "Col2", "Col3")

# To name rows of a matrix use `rownames`.
rownames(sample_matrix2) = c("Row1", "Row2", "Row3")
sample_matrix2

# Check the attributes of a matrix.
attributes(sample_matrix2)


#=================================================-
#### Slide 27: Basic data structures: lists  ####

# To make an empty list in R, 
# you have a few options:
# Option 1: use `list()` command.
list()

# Make a list with different entries.
sample_list = list(1, "am", TRUE)
sample_list


#=================================================-
#### Slide 28: Basic data structures: naming list elements  ####

# Create a named list.
sample_list_named = list(One = 1, 
                         Two = "am", 
                         Three = TRUE)
sample_list_named

attributes(sample_list_named)

# Name existing list.
names(sample_list) = c("One", "Two", "Three")
sample_list

attributes(sample_list)


#=================================================-
#### Slide 29: Basic data structures: introducing structure  ####

# Inspect the list's structure.
str(sample_list)



#=================================================  -
#### Slide 30: Basic data structures: accessing data within lists  ####

# Access an element of a list.
sample_list[[2]] 

# Access a sub-list with its element(s).
sample_list[2]

# Access a sub-list with its element(s).
sample_list[2:3]

# Access named list elements.
sample_list$One
sample_list$Two
sample_list$Three


#=================================================-
#### Slide 32: Basic data structures: making data frames  ####

# To make an empty data frame in R, 
# use `data.frame()` command.
data.frame()

# To make a data frame with several
# columns, pass column values
# to `data.frame()` command just like
# you would do with lists.
data.frame(1:5, 6:10)



#================================================= -
#### Slide 33: Data frames: naming columns  ####

# Data frane with unnamed columns.
unnamed_df = data.frame(1:3, 4:6)
unnamed_df

# Name columns of a data frame.
colnames(unnamed_df) = c("col1", "col2")
unnamed_df

# Pass column names and values to 
# `data.frame` command just like you 
# would do with named lists.
named_df = data.frame(col1 = 1:3, col2 = 4:6)
named_df



#=================================================-
#### Slide 34: Data frames: naming rows  ####

# View data frame.
named_df

# Rename data frame rows.
rownames(named_df) = c(7:9)
named_df

# Define row names explicitely, 
# use a `row.names` argument.
data.frame(col1 = 1:3, 
           col2 = 4:6, 
           row.names = 7:9)


#=================================================-
#### Slide 35: Data frames: converting a matrix  ####

# Make a data frame from matrix.
sample_df1 = as.data.frame(sample_matrix1)
sample_df1

# Make a data frame from matrix with named columns and rows.
sample_df2 = as.data.frame(sample_matrix2)
sample_df2



#=================================================-
#### Slide 36: Data frames: row and column names of a data frame  ####

# Check attributes of a data frame.
attributes(sample_df1)

# Check the attributes of data frame.
attributes(sample_df2)


#=================================================-
#### Slide 37: Data frames: selecting columns  ####

# To access a column of a data frame
# Option 1: Use `$column_name`.
sample_df2$Col1

# To access a column of a data frame
# Option 2: Use `[[column_index]]`.
sample_df2[[1]]

# To access a column of a data frame
# Option 3: Use `[ , column_index]`.
sample_df2[, 1]


#=================================================-
#### Slide 38: Data frames: subsetting rows  ####

# To access a row of a data frame
# Option 1: use `[row_index, ]`.
sample_df2[1, ]

# To access a row of a data frame
# Option 2: use `["row_name", ]`.
sample_df2["Row1", ]


#=================================================-
#### Slide 39: Data frames: accessing individual values  ####

# Option 1: 
# `data_frame$column_name[row_index]`
sample_df2$Col2[1]

# Option 2:
# `data_frame[[column_index]][row_index]`
sample_df2[[2]][1]

# Option 3: 
# `data_frame[row_index, column_index]`
sample_df2[1, 2]

# Option 4:
# `data_frame["row_name", "column_name"]`
sample_df2["Row1", "Col2"]


#=================================================-
#### Slide 40: Data frames: adding new columns  ####

# To add a new column to a data frame
# Option 1: use `$new_column_name`.
sample_df2$Col4 = "New column"
sample_df2
# To add new column(s) to a data frame
# Option 2: use `cbind`.
sample_df2 = cbind(sample_df2,
                   Col5 = c("Yet another",
                            "new",
                            "column"))



#=================================================-
#### Slide 41: Data frames: operations  ####

# Let's take our sample data frame.
str(sample_df2)

# Add a number to each value in a column.
sample_df2$Col1 + 2



#=================================================-
#### Slide 42: Special classes: factors  ####

# Let's take a look at the structure of the data frame.
str(sample_df2)



#=================================================-
#### Slide 43: Special classes: dates  ####

# Let's make a data frame.
special_data = data.frame(date_col1 = c("2018-01-01", #<- make a column with character strings
                                        "2018-02-01", #   in the format of date (YYYY-MM-DD)
                                        "2018-03-01"),
                          stringsAsFactors = FALSE)   #<- this option allows us to tell R 
                                                      #   to NOT interpret strings as `factors`
special_data

# Take a look at the structure.
# Notice both columns appear as `character` and not as `factor`.
str(special_data)



#=================================================-
#### Slide 44: Special classes: dates and basic formats  ####

# Let's make another vector with dates, but in 
# a different format.
new_dates = c("January 1, 2018",
              "February 1, 2018",
              "March 1, 2018")

# Let's add another column to the data frame
# and save it as a Date with a special format.
special_data$date_col2 = as.Date(new_dates, 
                         format = "%B %d, %Y")
special_data



#=================================================-
#### Slide 45: Special values: `NA`  ####

# Let's add a column with a numeric vector.
special_data$num_col1 = c(1, 555, 3)

# Let's make the 2nd element in that column `NA`.
special_data$num_col1[2] = NA

# To check for `NA`s we use `is.na`.
is.na(special_data$num_col1[2])

# We can also use it to check the whole column/vector. 
# The result will be a vector of `TRUE` or `FALSE` with values corresponding to each element.
is.na(special_data$num_col1)


#=================================================-
#### Slide 46: Special values: `NULL`   ####

# To get rid of a column in a `data.frame` all 
# you have to do is set it to `NULL`.
special_data$num_col3 = NULL
special_data
# To check for `NULL`s use `is.null`.
is.null(special_data$num_col3)

# To check for `NULL`s use `is.null`.
is.null(special_data$num_col2)



#=================================================-
#### Slide 48: Exercise 1  ####




#=================================================-
#### Slide 58: Directory settings  ####

# Print working directory (Mac/Linux).
getwd()


#=================================================-
#### Slide 59: Loading dataset into R: read CSV files  ####

# Set working directory to where the data is.
setwd(data_dir)

# To read a C[omma] S[eparated] V[alues] file into
# R you can use a simple command `read.csv`.
temp_heart_data = read.csv("temp_heart_rate.csv",    #<- provide file name
                           header = TRUE,            #<- if file has header set to TRUE
                           stringsAsFactors = FALSE) #<- read strings as characters, not as factors


#=================================================-
#### Slide 60: Viewing data in R  ####

# Inspect the structure of the data.
str(temp_heart_data)


#=================================================-
#### Slide 61: Viewing data in R  ####

head(temp_heart_data, 4) #<- Inspect the `head` (first 4 rows).


tail(temp_heart_data, 4) #<- Inspect the `tail` (last 4 rows).


#=================================================-
#### Slide 62: Viewing data in R  ####

View(temp_heart_data)


#=================================================-
#### Slide 64: Saving data: write CSV files  ####

# Let's save the first 10 rows of our data to a variable.
temp_heart_subset = temp_heart_data[1:10, ]
temp_heart_subset

# Set working directory to where the data is.
setwd(data_dir)

# Write data to a CSV file providing 3 arguments:
write.csv(temp_heart_subset,            #<- name of variable to save 
          "temp_heart_rate_subset.csv", #<- name of file where to save
          row.names = FALSE)            #<- logical value for row names


#=================================================-
#### Slide 66: Clearing objects from environment  ####

# List all objects in environment.
ls()


#=================================================-
#### Slide 69: Exercise 2  ####




#=================================================-
#### Slide 72: Loading data set  ####

# Set working directory to where we store data.
setwd(data_dir)

# Read CSV file called "ChemicalManufacturingProcess.csv"
CMP = read.csv("ChemicalManufacturingProcess.csv",
               header = TRUE,
               stringsAsFactors = FALSE)

# View CMP dataset in tabular data explorer.
View(CMP)


#=================================================-
#### Slide 74: Subsetting data  ####

# Let's make a vector of column indices we would like to save.
column_ids = c(1:4,  #<- concatenate a range of ids
               14:16)#<- with another a range of ids
column_ids           #<- verify that we have the correct set of columns

# Let's save the subset into a new variable and look at its structure.
CMP_subset = CMP[ , column_ids]
str(CMP_subset)


#=================================================-
#### Slide 76: Summary statistics: CMP  ####

summary(CMP_subset) #<- getting summary statistics of CMP_subset


#=================================================-
#### Slide 77: Working with missing data: max values  ####

# Let's try and compute the maximum value of the 1st manufacturing process.
max_process01 = max(CMP_subset$ManufacturingProcess01)
max_process01
max_process02 = max(CMP_subset$ManufacturingProcess01, na.rm = TRUE)
max_process02


#=================================================-
#### Slide 79: Working with missing data  ####

# Let's take a look at `ManufacturingProcess01`
# and see if any of the values in it are `NA`.
is.na(CMP_subset$ManufacturingProcess01)


#=================================================-
#### Slide 81: Working with missing data: identifying NA values  ####

# Let's save this vector of logical values to a variable.
is_na_MP01 = is.na(CMP_subset$ManufacturingProcess01)

# To determine WHICH elements in the vector are `TRUE`and are NA, we will use `which` function.

# Since we already have a vector of `TRUE` or `FALSE` logical values
# we only have to give it to `which` and it will return all of the
# indices of values that are `TRUE`.
which(is_na_MP01)

# This is also a correct way to set it up.
which(is_na_MP01 == TRUE)


#=================================================-
#### Slide 82: Working with missing data: locating NA values  ####

# Let's save the index to a variable.
na_id = which(is_na_MP01)
na_id

# Let's view the value at the `na_id` index.
CMP_subset$ManufacturingProcess01[na_id]


#=================================================-
#### Slide 83: Working with missing data: mean replacement  ####

# Compute the mean of the `ManufacturingProcess01`.
mean_process01 = mean(CMP_subset$ManufacturingProcess01)
mean_process01

# Compute the mean of the `ManufacturingProcess01` and set `na.rm` to `TRUE`.
mean_process01 = mean(CMP_subset$ManufacturingProcess01, na.rm = TRUE)
mean_process01


#=================================================-
#### Slide 84: Working with missing data  ####

# Assign the mean to the entry with the `NA`.
CMP_subset$ManufacturingProcess01[na_id] = mean_process01
CMP_subset$ManufacturingProcess01[na_id]
max_process01 = max(CMP_subset$ManufacturingProcess01)
max_process01


#=================================================-
#### Slide 85: Working with missing data  ####

# Impute missing values of `ManufacturingProcess02` with the mean
is_na = is.na(CMP_subset$ManufacturingProcess02)
na_id = which(is_na)
mean_process02 = mean(CMP_subset$ManufacturingProcess02, na.rm = TRUE)
CMP_subset$ManufacturingProcess02[na_id] = mean_process02


# Impute missing values of `ManufacturingProcess03` with the mean
is_na = is.na(CMP_subset$ManufacturingProcess03)
na_id = which(is_na)
mean_process03 = mean(CMP_subset$ManufacturingProcess03, na.rm = TRUE)
CMP_subset$ManufacturingProcess03[na_id] = mean_process03


#=================================================-
#### Slide 87: Exercise 3  ####




#=================================================-
#### Slide 92: Ifelse example  ####

meanCMP_yield = mean(CMP$Yield)

CMP$new_yield = ifelse(CMP$Yield >= meanCMP_yield,   #<- if CMP$Yield is greater than 
                                                     #   or equal to the mean of Yield
                       "above_average",              #<- Then new_yield = above average    
                       "below_average")              #<- Else new_yield = below average


head(CMP[,c("Yield","new_yield")])


#=================================================-
#### Slide 95: Loops: `for` loop  ####

CMP_subset_variables = colnames(CMP_subset)

# Adjust the start index.
seq_start = 3

# Adjust the end index.
seq_end = 6

# Loop through just a subset 
# of the variable names.
for(i in seq_start:seq_end){
  print(CMP_subset_variables[i])
}


#=================================================-
#### Slide 97: Functions in R: function without arguments  ####

# Make a function that prints "Hello" and
# assign it to `PrintHello` variable.

PrintHello = function(){ #<- declare function
  print("Hello!")        #<- perform action
}

# Invoke function by calling `PrintHello()`.
PrintHello()



#=================================================-
#### Slide 98: Functions in R: function with arguments  ####

# Make a function that prints "Hello, [name]".
PrintHello = function(name){    #<- Add `name` argument to function declaration
  
  # Save message to print to a variable.
  hello_name = paste0("Hello ", #<- concatenate "Hello "
                      name,     #<-  with the `name` from function argument, and
                      "!")      #<-  with the remainder of the message to print
  
  print(hello_name)             #<- print message
}

# Invoke function by calling `PrintHello([name])`.
PrintHello("User")


#=================================================-
#### Slide 99: Functions in R: function with arguments  ####

# Make function that rounds to the first `n` digits of `pi`.
GetPi = function(n){            #<- Add `n` argument to function declaration
  
  pi_num = round(3.14159265359, #<- Round `pi`
                 n)             #<-   to `n` digits
  return(pi_num)         
}

# Invoke function by calling `GetPi([n])`.
GetPi(3)


#=================================================-
#### Slide 101: Functions in R  ####

ImputeNAsWithMean = function(dataset){        
  
  for(i in 1:ncol(dataset)){                  
    is_na = is.na(dataset[, i])
    if(any(is_na)){                          
      na_ids = which(is_na)                  
      var_mean = mean(dataset[, i],          
                      na.rm = TRUE)          
      dataset[na_ids, i] = var_mean         
      message = paste0(
        "NAs substituted with mean in ",
        colnames(dataset)[i])            
      print(message)                         
    }
  }
  return(dataset)                             
}
# Let's re-generate our subset again.
CMP_subset = CMP[, c(1:4, 14:16)]

# Let's test the function giving the `CMP_subset` as the argument.
CMP_subset_imputed = ImputeNAsWithMean(CMP_subset)

# Inspect the structure.
str(CMP_subset_imputed)


#=================================================-
#### Slide 103: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
