#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK6 DAY1 TEXT MINING R MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 2: Load packages and libraries  ####

# Install text mining package `tm`.
# install.packages("tm")
library(tm)

# Install SnowballC package for stemming words
# install.packages("SnowballC")
library(SnowballC)

# Wordcloud will make wordclouds.
# install.packages("wordcloud")
library(wordcloud)

library(tidyverse)


#=================================================-
#### Slide 18: Introducing tm package  ####

# View package documentation.
library(help = "tm")


#=================================================-
#### Slide 21: Wiki corpus: load documents into corpus  ####

# Create a path name to a folder where Wiki Corpus documents are saved.
wiki_corpus_path = paste0(data_dir, "/wiki_corpus")

# List all files in the directory.
dir(wiki_corpus_path)

# Create directory source.
dir_source = DirSource(wiki_corpus_path)

dir_source


#=================================================-
#### Slide 22: Wiki corpus: load documents into corpus  ####

# Create corpus object from directory source.
wiki_corpus = VCorpus(dir_source)

# Inspect corpus object.
wiki_corpus


#=================================================-
#### Slide 23: Corpus object  ####

# Structure of corpus object.
str(wiki_corpus)


#=================================================-
#### Slide 24: Corpus object: summary  ####

# View corpus summary.
summary(wiki_corpus)

# View detailed corpus summary.
inspect(wiki_corpus)


#=================================================-
#### Slide 25: Accessing elements of corpus object  ####

# To view the n-th element in corpus, use `[[n]]`.
wiki_corpus[[1]]


#=================================================-
#### Slide 26: Accessing elements of corpus object  ####

# View metadata for entire corpus.
meta(wiki_corpus)


#=================================================-
#### Slide 27: Exercise 1  ####




#=================================================-
#### Slide 34: Text transformations in tm package  ####

# Get all available transformation functions from `tm` package.
getTransformations()


#=================================================-
#### Slide 37: Cleaning text: convert to lower case  ####

# Convert `tolower` to `tm`-compatible function.
TmTolower = content_transformer(tolower)

# Convert all characters in `wiki_corpus` to lower case.
wiki_corpus_clean = tm_map(wiki_corpus, #<- corpus object to be cleaned
                           TmTolower)  #<- text transformation to be applied

# Check the first document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 41: Cleaning text: remove stop words  ####

# Define remove words function that takes a single argument.
RemoveEnglishWords = function(document){ #<- take a single document argument
  removeWords(document,               #<- remove words in the document
              stopwords("english"))   #<- give function a vector of common English stopwords
}

# Apply this transformation to the entire corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,  #<- set corpus
                           RemoveEnglishWords) #<- set transformation


#=================================================-
#### Slide 42: Cleaning text: remove stop words  ####

# Take a look at the transformed text of the 1st document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 45: Cleaning text: remove punctuation  ####

# Remove punctuation from all documents in corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           removePunctuation)

# Take a look at the transformed text of the 1st document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 48: Cleaning text: remove numbers  ####

# Remove numbers from all documents in corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           removeNumbers)

# Take a look at the transformed text of the 1st document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 50: Basic pattern substitution with gsub  ####

# Take a look at this simple example.
gsub("anything",
     "everything", 
     "I will replace anything!")


#=================================================-
#### Slide 51: Basic pattern substitution with gsub  ####

# Replace all letters with an empty string.

gsub("[A-z]", #<- replace all letters
     " ",     #<- with whitespace
     "This 123 is a &*% weird )( mix")


# Replace all BUT letters with an empty string.

gsub("[^A-z]", #<- replace all NON-letters
     " ",      #<- with whitespace
     "This 123 is a &*% weird )( mix")



#=================================================-
#### Slide 52: Convert into function and content_transformer  ####

# Replace all BUT letters with an empty string.
SubstitutePattern = content_transformer(
  function(document, pattern, replacement){ #<- notice the 1st argument has to be the document
      gsub(pattern, 
           replacement,       
           document)
  }
)

SubstitutePattern


#=================================================-
#### Slide 53: Cleaning text: remove non-alphabetical symbols  ####

