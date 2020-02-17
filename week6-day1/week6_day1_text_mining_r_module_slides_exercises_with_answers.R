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
wiki_corpus_path = paste0(data_dir, "/wiki_exercise_corpus") # <- Make sure data_dir is defined
dir_source = DirSource(wiki_corpus_path)
dir_source

#================================================-
#### Question 2 ####
# Create a corpus object from the directory source called `wiki_exercise_corpus`. 
# How many documents are in this corpus object?

# Answer: 
wiki_exercise_corpus = VCorpus(dir_source)
wiki_exercise_corpus
# There are 5 documents in total.

#================================================-
#### Question 3 ####
# View the structure of the `wiki_exercise_corpus`.
# Inspect corpus object.

# Answer: 
str(wiki_exercise_corpus)
inspect(wiki_exercise_corpus)

#================================================-
#### Question 4 ####
# Print a summary of the `wiki_exercise_corpus`. 
# What is the class of each file?
# Display the 4th element of the corpus object.

# Answer: 
summary(wiki_exercise_corpus)
# They are all of class `PlainTextDocument`.

wiki_exercise_corpus[[4]]

#================================================-
#### Question 5 ####

# Display the content of the 3rd document in the corpus.

# Answer:
content(wiki_exercise_corpus[[3]])

#================================================-
#### Question 6 ####

# Save `wiki_exercise_corpus` as RData file. 
# Remove the corpus from the environment.
# List the elements in the directory now.
# Now load back the corpus.

# Answer:
save(wiki_exercise_corpus, file = "wiki_exercise_corpus.RData")
rm(wiki_exercise_corpus)
ls()
load("wiki_exercise_corpus.RData")


#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Create a 'wiki_exercise_corpus_cleaned' by converting all 
# the elements in the `wiki_exercise_corpus` to lowercase.

# Answer:
TmTolower = content_transformer(tolower)
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus, #<- corpus object to be cleaned
                                    TmTolower) 

#================================================-
#### Question 2 ####

# Utilizing the RemoveEnglishWords function from class, 
# remove all stopwords from the 'wiki_exercise_corpus_cleaned'.

# Answer:
RemoveEnglishWords = function(document){ #<- take a single document argument
  removeWords(document,               #<- remove words in the document
              stopwords("english"))   #<- give function a vector of common English stopwords
}
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,  #<- set corpus
                                    RemoveEnglishWords)

#================================================-
#### Question 3 ####

# Remove all punctuation from the 'wiki_exercise_corpus_cleaned'.

# Answer:
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,
                                    removePunctuation)

#================================================-
#### Question 4 ####

# Remove all numbers from the 'wiki_exercise_corpus_cleaned'.
# Also remove all the non-alphabetic symbols using the 'SubstitutePattern'
# defined in class.

# Answer:
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,
                                    removeNumbers)

SubstitutePattern = content_transformer(
  function(document, pattern, replacement){ #<- notice the 1st argument has to be the document
    gsub(pattern, 
         replacement,       
         document)
  }
)

wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,
                                    SubstitutePattern,
                                    "[^A-z]", #<- provde pattern to replace
                                    " ")

#================================================-
#### Question 5 ####

# Stem all the words from the 'wiki_exercise_corpus_cleaned'.
# Remove all the leading and trailing white spaces.
# Remove all inner extra white spaces.

# Answer:
# Stem all the words from our corpus.
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,
                                    stemDocument)

# Remove all the leading and trailing whitespaces.
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,
                                    SubstitutePattern,
                                    "^\\s+|\\s+$",
                                    "")

# Remove all inner extra whitespaces.
wiki_exercise_corpus_clean = tm_map(wiki_exercise_corpus_clean,
                                    stripWhitespace)

#================================================-
#### Question 6 ####

# Save your wiki_exercise_corpus_clean RData to the data directory.

# Answer:

# Set directory to where we store data.
setwd(data_dir)

# Save clean corpus object to an RData file.
save(wiki_exercise_corpus_clean, file = "wiki_exercise_corpus_clean.RData")



#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Create a term document matrix named `TDM_wiki_ex`. 
# How many total entries are there? 
# What percentage of entries are sparse? 
# What is the length of the longest word in our TDM?

# Answer: 

TDM_wiki_ex = TermDocumentMatrix(wiki_exercise_corpus_clean)
inspect(TDM_wiki_ex)

# There are 1834 total entries, with 75% of them being sparse.
# The longest word has length 17.

#================================================-
#### Question 2 ####

# Examine the structure of the TDM object. 
# How many rows are in `TDM_wiki_ex`?
# What does each row represent?

# Answer:

str(TDM_wiki_ex)
# There are 488 rows, in which each row represents a word.

#================================================-
#### Question 3 ####

# Inspect `TDM_wiki_ex` and determine the entry in the first row, third column.

# Answer: 

inspect(TDM_wiki_ex)
# The entry in the first row, third column is 9.

#================================================-
#### Question 4 ####

# Calculate the sparsity percentage on your own, by first calculating the number of sparse entries
# and dividing this quantity by the total number of entries. 
# Does this match your answer in question 1?

# Answer:

# First we get the number of total entries.
tot_entries = nrow(TDM_wiki_ex) * ncol(TDM_wiki_ex)

# Next, let's calculate the number of non sparse entries.
non_sparse = length(TDM_wiki_ex$v)

