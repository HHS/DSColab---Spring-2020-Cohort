#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK6 DAY2 TEXT DATA ANALYSIS MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####

# Load the wiki_exercise_corpus_clean.RData and arxiv_exercise_corpus.RData 
# from the data directory. The wiki_exercise_corpus_clean.RData was saved to the 
# data directory in the text-mining module, exercise 4 question 7.

# Answer:

# Load wiki exercise corpus.
load("wiki_exercise_corpus_clean.RData")

# Load corpus scraped from arXiv.org.
load("arxiv_exercise_corpus_clean.RData")

#================================================-
#### Question 2 ####

# Read in the wiki_exercise_corpus as a term document matrix named wiki_ex_TDM.
# Observe the sparsity of the tdm.

# Answer:

wiki_ex_TDM = TermDocumentMatrix(wiki_exercise_corpus_clean)
wiki_ex_TDM

#================================================-
#### Question 3 ####

# Use the removeSparseTerms function to set a maximum sparsity threshold to 0.75.
# What is the new sparsity percentage?

# Answer:

wiki_ex_TDM = removeSparseTerms(wiki_ex_TDM,     
                                sparse = .75) 
wiki_ex_TDM
# Our sparsity is now at 54%.


#### Question 4 ####

# Convert wiki_ex_TDM to a matrix called wiki_ex_TDM_matrix.
# Use the CosineSim function to compute the cosine similarity for the matrix.

# Answer:

# Convert `TDM` object to a matrix.
wiki_ex_TDM_matrix = as.matrix(wiki_ex_TDM)

# CosineSim function from our module
CosineSim = function(x){
  sums_of_squares = rowSums(x ^ 2)
  sim = tcrossprod(x) / sqrt(tcrossprod(sums_of_squares))
  
  return(sim)
}

# Compute cosine similarity for TDM matrix.
wiki_ex_term_sim = CosineSim(wiki_ex_TDM_matrix)

#================================================-
#### Question 5 ####

# Convert the similarity matrix to a 'dist' object.
# Name this object wiki_ex_term_sim_half.

# Answer:

# Convert similarity matrix to a `dist` object to keep only half of its entries.
wiki_ex_term_sim_half = as.dist(wiki_ex_term_sim)

#================================================-
#### Question 6 ####

# Convert wiki_ex_term_sim_half to a tidy dataset named wiki_ex_term_sim_df.
# Rename the columns term1, term 2, and cosine_sim.
# Sort the entries by cosine_sim in descending order. Whats the pair of words
# in the 4th observation?

# Answer:

# Tidy takes an object of class `dist` and 
# converts it to a tidy data frame with 3 columns.
wiki_ex_term_sim_df = tidy(wiki_ex_term_sim_half)

# Rename columns.
colnames(wiki_ex_term_sim_df) = c("term1", "term2", "cosine_sim")

# Sort entries by decreasing similarity.
wiki_ex_term_sim_df = arrange(wiki_ex_term_sim_df, desc(cosine_sim))

head(wiki_ex_term_sim_df)
# prior, allow is the pair of words in the 4th observation.

#### Question 7 ####

# Create a heat map of our terms in wiki_ex_term_sim_df, using term1 as x and term2 as y.
# fill by the cosine_sum value. 
# Add the my_ggtheme as shown in class.
# Rotate the text on the x-axis 90 degrees.
# Provide appropriate labels for the axes and a title.

# Answer:

# Load in the my_ggtheme object
my_ggtheme = theme_bw() +                     
  theme(axis.title = element_text(size = 18),
        axis.text = element_text(size = 16),
        legend.text = element_text(size = 16),              
        legend.title = element_text(size = 18),             
        plot.title = element_text(size = 22),               
        plot.subtitle = element_text(size = 18)) 