# Remove punctuation from all documents in corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           SubstitutePattern,
                           "[^A-z]", #<- provide pattern to replace
                           " ")      #<- provide replacement

# Take a look at the transformed text of the 1st document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 54: Cleaning text: remove remove mathbf pattern  ####

# Remove punctuation from all documents in corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           SubstitutePattern,
                           "mathbf",
                           " ")      

# Take a look at the transformed text of the 1st document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 55: Cleaning text: remove 1 or 2-letter words  ####

# Remove punctuation from all documents in corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           SubstitutePattern,
                           "\\s[A-z]{1,2}\\s",
                           " ")      

# Take a look at the transformed text of the 1st document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 58: Cleaning text: stemming words with SnowballC  ####



# Stem documents in corpus.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           stemDocument)

# Inspect the content of the first document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 60: Cleaning text: remove leading/trailing whitespace  ####

# Substitute all leading and trailing whitespace with an empty string.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           SubstitutePattern,
                           "^\\s+|\\s+$",
                           "")

# Inspect the content of the first document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 61: Cleaning text: remove extra inner whitespace  ####

# Strip all whitespace between words.
wiki_corpus_clean = tm_map(wiki_corpus_clean,
                           stripWhitespace)

# Inspect the content of the first document.
content(wiki_corpus_clean[[1]])


#=================================================-
#### Slide 62: Saving clean corpus as RData file  ####

# Set directory to where we store data.
setwd(data_dir)

# Save clean corpus object to an RData file.
save(wiki_corpus_clean, file = "wiki_corpus_clean.RData")


#=================================================-
#### Slide 64: Exercise 2  ####




#=================================================-
#### Slide 68: Term-Document Matrix (TDM)  ####

# Construct a term-document matrix from wiki corpus.
TDM_wiki = TermDocumentMatrix(wiki_corpus_clean)

# Inspect the term document matrix object.
inspect(TDM_wiki)


#=================================================-
#### Slide 69: Working with TDM object: structure  ####

# Take a look at the structure of the TDM object.
str(TDM_wiki)


#=================================================-
#### Slide 70: Working with TDM object: basic statistics  ####

# Inspect the term document matrix object.
inspect(TDM_wiki)

# Get number of terms.
n_terms = nrow(TDM_wiki)
n_terms

# Get number of documents.
n_docs = ncol(TDM_wiki)
n_docs

# Get total number of entries.
total_entries = n_terms*n_docs
total_entries



#=================================================-
#### Slide 71: Working with TDM object: basic statistics  ####

# Inspect the term document matrix object.
inspect(TDM_wiki)

# Get number of non-sparse entries.
n_non_sparse = length(TDM_wiki$v)
n_non_sparse

# Get number of sparse entries.
n_sparse = total_entries - n_non_sparse
n_sparse

# Get matrix sparsity.
sparsity_ratio = n_sparse/total_entries
sparsity_ratio



#=================================================-
#### Slide 72: Working with TDM object: dimension names  ####

# Take a look at the structure of dimension names.
str(dimnames(TDM_wiki))

# Inspect the first few & last terms.
head(dimnames(TDM_wiki)$Terms)
tail(dimnames(TDM_wiki)$Terms)


#=================================================-
#### Slide 73: Working with TDM object: extracting terms  ####

# Save terms to a variable.
wiki_terms = dimnames(TDM_wiki)$Terms
head(wiki_terms)

# Count number of characters in each term.
num_chars = nchar(wiki_terms)
head(num_chars)
tail(num_chars)

# Find the longest term(s).
wiki_terms[which(num_chars == max(num_chars))]

# Find all terms with 3 characters.
wiki_terms[which(num_chars == 3)]


#=================================================-
#### Slide 74: TDM to matrix conversion  ####

# Cast TDM object to a matrix.
TDM_wiki_matrix = as.matrix(TDM_wiki)

View(TDM_wiki_matrix)


#=================================================-
#### Slide 76: Exercise 3  ####




#=================================================-
#### Slide 81: Computing word frequencies  ####

# Get term totals.
term_totals = rowSums(TDM_wiki_matrix)