# So, the sparse entries must be the total subtractd by the non-sparse.
sparse = tot_entries - non_sparse

# Finally, we calculate the percentage.
sparse_ratio = sparse/tot_entries
sparse_ratio

#================================================-
#### Question 5 ####

# Find the all terms with the minimum length in our set.
# Find all terms that begin with the letters 'th' using the base R function `startsWith`.
# If you are not sure how to use it, look up its documentation by running
# ?startsWith in your console. You've also used it 
# together with `select` function in the module about `tidyverse`.

# Answer: 

# First,all terms with minimum length.
wiki_terms = dimnames(TDM_wiki_ex)$Terms
num_chars = nchar(wiki_terms)
wiki_terms[which(num_chars == min(num_chars))]

# Next, find all terms that begin with 'th'.
wiki_terms[which(startsWith(wiki_terms, "th"))]

#================================================-
#### Question 6 ####

# Find all terms with maximum length in our set.
# Find all terms of length 10.

# Answer:

# First, all terms with maximum length.
wiki_terms[which(num_chars == max(num_chars))]

# Next, all terms of length 10.
wiki_terms[which(num_chars == 10)]

#================================================-
#### Question 7 ####

# Convert TDM_wiki_ex into a matrix called TDM_mat

# Answer: 

TDM_mat = as.matrix(TDM_wiki_ex)



#### Exercise 4 ####
# =================================================-

#### Question 1 ####

# Calculate the row sums for each row in `TDM_wiki_ex_mat` and name this vector `word_totals`.
# What are the first and last three values of word_totals?
# Combine the words with their totals in a dataframe called `wiki_word_freq`,
# with first column "word" and second column "freq". 
# Make sure to remove row names, if there are any.

# Answer: 

word_totals = rowSums(TDM_mat)
head(word_totals, 3) # <- just the first three values
tail(word_totals, 3) # <- just the last three values

wiki_word_freq = data.frame(word = wiki_terms, 
                            freq = word_totals) #<- create our new dataframe

row.names(wiki_word_freq) = NULL                #<- here we remove row names

#================================================-

#### Question 2 ####

# Arrange the `wiki_word_freq` dataframe by frequency in descending order. 
# What are the first and last 3 words of maximum and minimum frequency, respectively?
# How many words have frequency 7?

# Answer: 

# Arrange our dataframe.
wiki_word_freq = arrange(wiki_word_freq, 
                         desc(freq))

# Print the first and last 3 words in our dataframe.
head(wiki_word_freq, 3)
tail(wiki_word_freq, 3)

length(which(wiki_word_freq$freq == 7))
# There are 3 words that have a frequency of 7.

#================================================-
#### Question 3 ####

# Create the same plot as in question 5, except color the words "darkblue" 
# and only print 45 words.
# HINT: ?wordcloud may give a better idea of which arguments to manipulate.

# Answer: 

wordcloud(wiki_word_freq$word,
          wiki_word_freq$freq,
          colors = "darkblue", #<- change color to dark blue
          max.words = 45)      #<- print only 45 words

#================================================-
#### Question 4 ####

# This time, use the `brewer.pal` function to select 6 colors from "Set2" to color our word cloud.

# Answer: 

wordcloud(wiki_word_freq$word,
          wiki_word_freq$freq,
          colors = brewer.pal(6, "Set2"), #<- set color of words randomly to 6 colors from Set2
          max.words = 45)

#================================================-
#### Question 5 ####

# Transform the `wiki_word_freq` so that `word` is ordered in decreasing order of frequency.
# Plot this transformation with `ggplot` to create a frequency plot, with stat = "identity",
# the bars having opaqueness of 75%, and fill and color being color 35

# Answer: 

wiki_word_freq = transform(wiki_word_freq,        
                           word = reorder(word,   #<- reorder the dataframe by frequency.
                                          -freq))

ggplot(wiki_word_freq, 
       aes(x = word, 
           y = freq)) + 
  geom_bar(stat = "identity", 
           alpha = 0.75, 
           fill = 30, 
           color = 30)

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

# First, define the myggtheme function as shown in the module.
my_ggtheme = theme_bw() +                     
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16),
        legend.text = element_text(size = 16),              
        legend.title = element_text(size = 18),             
        plot.title = element_text(size = 25),               
        plot.subtitle = element_text(size = 18))

# Create our ggplot.
ggplot(wiki_word_freq[1:50, ], 
       aes(x = word, y = freq)) +               #<- specify only top 50 words
  geom_bar(stat = "identity", 
           alpha = 0.75, 
           fill = 30, 
           color = 30) +
  labs(title = "Top 50 most frequent words") +  #<- add a title to the plot
  my_ggtheme +
  theme(axis.text.x = element_text(angle = 90)) #<- rotate the labels on the x-axis 90 degrees

# The top 10 words in the corpus appear to be these.
wiki_word_freq[1:10, ]

#         word freq
# 1     health   30
# 2      organ   23
# 3     public   16
# 4      studi   16
# 5       drug   14
# 6     includ   14
# 7     biolog   12
# 8     chemic   11
# 9  chemistri   11
# 10  compound    9

# Although in line with the general theme of the corpus (healthcare and biology),
# they carry a more general meaning that can span several topics.
# The very left end of the word distribution contains more general words 
# common to the majority documents in the corpus, as the frequency decreases, the 
# words with more specific meaning appear.