# Make a heatmap of term similarity.
ggplot(data = wiki_ex_term_sim_df,#<- set data
       aes(x = term1,            #<- map term1 to x
           y = term2,            #<- map term2 to y
           fill = cosine_sim)) + #<- map scores
  geom_tile() +                  #<- makes a heatmap
    my_ggtheme +                 #<- add theme
  theme(axis.text.x =            
          element_text(angle = 90)) + #<- rotate labs
  xlab("term") +                 #<- set x-axis lab
  ylab("term") +                 #<- set y-axis lab
  labs(title = "Cosine similarity of exercise terms",              
       subtitle = "Wiki abstract corpus of 5 documents")



#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Create a dataframe of nodes named wiki_ex_nodes.
# Then, create a dataframe of edges, wiki_ex_edges, where the cosine_sim value 
# is greater than 0.75.
# Change the column names of the wiki_ex_edges to "from", "to", and "value".

# Answer:

# Create a data frame of unique nodes.
wiki_ex_nodes = data.frame(id = colnames(wiki_ex_term_sim), #<- node data frame must an `id` column
                           stringsAsFactors = FALSE)

# Create a data frame of edges.
# Keep only those scores that are > 0.75.
wiki_ex_edges = wiki_ex_term_sim_df[wiki_ex_term_sim_df$cosine_sim > 0.75, ]

# Each data with edges must have at least 
# these three columns: `from`, `to`, and `value`.
colnames(wiki_ex_edges) = c("from", "to", "value")

#================================================-
#### Question 2 ####

# Construct a network visualization using wiki_ex_nodes and wiki_ex_edges.
# Make sure to set highilightNearest = T and nodesIdSelection = T.

# Answer:

# Construct network visualization.
visNetwork(wiki_ex_nodes,           #<- set nodes
           wiki_ex_edges) %>%       #<- set edges    
  visOptions(highlightNearest = TRUE,  #<- highlight nearest when clicking on a node 
             nodesIdSelection = TRUE)  #<- add an id node selection menu 

#### Question 3 ####

# Create a DTM matrix named wiki_ex_DTM_matrix which is the transpose of wiki_ex_TDM_matrix.
# Next, create a cosine similarity matrix using the CosineSim function and the wiki_ex_TDM_matrix.
# Name this matrix wiki_ex_doc_sim.

# Answer:

# To get a DTM matrix, we can either construct it with `DocumentTermMatix` function or
# simply transpose the TDM matrix we already have.
wiki_ex_DTM_matrix = t(wiki_ex_TDM_matrix)

# Compute cosine similarity on the matrix.
wiki_ex_doc_sim = CosineSim(wiki_ex_DTM_matrix)

#================================================-
#### Question 4 ####

# Change the colnames and rownames of wiki_ex_doc_sim to the heading of the metadata
# from wiki_exercise_corpus_clean, similar to how it was conducted in class.
# Create a tidy dataframe, wiki_ex_doc_sim_df, which is a tidy object of the distance object
# of wiki_ex_doc_sim.
# Rebane the columns "doc1", "doc2", and "cosine_sim" and arrange in descending order
# of cosine sum.

# Answer:

# Change column and row names of similarity matrix
# to headings of the corpus.
colnames(wiki_ex_doc_sim) = names(wiki_exercise_corpus_clean)
rownames(wiki_ex_doc_sim) = names(wiki_exercise_corpus_clean)

# Tidy up the distance object.
wiki_ex_doc_sim_df = tidy(as.dist(wiki_ex_doc_sim))

# Rename columns of the data freme.
colnames(wiki_ex_doc_sim_df) = c("doc1", "doc2", "cosine_sim")

# Sort rows by descending similarity scores.
wiki_ex_doc_sim_df = arrange(wiki_ex_doc_sim_df, desc(cosine_sim))

#================================================-
#### Question 5 ####

# Create a heat map of our terms in wiki_ex_doc_sim_df, using doc1 as x and doc2 as y.
# fill by the cosine_sum value. 
# Add the my_ggtheme as shown in class.
# Rotate the text on the x-axis 90 degrees.
# Provide appropriate labels for the axes and a title.

# Answer:

