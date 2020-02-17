#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK6 DAY1 TEXT MINING R MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-


#### Question 1 ####
# Create a directory source from the `wiki_exercise_corpus` folder located in the data directory.

# Answer: 

#================================================-
#### Question 2 ####
# Create a corpus object from the directory source called `wiki_exercise_corpus`. 
# How many documents are in this corpus object?

# Answer: 


#================================================-
#### Question 3 ####
# View the structure of the `wiki_exercise_corpus`.
# Inspect corpus object.

# Answer: 

#================================================-
#### Question 4 ####
# Print a summary of the `wiki_exercise_corpus`. 
# What is the class of each file?
# Display the 4th element of the corpus object.

# Answer: 


#================================================-
#### Question 5 ####

# Display the content of the 3rd document in the corpus.

# Answer:

#================================================-
#### Question 6 ####

# Save `wiki_exercise_corpus` as RData file. 
# Remove the corpus from the environment.
# List the elements in the directory now.
# Now load back the corpus.

# Answer:



#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Create a 'wiki_exercise_corpus_cleaned' by converting all 
# the elements in the `wiki_exercise_corpus` to lowercase.

# Answer:


#================================================-
#### Question 2 ####

# Utilizing the RemoveEnglishWords function from class, 
# remove all stopwords from the 'wiki_exercise_corpus_cleaned'.

# Answer:


#================================================-
#### Question 3 ####

# Remove all punctuation from the 'wiki_exercise_corpus_cleaned'.

# Answer:

#================================================-
#### Question 4 ####

# Remove all numbers from the 'wiki_exercise_corpus_cleaned'.
# Also remove all the non-alphabetic symbols using the 'SubstitutePattern'
# defined in class.

# Answer:


#================================================-
#### Question 5 ####

# Stem all the words from the 'wiki_exercise_corpus_cleaned'.
# Remove all the leading and trailing white spaces.
# Remove all inner extra white spaces.

# Answer:


#================================================-
#### Question 6 ####

# Save your wiki_exercise_corpus_clean RData to the data directory.

# Answer:




#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Create a term document matrix named `TDM_wiki_ex`. 
# How many total entries are there? 
# What percentage of entries are sparse? 
# What is the length of the longest word in our TDM?

# Answer: 




#================================================-
#### Question 2 ####

# Examine the structure of the TDM object. 
# How many rows are in `TDM_wiki_ex`?
# What does each row represent?

# Answer:


#================================================-
#### Question 3 ####

# Inspect `TDM_wiki_ex` and determine the entry in the first row, third column.

# Answer: 



#================================================-
#### Question 4 ####

# Calculate the sparsity percentage on your own, by first calculating the number of sparse entries
# and dividing this quantity by the total number of entries. 
# Does this match your answer in question 1?

# Answer:



#================================================-
#### Question 5 ####

# Find the all terms with the minimum length in our set.
# Find all terms that begin with the letters 'th' using the base R function `startsWith`.
# If you are not sure how to use it, look up its documentation by running
# ?startsWith in your console. You've also used it 
# together with `select` function in the module about `tidyverse`.

# Answer: 



#================================================-
#### Question 6 ####

# Find all terms with maximum length in our set.
# Find all terms of length 10.

# Answer:



#================================================-
#### Question 7 ####

# Convert TDM_wiki_ex into a matrix called TDM_mat

# Answer: 




#### Exercise 4 ####
# =================================================-

#### Question 1 ####

# Calculate the row sums for each row in `TDM_wiki_ex_mat` and name this vector `word_totals`.
# What are the first and last three values of word_totals?
# Combine the words with their totals in a dataframe called `wiki_word_freq`,
# with first column "word" and second column "freq". 
# Make sure to remove row names, if there are any.

# Answer: 


#================================================-

#### Question 2 ####

# Arrange the `wiki_word_freq` dataframe by frequency in descending order. 
# What are the first and last 3 words of maximum and minimum frequency, respectively?
# How many words have frequency 7?

# Answer: 


#================================================-
#### Question 3 ####

# Create the same plot as in question 5, except color the words "darkblue" 
# and only print 45 words.
# HINT: ?wordcloud may give a better idea of which arguments to manipulate.

# Answer: 


#================================================-
#### Question 4 ####

# This time, use the `brewer.pal` function to select 6 colors from "Set2" to color our word cloud.

# Answer: 



#================================================-
#### Question 5 ####

# Transform the `wiki_word_freq` so that `word` is ordered in decreasing order of frequency.
# Plot this transformation with `ggplot` to create a frequency plot, with stat = "identity",
# the bars having opaqueness of 75%, and fill and color being color 35

# Answer: 


#================================================-
#### Question 6 ####

# Similar to the previous plot, plot only the top 50 words, 
# and add appropriate labels to the axes.
# Add `my_ggtheme` to the plot and then rotate the x-axis labels to 90 degrees.
# Does the shape of the distribution seem similar to the wiki corpus we have plotted in class?
# What are the top 10 words in this corpus?
# Do these words cary a more general meaning covering a wide range of topics or 
# are they very specific?

# Answer: 




