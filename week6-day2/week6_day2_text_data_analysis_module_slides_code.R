#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK6 DAY2 TEXT DATA ANALYSIS MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 6: Load packages  ####

# Load `tm` library.
library(tm)

# Load tidyverse.
library(tidyverse)
library(broom)

# Install `visNetwork` package.
# install.packages("visNetwork")
library(visNetwork)


#=================================================-
#### Slide 7: Load  nwiki and arXiv corpus  ####

# Set working directory to `data_dir`.
setwd(data_dir)
# Load wiki corpus.
load("wiki_corpus_clean.RData")


#=================================================-
#### Slide 13: Removing sparse terms in wiki corpus  ####

# Construct a term document matrix.
wiki_TDM = TermDocumentMatrix(wiki_corpus_clean)
wiki_TDM

# Remove sparse terms from a TDM.
wiki_TDM = removeSparseTerms(wiki_TDM,     
                             sparse = 0.75) 
wiki_TDM


#=================================================-
#### Slide 19: Cosine similarity function  ####

# Cosine similarity function.
CosineSim = function(x){
  sums_of_squares = rowSums(x ^ 2)
  sim = tcrossprod(x) / sqrt(tcrossprod(sums_of_squares))
  
  return(sim)
}


#=================================================-
#### Slide 20: Measuring similarity of terms  ####

# Convert `TDM` object to a matrix.
wiki_TDM_matrix = as.matrix(wiki_TDM)

# Compute cosine similarity for TDM matrix.
wiki_term_sim = CosineSim(wiki_TDM_matrix)

# Take a look at the structure of the matrix.
str(wiki_term_sim)


#=================================================-
#### Slide 23: Term similarity matrix: convert to dist  ####

# Convert similarity matrix to a `dist` object to keep only half of its entries.
wiki_term_sim_half = as.dist(wiki_term_sim)
str(wiki_term_sim_half)


#=================================================-
#### Slide 25: Tidy dist object  ####

# Tidy takes an object of class `dist` and 
# converts it to a tidy data frame with 3 columns.
wiki_term_sim_df = tidy(wiki_term_sim_half)
head(wiki_term_sim_df)

# Rename columns.
colnames(wiki_term_sim_df) = c("term1", "term2", "cosine_sim")
head(wiki_term_sim_df)


#=================================================-
#### Slide 26: Arrange term pairs by similarity scores  ####

# Sort entries by decreasing similarity.
wiki_term_sim_df = arrange(wiki_term_sim_df, desc(cosine_sim))
head(wiki_term_sim_df)
tail(wiki_term_sim_df)


#=================================================-
#### Slide 28: Prepare for plotting: save ggplot theme  ####

# Save our custom `ggplot` theme to a variable.
my_ggtheme = theme_bw() +                     
  theme(axis.title = element_text(size = 18),
        axis.text = element_text(size = 16),
        legend.text = element_text(size = 16),              
        legend.title = element_text(size = 18),             
        plot.title = element_text(size = 22),               
        plot.subtitle = element_text(size = 18))      


#=================================================-
#### Slide 29: Visualizing term similarity: heatmap  ####

# Make a heatmap of term similarity.
wiki_term_heatmap = 
  ggplot(data = wiki_term_sim_df,#<- set data
       aes(x = term1,            #<- map term1 to x
           y = term2,            #<- map term2 to y
           fill = cosine_sim)) + #<- map scores
  geom_tile() +                  #<- makes a heatmap
  my_ggtheme +                   #<- add theme
  theme(axis.text.x =            
          element_text(angle = 90)) + #<- rotate labs
  xlab("term") +                 #<- set x-axis lab
  ylab("term") +                 #<- set y-axis lab
  labs(title = "Cosine similarity of terms",              
    subtitle = "Wiki abstract corpus of 7 documents")  
# View the heatmap.
wiki_term_heatmap


#=================================================-
#### Slide 31: Exercise 1  ####




#=================================================-
#### Slide 36: Make node data frame  ####

# Create a data frame of unique nodes.
wiki_term_nodes = data.frame(id = colnames(wiki_term_sim), #<- node data frame must an `id` column
                             stringsAsFactors = FALSE)
head(wiki_term_nodes, 5)


#=================================================-
#### Slide 37: Make edges data frame  ####

# Create a data frame of edges.
# Keep only those scores that are > 0.75.
wiki_term_edges = wiki_term_sim_df[wiki_term_sim_df$cosine_sim > 0.75, ]
head(wiki_term_edges, 5)