# Create a document similarity heatmap.
wiki_ex_doc_heatmap = ggplot(data = wiki_ex_doc_sim_df, 
       aes(x = doc1, 
           y = doc2, 
           fill = cosine_sim)) + 
  geom_tile() + 
 my_ggtheme + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("doc") + 
  ylab("doc") + 
  labs(title = "Cosine similarity of documents",              
       subtitle = "Wiki abstract corpus of 5 documents") 

wiki_ex_doc_heatmap

#================================================-
#### Question 6 ####

# Create a dataframe of nodes named wiki_ex_doc_nodes which has ID the column names
# of wiki_ex_doc_sim.
# Then, create a dataframe of edges from wiki_ex_doc_sim_df with 
# only cosine_sum values greater than 0.15. Rename these columns to "from", "to", and "value".
# Finally, create a visual network with the nodes and edges, with 
# highlightNearest = TRUE and nodesIdSelection = TRUE.

# Answer:

# Create a data frame of unique nodes.
wiki_ex_doc_nodes = data.frame(id = colnames(wiki_ex_doc_sim),
                               stringsAsFactors = FALSE)

# Create a data frame of edges.
# Keep only those scores that are > 0.15.
wiki_ex_doc_edges = wiki_ex_doc_sim_df[wiki_ex_doc_sim_df$cosine_sim > 0.15, ]

# Each data with edges must have at least 
# these three columns: `from`, `to`, and `value`.
colnames(wiki_ex_doc_edges) = c("from", "to", "value")

# Construct network visualization.
visNetwork(wiki_ex_doc_nodes,           #<- set nodes
           wiki_ex_doc_edges) %>%       #<- set edges    
  visOptions(highlightNearest = TRUE,  #<- highlight nearest when clicking on a node 
             nodesIdSelection = TRUE)  #<- add an id node selection menu 





#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Create a TF-IDF weighting DTM for wiki_exercise_corpus_clean 
# and name it as wiki_ex_DTM_weighted.

# Answer:
wiki_ex_DTM_weighted = DocumentTermMatrix(wiki_exercise_corpus_clean,
                                          control = list(weighting = weightTfIdf))
wiki_ex_DTM_weighted

#### Question 2 ####

# Remove the Sparse Terms from wiki_ex_DTM_weighted by setting sparse = 0.75
# Inspect the wiki_ex_DTM_weighted

# Answer:
wiki_ex_DTM_weighted = removeSparseTerms(wiki_ex_DTM_weighted, 
                                         sparse = 0.75)
inspect(wiki_ex_DTM_weighted)

#================================================-

#### Question 3 ####

# Convert the DTM as matrix and calculate the cosine similarity of documents 
# in wiki_exercise_corpus_clean and name it as wiki_ex_weighted_doc_sim.
# Rename the columns and rows of similarity matrix.View the wiki_ex_weighted_doc_sim.

# Answer:
wiki_ex_DTM_weighted_matrix = as.matrix(wiki_ex_DTM_weighted)

wiki_ex_weighted_doc_sim = CosineSim(wiki_ex_DTM_weighted_matrix)

colnames(wiki_ex_weighted_doc_sim) = names(wiki_exercise_corpus_clean)
rownames(wiki_ex_weighted_doc_sim) = names(wiki_exercise_corpus_clean)
View(wiki_ex_weighted_doc_sim)

#================================================-
#### Question 4 ####

# Tidy up the matrix to convert it to a data frame and rename the columns. Also, sort rows by scores of decreasing order.

# Answer:
wiki_ex_weighted_doc_sim_df = tidy(as.dist(wiki_ex_weighted_doc_sim))

# Rename columns.
colnames(wiki_ex_weighted_doc_sim_df) = c("doc1", "doc2", "cosine_sim")
head(wiki_ex_weighted_doc_sim_df)

# Arrange rows.
wiki_ex_weighted_doc_sim_df = arrange(wiki_ex_weighted_doc_sim_df, desc(cosine_sim))
head(wiki_ex_weighted_doc_sim_df)