head(term_totals)

tail(term_totals)

# Make a total frequency dataframe.
wiki_term_freq = data.frame(term = wiki_terms,
                            freq = term_totals)
head(wiki_term_freq, 4)

# Remove unnecessary row names.
row.names(wiki_term_freq) = NULL
head(wiki_term_freq, 4)


#=================================================-
#### Slide 82: Working with word frequencies  ####

# We've already loaded the tidyverse.
# library(tidyverse)

# Arrange values from highest to lowest frequency.
wiki_term_freq = arrange(wiki_term_freq, desc(freq))

# Take a look at the first few rows now.
head(wiki_term_freq)


#=================================================-
#### Slide 83: Save wiki corpus term frequency data  ####

# Set working directory to where we save our data.
setwd(data_dir)

# Save total frequency data for wiki corpus to a CSV file.
write.csv(wiki_term_freq, "wiki_corpus_term_frequency.csv")



#=================================================-
#### Slide 85: Word frequency cloud  ####

# Documentation for package wordcloud.


?wordcloud

wordcloud(words, #<- vector of words
          freq,  #<- vector of frequencies
          ...)   #<- other optional args.



#=================================================-
#### Slide 86: Word frequency cloud: basic plot  ####

# Plot a basic word cloud for wiki corpus.
wordcloud(wiki_term_freq$term,
          wiki_term_freq$freq)

display.brewer.all() #<- shows all palettes


#=================================================-
#### Slide 87: Word frequency cloud: select palette  ####

# To get a palette, call `brewer.pal` and
brewer.pal(8,      #<- select number of colors
           "Set1") #<- select palette

# Add color palette for words.
wordcloud(wiki_term_freq$term,
          wiki_term_freq$freq,
          colors = brewer.pal(8, "Set1")) 


#=================================================-
#### Slide 88: Word frequency plot: theme and data transform  ####

# Save our custom `ggplot` theme to a variable.
my_ggtheme = theme_bw() +                     
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16),
        legend.text = element_text(size = 16),              
        legend.title = element_text(size = 18),             
        plot.title = element_text(size = 25),               
        plot.subtitle = element_text(size = 18))      

# Transform frequency data for ggplot.
wiki_term_freq = transform(wiki_term_freq,        #<- original data
                           term = reorder(term,   #<- re-order factor variable `term`
                                          -freq)) #<- in order of decreasing frequency


#=================================================-
#### Slide 89: Word frequency plot: set up  ####

# Make a bar plot of term frequencies in wiki corpus.
ggplot(wiki_term_freq, aes(x = term,     #<- build base plot mapping terms to x-axis                
                           y = freq)) +  #<- and frequencies to y-axis
  geom_bar(stat = "identity",            #<- add `geom_bar` with `identity` stat (raw counts)
           fill = "steelblue",           #<- set fill 
           color = "steelblue",          #<- and color of the bars
           alpha = 0.8) +                #<- make bars 80% opaque
  my_ggtheme                             #<- add theme


#=================================================-
#### Slide 90: Word frequency plot: adjust & polish  ####

# Make a bar plot of top 100 term frequencies in wiki corpus.
wiki_freq_plot =                  
  ggplot(wiki_term_freq[1:100, ], #<- build base plot from the first 100 rows of data
         aes(x = term,            #<- map terms to x-axis
             y = freq)) +         #<- map frequencies to y-axis
  geom_bar(stat = "identity",     #<- add `geom_bar` with `identity` stat (raw counts)
           fill = "steelblue",    #<- set fill 
           color = "steelblue",   #<- and color of the bars
           alpha = 0.8) +         #<- make bars 80% opaque
  my_ggtheme                      #<- add theme

# Adjust plot.
wiki_freq_plot = wiki_freq_plot + 
  labs(title = "Top 100 most frequent words",              #<- add title
       subtitle = "Wiki abstract corpus of 7 documents") + #<- and subtitle
  theme(axis.text.x = element_text(angle = 90))            #<- rotate x-axis labels


#=================================================-
#### Slide 91: Word frequency plot  ####

wiki_freq_plot


#=================================================-
#### Slide 94: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