#=================================================-
#### Slide 38: Preparing term similarity data for network graph  ####

# Each data with edges must have at least 
# these three columns: `from`, `to`, and `value`.
colnames(wiki_term_edges) = c("from", "to", "value")
head(wiki_term_edges, 5)


#=================================================-
#### Slide 39: Visualizing term similarity: network graph  ####

# Construct network visualization.
wiki_term_sim_network = visNetwork(wiki_term_nodes,           #<- set nodes
                                   wiki_term_edges) %>%       #<- set edges    
  visOptions(highlightNearest = TRUE,  #<- highlight nearest when clicking on a node 
             nodesIdSelection = TRUE)  #<- add an id node selection menu 


#=================================================-
#### Slide 40: Visualizing term similarity: network graph  ####

# View interactive network graph.
wiki_term_sim_network


#=================================================-
#### Slide 42: Measuring similarity of documents: compute  ####

# To get a DTM matrix, we can either construct it with `DocumentTermMatix` function or
# simply transpose the TDM matrix we already have.
wiki_DTM_matrix = t(wiki_TDM_matrix)

# Compute cosine similarity on the matrix.
wiki_doc_sim = CosineSim(wiki_DTM_matrix)

# Take a look at the structure of the matrix.
str(wiki_doc_sim)


#=================================================-
#### Slide 43: Measuring similarity of documents: tidy up  ####

# Change column and row names of similarity matrix
# to headings of the corpus.
colnames(wiki_doc_sim) = names(wiki_corpus_clean)
rownames(wiki_doc_sim) = names(wiki_corpus_clean)

# Tidy up the distance object.
wiki_doc_sim_df = tidy(as.dist(wiki_doc_sim))
head(wiki_doc_sim_df, 5)

# Rename columns of the data freme.
colnames(wiki_doc_sim_df) = c("doc1", "doc2", "cosine_sim")
head(wiki_doc_sim_df, 5)


#=================================================-
#### Slide 44: Measuring similarity of documents: sort  ####

# Sort rows by descending similarity scores.
wiki_doc_sim_df = arrange(wiki_doc_sim_df, desc(cosine_sim))
head(wiki_doc_sim_df)


#=================================================-
#### Slide 45: Measuring similarity of documents: plot  ####

# Create a document similarity heatmap.
wiki_doc_heatmap = 
  ggplot(data = wiki_doc_sim_df, 
         aes(x = doc1, 
             y = doc2, 
             fill = cosine_sim)) + 
  geom_tile() + 
  my_ggtheme + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("doc") + 
  ylab("doc") + 
  labs(title = "Cosine similarity of documents",              
    subtitle = "Wiki abstract corpus of 7 documents")  


#=================================================-
#### Slide 47: Create nodes and edges data frames  ####

# Create a data frame of unique nodes.
wiki_doc_nodes = data.frame(id = colnames(wiki_doc_sim),
                            stringsAsFactors = FALSE)
head(wiki_doc_nodes, 5)

# Create a data frame of edges.
# Keep only those scores that are > 0.75.
wiki_doc_edges = wiki_doc_sim_df[wiki_doc_sim_df$cosine_sim > 0.2, ]
head(wiki_doc_edges, 5)


#=================================================-
#### Slide 48: Adjust edges data  ####

# Each data with edges must have at least 
# these three columns: `from`, `to`, and `value`.
colnames(wiki_doc_edges) = c("from", "to", "value")
head(wiki_doc_edges, 5)


#=================================================-
#### Slide 49: Visualize document similarity: network graph  ####

# Construct network visualization.
wiki_doc_sim_network = visNetwork(wiki_doc_nodes,           #<- set nodes
                                  wiki_doc_edges) %>%       #<- set edges    
  visOptions(highlightNearest = TRUE,  #<- highlight nearest when clicking on a node 
             nodesIdSelection = TRUE)  #<- add an id node selection menu 


#=================================================-
#### Slide 52: Exercise 2  ####




#=================================================-
#### Slide 59: Weighting matrices with TF-IDF  ####

# Weighting TDM with TF-IDF.
wiki_DTM_weighted = DocumentTermMatrix(wiki_corpus_clean,
                                       control = list(weighting = weightTfIdf))
wiki_DTM_weighted


#=================================================-
#### Slide 61: Remove sparse terms from weighted DTM  ####

# Remove sparse terms from the TDM.
wiki_DTM_weighted = removeSparseTerms(wiki_DTM_weighted, 
                                      sparse = 0.75)