#================================================-
#### Question 5 ####

# Compare the similarity scores between wiki_ex_doc_sim_df and wiki_ex_weighted_doc_sim_df.

# Answer:
head(wiki_ex_doc_sim_df, 10)
head(wiki_ex_weighted_doc_sim_df, 10)

#================================================-
#### Question 6 ####

# Create a heatmap of wiki_ex_weighted_doc_sim_df and compare with the 
# heatmap of wiki_ex_doc_sim_df.

# Answer:
wiki_ex_weighted_doc_heatmap = 
  ggplot(data = wiki_ex_weighted_doc_sim_df, 
         aes(x = doc1, 
             y = doc2, 
             fill = cosine_sim)) + 
  geom_tile() + 
  my_ggtheme + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("doc") + 
  ylab("doc") + 
  labs(title = "Cosine similarity of weigthed documents",              
       subtitle = "Wiki abstract corpus of 5 documents")  


wiki_ex_doc_heatmap
wiki_ex_weighted_doc_heatmap


#================================================-



#### Exercise 4 ####
# =================================================-


#### Question 1 ####
# Compute the cosine distance between the wiki docs and save it 
# as a `dist` object named wiki_ex_weighted_doc_dist. 
# Scale the distance matrix to a 2D space.

# Answer:
wiki_ex_weighted_doc_dist = 1 - wiki_ex_weighted_doc_sim
View(wiki_ex_weighted_doc_dist)

# Save it as a `dist` object.
wiki_ex_weighted_doc_dist = as.dist(wiki_ex_weighted_doc_dist)

# Scale the distance matrix to a 2-dimensional space.
wiki_docs = cmdscale(wiki_ex_weighted_doc_dist)
wiki_docs

#================================================-
#### Question 2 ####

# Plot the documents on to the x-y plane.

# Answer:
plot(wiki_docs,                    #<- x-y coordinates
     pch = 19,                     #<- symbol type
     col = "steelblue",            #<- color
     cex = 2,                      #<- size
     xlab = "Dim1",                #<- x-axis label
     ylab = "Dim2",                #<- y-axis label
     xlim = c(-0.6, 0.6),               #<- arbitrary x-axis limits
     ylim = c(-0.6, 0.6),               #<- arbitrary y-axis limits
     main = "Documents of Wiki Corpus") #<- plot title
text(wiki_docs[, 1] + 0.05,  #<- point labels x-coordinates shifted slightly
     wiki_docs[, 2] + 0.02,  #<- point labels y-coordinates shifted slightly
     rownames(wiki_docs))    #<- text labels for points

#================================================-
#### Question 3 ####

# Create a weighted DTM with TF-IDF of arxiv articles called as arxic_ex_DTM_weighted. 
# Remove the sparse terms, convert to matrix, compute the cosine similarity,
# and name it 'arvix_ex_weighted_doc_sim'.
# Tidy up the similarity matrix by naming it as 'arxiv_ex_weighted_doc_sim_df'.
# Rename the columns from the data frame.
# Sort data by descending similarity.

# Answer:
# Create and weight DTM with TF-IDF for arxiv articles.
arxiv_ex_DTM_weighted = DocumentTermMatrix(arxiv_exercise_corpus_clean,
                                           control = list(weighting = weightTfIdf))
arxiv_ex_DTM_weighted

# Remove sparse terms (set threshold at 0.75).
arxiv_ex_DTM_weighted = removeSparseTerms(arxiv_ex_DTM_weighted, 
                                          sparse = 0.75)
arxiv_ex_DTM_weighted

# Save it as a matrix.
arxiv_ex_DTM_weighted_matrix = as.matrix(arxiv_ex_DTM_weighted)

# Compute cosine similarity.
arxiv_ex_weighted_doc_sim = CosineSim(arxiv_ex_DTM_weighted_matrix)
str(arxiv_ex_weighted_doc_sim)

