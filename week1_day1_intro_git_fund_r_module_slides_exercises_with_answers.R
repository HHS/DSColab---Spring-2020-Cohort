#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK1 DAY1 INTRO GIT FUND R MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-


#### Question 1 ####

# Clone the DSColab---Spring-2020-Cohort repository to your desktop using either
# terminal (Mac users) or the git-bash shell (Windows users)

# Answer:
git clone `name of the repository`

#### Question 2 ####

# Navigate to your cloned repo and list the files within the repo
# This is assuming you are currently on your desktop

# Answer:
cd `name of the repository`/
ls 



#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# What is the order of commands we just reviewed that you will use when  
# committing?

# Answer:
git status
git add .
git commit -m "message here"
git pull
git push -u origin master



#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Add 3 and 5.

# Answer:
3 + 5

#================================================
# Add -10.56 and 99.679

# Answer:
-10.56 + 99.679

#================================================
# Make 3 more examples of addition.

# Answer: will vary.

#================================================
#### Question 2 ####

# Subtract 67 from 666.

# Answer:
666 - 67

#================================================
# Subtract -67 from 89.

# Answer:
89 - (-67)

# What do you get in return? Why did you get this answer?

# Answer: You should get 156. Subtracting a negative number is equivalent to adding. 

#================================================
#### Question 3 ####

# Mutiply 555 by 444.

# Answer:
555 * 444

#================================================
# Mutiply -5.5 by 0.32.

# Answer:
-5.5 * 0.32

#================================================
#### Question 4 ####

# Divide 20 by 65.

# Answer:
20 / 65

#================================================
# Divide 0.333 by 0.999.

# Answer:
0.333 / 0.999

#================================================
# Make 3 more examples of division.

# Answer: will vary.

#================================================
#### Question 5 ####

# Take a square root of 125.

# Answer:
sqrt(125)

#================================================
# Take a square root of a product 64 and 8.

# Answer:
sqrt(64 * 8)

#================================================
# Take a square root of a -9.

# Answer:
sqrt(-9)

# What do you get in return? Why do you think you got this as the output?

# Answer: You should get a warning message that says:

## Warning message:
## In sqrt(-9) : NaNs produced

# and a `NaN` instead of a value.
# This happens because taking a square root of a negative number does not produce a real number!

#================================================
# Make 3 more examples of taking a square root.

# Answer: will vary.

#================================================
# Raise 6 to the 10th power.

# Answer:
6^10

# Also correct answer:
6**10

#================================================
# Raise a sum of 95 and -7 to the 3rd power.

# Answer:
(95 + (-7))^3

# Also correct answer:
(95 + (-7))**3

#================================================
#### Bonus question ####
# Take the cube root of 1000

# Answer: 
1000^(1/3)

# Also correct answer:
1000**(1/3)

# Why does this work?

# Answer: 
# The root of a operation is also a power, just instead
# of raising the number into a power > 1, we raise it
# to a fraction. Square root is equivalent to raising
# a number to (1/2)th power.

#================================================
# Make 3 more examples of raising a number into power.

# Answer: will vary.

#================================================
#### Question 6 ####

# What is the remainder when we divide 5 by 2?

# Answer: 1
5 %% 2

#================================================
# What is the remainder when we divide 6 by 7?

# Answer: 6
6 %% 7

#================================================
# Why do you get this number?

# Answer: because 6 < 7, so we can "fit" 7 into 6 0 times, what's left (i.e. the remainder) is 6.

#================================================
# Make 3 more examples of getting a remainder.

# Answer: will vary.

#================================================
# How many times can we fit 8 into 999?

# Answer: 124
999 %/% 8

#================================================
# What is the biggest whole number we get if we divide 24 by -12?

# Answer: -2
24 %/% (-12)

#================================================

#### Question 7 ####

# Make a variable called `var_1` and let it be equal to a sum of 100 and 65.
# Hint: when you create a new variable, make sure you view what it is equal to 
# in console and / or environment pane.

# Answer:
var_1 = 100 + 65
var_1

#================================================
# Make a variable called `var_2` and let it be equal a product of 3 and 1/2.

# Answer:
var_2 = 3*(1/2)
var_2

#================================================
#### Question 8 ####

# Make a variable called `var_3`, which is a result of division of `var_1` by `var_2`.

# Answer:
var_3 = var_1 / var_2
var_3