# Inspect the DTM object.
inspect(wiki_DTM_weighted)


#=================================================-
#### Slide 62: Compute cosine similarity for weighted DTM  ####

# Save the DTM object as a matrix.
wiki_DTM_weighted_matrix = as.matrix(wiki_DTM_weighted)

# Compute cosine similarity of documents in wiki corpus.
wiki_weighted_doc_sim = CosineSim(wiki_DTM_weighted_matrix)

# Rename columns and rows of the similarity matrix.
colnames(wiki_weighted_doc_sim) = meta(wiki_corpus_clean)$heading
rownames(wiki_weighted_doc_sim) = meta(wiki_corpus_clean)$heading

View(wiki_weighted_doc_sim)


#=================================================-
#### Slide 63: Tidy up weighted similarity scores  ####

# Tidy up the matrix to convert it to a data frame.
wiki_weighted_doc_sim_df = tidy(as.dist(wiki_weighted_doc_sim))

# Rename columns.
colnames(wiki_weighted_doc_sim_df) = c("doc1", "doc2", "cosine_sim")
head(wiki_weighted_doc_sim_df)

# Sort rows by scores in decreasing order.
wiki_weighted_doc_sim_df = arrange(wiki_weighted_doc_sim_df, 
                                   desc(cosine_sim))


#=================================================-
#### Slide 64: Compare doc similarity scores: look at data  ####

head(wiki_doc_sim_df, 10)            #<- weighted with TF (i.e. original raw counts)

head(wiki_weighted_doc_sim_df, 10)   #<- weighted with TF-IDF


#=================================================-
#### Slide 65: Compare doc similarity scores: create a plot  ####

# Create a heatmap of the cosine similarity scores
# for weighted document data.
wiki_weighted_doc_heatmap = 
  ggplot(data = wiki_weighted_doc_sim_df, 
       aes(x = doc1, 
           y = doc2, 
           fill = cosine_sim)) + 
  geom_tile() + 
  my_ggtheme + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("doc") + 
  ylab("doc") + 
  labs(title = "Cosine similarity of weigthed documents",              
       subtitle = "Wiki abstract corpus of 7 documents")  


#=================================================-
#### Slide 68: Exercise 3  ####




#=================================================-
#### Slide 72: Convert similarity to distance  ####

# Compute cosine distance between wiki docs.
wiki_weighted_doc_dist = 1 - wiki_weighted_doc_sim

View(wiki_weighted_doc_dist)


#=================================================-
#### Slide 73: Convert similarity to distance and scale  ####

# Save it as a `dist` object.
wiki_weighted_doc_dist = as.dist(wiki_weighted_doc_dist)

# Scale the distance matrix to a 2-dimensional space.
wiki_docs = cmdscale(wiki_weighted_doc_dist)
wiki_docs


#=================================================-
#### Slide 74: Plotting documents onto an x-y plane  ####

# Plot documents on x-y plane.
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


#=================================================-
#### Slide 80: Load arXiv corpus  ####

# Set working directory to `data_dir`.
setwd(data_dir)

# Load corpus scraped from arXiv.org.
load("arxiv_corpus.RData")

# Load clean corpus scraped from arXiv.org.
load("arxiv_corpus_clean.RData")


#=================================================-
#### Slide 81: Explore arXiv corpus  ####

# Take a look at a short corpus summary.
arxiv_corpus

# View global corpus metadata.
View(meta(arxiv_corpus))


#=================================================-
#### Slide 82: Inspect document level metadata  ####

# Take a look at the individual document's metadata.
meta(arxiv_corpus[[1]])


#=================================================-
#### Slide 83: Look at lengths of character strings  ####

# Take a look at the number of characters in the first document.
nchar(content(arxiv_corpus[[1]]))

# Each document consists of a vector of character strings.
# Every entry in a vector was a page in the document.
# To view how many pages there are in each document, you can 
# use the `length` command.
length(content(arxiv_corpus[[1]]))


#=================================================-
#### Slide 84: Weighted DTM for arXiv articles  ####

# Create and weight DTM with TF-IDF for arxiv articles.
arxiv_DTM_weighted = DocumentTermMatrix(arxiv_corpus_clean,
                                        control = list(weighting = weightTfIdf))
arxiv_DTM_weighted


#=================================================-
#### Slide 85: Remove sparse terms + compute cosine similarity  ####

# Remove sparse terms (set threshold at 0.75).
arxiv_DTM_weighted = removeSparseTerms(arxiv_DTM_weighted, 
                                       sparse = 0.75)