# Tidy up the similarity matrix.
arxiv_ex_weighted_doc_sim_df = tidy(as.dist(arxiv_ex_weighted_doc_sim))
head(arxiv_ex_weighted_doc_sim_df)

# Rename columns of the data frame.
colnames(arxiv_ex_weighted_doc_sim_df) = c("doc1", "doc2", "cosine_sim")
head(arxiv_ex_weighted_doc_sim_df)

# Sort data by descending similarity.
arxiv_ex_weighted_doc_sim_df = arrange(arxiv_ex_weighted_doc_sim_df, desc(cosine_sim))
head(arxiv_ex_weighted_doc_sim_df)

#### Question 4 ####

# Plot the similarity data of arxiv_ex_weighted_doc_sim_df on a heatmap.

# Answer:
ggplot(data = arxiv_ex_weighted_doc_sim_df, 
       aes(x = doc1, 
           y = doc2, 
           fill = cosine_sim)) + 
  geom_tile() + 
  my_ggtheme + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("doc") + 
  ylab("doc") + 
  labs(title = "Cosine sim. of weigthed documents",              
       subtitle = "arXiv corpus of documents") 

#================================================-
#### Question 5 ####

# Compute the cosine distance by naming it as arxiv_ex_docs and scale the arxiv_document_data and view the head. Plot arxiv_documents on the x-y plane.

# Answer:

# Compute cosine distance and scale the arxiv document data.
arxiv_ex_docs = cmdscale(as.dist(1 - arxiv_ex_weighted_doc_sim))

# Take a look at the result.
head(arxiv_ex_docs)

# Plot documents on x-y plane.
plot(arxiv_ex_docs,                         #<- x-y coordinates
     pch = 19,                           #<- symbol type
     col = "steelblue",                  #<- color
     cex = 2,                            #<- size
     xlab = "Dim1",                      #<- x-axis label
     ylab = "Dim2",                      #<- y-axis label
     xlim = c(-0.8, 0.6),                #<- arbitrary x-axis limits
     ylim = c(-0.6, 0.6),                #<- arbitrary y-axis limits
     main = "Documents of arXiv Corpus") #<- plot title
text(arxiv_ex_docs[, 1] + 0.05,        #<- point labels x-coordinates shifted slightly
     arxiv_ex_docs[, 2] + 0.03,        #<- point labels y-coordinates shifted slightly
     rownames(arxiv_ex_docs))          #<- text labels for points

#================================================-
#### Question 6 ####

# Create a data frame of unique nodes. 
# Create a data frame of edges and keep only those having score > 0.75. 
# Rename the columns to match the network graph syntax.
# Construct the network visualization.

# Answer:
# Create a data frame of unique nodes.
arXiv_ex_doc_nodes = data.frame(id = meta(arxiv_exercise_corpus_clean)$id,
                                label = meta(arxiv_exercise_corpus_clean)$id,   #<- node label
                                title = meta(arxiv_exercise_corpus_clean)$title,#<- node tooltip
                                stringsAsFactors = FALSE)
str(arXiv_ex_doc_nodes)

# Create a data frame of edges.
# Keep only those scores that are > 0.2.
arXiv_ex_doc_edges = arxiv_ex_weighted_doc_sim_df[arxiv_ex_weighted_doc_sim_df$cosine_sim > 0.2, ]
str(arXiv_ex_doc_edges)

# Each data with edges must have at least 
# these three columns: `from`, `to`, and `value`.
colnames(arXiv_ex_doc_edges) = c("from", "to", "value")
head(arXiv_ex_doc_edges, 5)

# Construct network visualization.
arXiv_ex_doc_sim_network = visNetwork(arXiv_ex_doc_nodes,          #<- set nodes
                                      arXiv_ex_doc_edges) %>%      #<- set edges    
  visOptions(highlightNearest = TRUE,  #<- highlight nearest when clicking on a node 
             nodesIdSelection = TRUE)  #<- add an id node selection menu 
arXiv_ex_doc_sim_network