#================================================
# Make a variable called `var_4` and set it equal to 110.

# Answer:
var_4 = 110
var_4

#================================================
#### Question 9 ####

# Compare `var_4` to `var_3`, are they equal?

# Answer:
var_4 == var_3

#================================================
# Compare `var_1` to `var_4`, is `var_4` greater than `var_1`?

# Answer:
var_4 > var_1

# Also correct answer:
var_1 < var_4

#================================================
# Compare `var_1` to `var_2`, is `var_1` greater than `var_2`?

# Answer:
var_1 > var_2

# Also correct answer:
var_2 < var_1

#================================================
# Compare `var_2` to `var_3`, is `var_2` at least as big as `var_3`?

# Answer:
var_2 >= var_3

# Also correct answer:
var_3 <= var_2

#================================================
# Compare `var_4` to `var_3`, is `var_4` at most as big as `var_3`?

# Answer:
var_3 >= var_4

# Also correct answer:
var_4 <= var_3

#================================================
#### Question 10 ####

# Make a variable called `temp_var` and set it equal to 10^3.

# Answer:
temp_var = 10^3

#================================================
# Divide it by 10 and save it to itself. What is `temp_var` now equal to?

# Answer: 100
temp_var = temp_var / 10
temp_var

#================================================
# Can we retrieve the initial value of `temp_var`?

# Answer: No, the original value of `temp_var` was overwritten by our operation on itself and 

#================================================
#### Question 11 ####

# Make a variable `Temp_Var` and assign it to the negative third power of 5.

# Answer: 
Temp_Var = 5^(-3)
Temp_Var

#================================================
# Can we still retrieve the value assigned to `temp_var`? If yes, then what is it?

# Answer: Yes, because these two variables are DIFFERENT, because R is case sensitive. 
# The value is still 100.

#================================================
#### Question 12 ####

# Make a variable called `007Agent` and assign this character string to it: "Bond, James Bond".
007Agent = "Bond, James Bond"

# Answer: You should get an error:
## Error: unexpected symbol in "007Agent"

# This happens, because R does not allow variable names that start with a number!
# If you switch the order of the numbers and the characters around, R will let you do that.
# Besides, Agent007 sounds better anyway :)
Agent007 = "Bond, James Bond"
Agent007

#================================================
#### Bonus question 1 ####

# How many different remainders can we get from dividing any number by 2?

# Answer: 2

# What are they?

# Answer: 0 and 1

# Why is that?

# Answer: If the number is even, the remainder will always be 0, if the number is odd,
# the remainder will always be 1.

#================================================
#### Bonus question 2 ####
# Out of all possible pairs of the 4 variables (`var_1` through `var_4`), find the one with the biggest sum!
# Assign that sum to `var_5`.

# Answer: 
# There are 6 possible combinations of 4 variables, i.e. 6 sums:
var_1 + var_2
# 166.5

var_1 + var_3
# 275

var_1 + var_4
# 275

var_2 + var_3
# 111.5

var_2 + var_4
# 111.5

var_3 + var_4
# 220

# There are 2 pairs that produce the same result:
var_1 + var_3
# 275

var_1 + var_4
# 275

# We can make `var_5` be equal to either
var_5 = var_1 + var_3
var_5

# or 
var_5 = var_1 + var_4
var_5

# You could also get to the correct result by comparing variables individually and picking
# the two variables that are the biggest out of 4, because they will produce the biggest sum.

# Pick the 1st biggest variable first:

# Compare var_1 to var_2 (we need to use >= instead of >, because > will 
# return FALSE in case the two variables are the same, >= will return TRUE and keeping 
# either of the two will be fine)
var_1 >= var_2

# Since `var_1` is greater than or equal to `var_2`, we'll keep `var_1`, and compare it to `var_3`.
var_1 >= var_3

# Since `var_1` is greater than or equal to `var_3`, we'll keep `var_1`, and compare it to `var_4`.
var_1 >= var_4

# Seems like `var_1` is the 1st biggest variable of 4, this will be the first number in our sum.

# Now let's pick the second biggest (exclude `var_1`):
var_2 >= var_3

# Since `var_3` is bigger than or equal to `var_3`, keep it and compare it to `var_4`
var_3 >= var_4

# Since `var_3` is bigger than or equal to `var_4`, the 2nd biggest number is `var_3`, so the sum will be
var_5 = var_1 + var_3
var_5

#================================================