arxiv_DTM_weighted

# Save it as a matrix.
arxiv_DTM_weighted_matrix = as.matrix(arxiv_DTM_weighted)

# Compute cosine similarity.
arxiv_weighted_doc_sim = CosineSim(arxiv_DTM_weighted_matrix)
str(arxiv_weighted_doc_sim)


#=================================================-
#### Slide 86: Tidy up weighted arXiv similarity data  ####

# Tidy up the similarity matrix.
arxiv_weighted_doc_sim_df = tidy(as.dist(arxiv_weighted_doc_sim))
head(arxiv_weighted_doc_sim_df)

# Rename columns of the data frame.
colnames(arxiv_weighted_doc_sim_df) = c("doc1", "doc2", "cosine_sim")
head(arxiv_weighted_doc_sim_df)


#=================================================-
#### Slide 87: Sort weighted arXiv similarity data  ####

# Sort data by descending similarity.
arxiv_weighted_doc_sim_df = arrange(arxiv_weighted_doc_sim_df, desc(cosine_sim))
head(arxiv_weighted_doc_sim_df)


#=================================================-
#### Slide 89: Visualize weighted arXiv similarity data  ####

ggplot(data = arxiv_weighted_doc_sim_df, 
       aes(x = doc1, 
           y = doc2, 
           fill = cosine_sim)) + 
  geom_tile() + 
  my_ggtheme + 
  theme(axis.text.x = element_text(angle = 90)) + 
  xlab("doc") + 
  ylab("doc") + 
  labs(title = "Cosine sim. of weigthed documents",              
       subtitle = "arXiv corpus of 36 documents") 


#=================================================-
#### Slide 90: Cosine distance of arXiv articles: scale  ####

# Compute cosine distance and scale the arxiv document data.
arxiv_docs = cmdscale(as.dist(1 - arxiv_weighted_doc_sim))

# Take a look at the result.
head(arxiv_docs)


#=================================================-
#### Slide 91: Plotting arXiv documents onto an x-y plane  ####

# Plot documents on x-y plane.
plot(arxiv_docs,                         #<- x-y coordinates
     pch = 19,                           #<- symbol type
     col = "steelblue",                  #<- color
     cex = 2,                            #<- size
     xlab = "Dim1",                      #<- x-axis label
     ylab = "Dim2",                      #<- y-axis label
     xlim = c(-0.8, 0.6),                #<- arbitrary x-axis limits
     ylim = c(-0.6, 0.6),                #<- arbitrary y-axis limits
     main = "Documents of arXiv Corpus") #<- plot title
text(arxiv_docs[, 1] + 0.05,        #<- point labels x-coordinates shifted slightly
     arxiv_docs[, 2] + 0.03,        #<- point labels y-coordinates shifted slightly
     rownames(arxiv_docs))          #<- text labels for points


#=================================================-
#### Slide 93: Create node and edge data frames for arXiv data  ####

# Create a data frame of unique nodes.
arXiv_doc_nodes = data.frame(id = meta(arxiv_corpus_clean)$id,
                             label = meta(arxiv_corpus_clean)$id,   #<- node label
                             title = meta(arxiv_corpus_clean)$title,#<- node tooltip
                             stringsAsFactors = FALSE)
str(arXiv_doc_nodes)

# Create a data frame of edges.
# Keep only those scores that are > 0.75.
arXiv_doc_edges = arxiv_weighted_doc_sim_df[arxiv_weighted_doc_sim_df$cosine_sim > 0.25, ]
str(arXiv_doc_edges)


#=================================================-
#### Slide 94: Rename edges columns  ####

# Each data with edges must have at least 
# these three columns: `from`, `to`, and `value`.
colnames(arXiv_doc_edges) = c("from", "to", "value")
head(arXiv_doc_edges, 5)


#=================================================-
#### Slide 95: Plot network graph of arXiv documents  ####

# Construct network visualization.
arXiv_doc_sim_network = visNetwork(arXiv_doc_nodes,          #<- set nodes
                                   arXiv_doc_edges) %>%      #<- set edges    
  visOptions(highlightNearest = TRUE,  #<- highlight nearest when clicking on a node 
             nodesIdSelection = TRUE)  #<- add an id node selection menu 


#=================================================-
#### Slide 96: Visualize arXiv documents in network graph  ####

# View interactive network graph.
arXiv_doc_sim_network


#=================================================-
#### Slide 98: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################

