#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK1 DAY1 INTRO GIT FUND R MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 42: Exercise 1  ####




#=================================================-
#### Slide 60: Exercise 2  ####




#=================================================-
#### Slide 67: Basic calculations and operations  ####

# Add whole numbers.
1 + 2

# Add numbers with decimals.
3.23 + 4.65
# Subract whole numbers.
10 - 7

# Subract numbers with decimals.
3.23 - 4.65


#=================================================-
#### Slide 68: Basic calculations and operations  ####

# Multiply whole numbers.
1 * 2

# Multiply numbers with decimals.
3.23 * 4.65
# Divide whole numbers.
9 / 3

# Divide numbers with decimals.
3.23 / 4.65


#=================================================-
#### Slide 69: Basic calculations and operations  ####

# Take square root of a number with.
sqrt(100)

# Take square root of an expression.
sqrt(7 * 5)
# Raise number to a power with `^`.
9 ^ 3

# Raise number to a power with `**`.
9 ** 3

# Raise expression to a power.
(3.23 / 4.65)^2


#=================================================-
#### Slide 70: Basic calculations and operations  ####

# Get remainder from division.
7 %% 3

# Get remainder from division.
4 %% 2
# Perform integer division.
7 %/% 3

# Perform integer division.
4 %/% 2


#=================================================-
#### Slide 71: Variables and assignment operators  ####

# Define a variable using `<-` 
# as an assignment operator.
A <- 3  
A

# Define a variable using `=` 
# as an assignment operator.
B = 2 + 5
B


#=================================================-
#### Slide 72: Operations with variables  ####

# Add 2 variables.
C = A + B
C

# Add a variable and a number.
D = C + 5
D
# Subtract 2 variables from each other.
D - C

# Subtract a variable from number.
33 - D

# Or a number from a variable.
D - 33


#=================================================-
#### Slide 73: Other operators: comparison  ####

# Check variables are equal.
A == B

# Check if variables are not equal.
A != B

# Check if one is greater than the other.
A > B
# Check if one is greater than or equal to 5.
A >= 5

# Check if one is less than or equal to 3.
A <= 3

# Check if one is smaller than the other.
A < B


#=================================================-
#### Slide 75: Grouping multiple operations with variables  ####

# You can group several operations into
# a single one.
((D - C) * 2) ^ (1 / 3)
# This is equivalent to a series of steps 
# like ones below.
step1 = D - C
step1

step2 = step1 * 2
step2

step3 = 1 / 3
step3

step4 = step2 ^ step3
step4


#=================================================-
#### Slide 76: Grouping multiple operations with variables  ####

# You can group several operations into a single one.
((D - C) * 2) ^ (1 / 3)

# Be careful with your operators and your parenteses, the following expression 
# will not return the same result as the one above!
((D - C) * 2) ^ 1 / 3


#=================================================-
#### Slide 78: Variable value re-assignment  ####

# 1. Create a variable and assign 67 to it.
this_variable = 67
this_variable

# 2. Create another variable and assign -54.
that_variable = -54
that_variable

# 3. Calculate their sum.
this_variable + that_variable
# 4. Re-assign a value to `this_variable`.
this_variable = 35
this_variable

# 5. Add two variables and store the result 
#    in `that_variable`.
that_variable = this_variable + that_variable
that_variable


#=================================================-
#### Slide 79: Naming variables and functions  ####

this_is_a_valid_name = -5
this_is_a_valid_name

This.Is.Also.A.Valid.Name = 3
This.Is.Also.A.Valid.Name

.another.valid.name3 = -Inf
.another.valid.name3


#=================================================-
#### Slide 80: Naming variables and functions: CAUTION  ####

# R is case sensitive!
X = 35.5 #<- this `X`
X

x = -9   #<- is not the same as this `x`
x


#=================================================-
#### Slide 83: Exercise 3  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
