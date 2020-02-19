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

#================================================-
#### Question 2 ####

# Read in the wiki_exercise_corpus as a term document matrix named wiki_ex_TDM.
# Observe the sparsity of the tdm.

# Answer:



#================================================-
#### Question 3 ####

# Use the removeSparseTerms function to set a maximum sparsity threshold to 0.75.
# What is the new sparsity percentage?

# Answer:


#================================================-
#### Question 4 ####

# Convert wiki_ex_TDM to a matrix called wiki_ex_TDM_matrix.
# Use the CosineSim function to compute the cosine similarity for the matrix.

# Answer:


#================================================-
#### Question 5 ####

# Convert the similarity matrix to a 'dist' object.
# Name this object wiki_ex_term_sim_half.

# Answer:


#================================================-
#### Question 6 ####

# Convert wiki_ex_term_sim_half to a tidy dataset named wiki_ex_term_sim_df.
# Rename the columns term1, term 2, and cosine_sim.
# Sort the entries by cosine_sim in descending order. Whats the pair of words
# in the 4th observation?

# Answer:


#================================================-
#### Question 7 ####

# Create a heat map of our terms in wiki_ex_term_sim_df, using term1 as x and term2 as y.
# fill by the cosine_sum value. 
# Add the my_ggtheme as shown in class.
# Rotate the text on the x-axis 90 degrees.
# Provide appropriate labels for the axes and a title.

# Answer:



#### Exercise 2 ####
# =================================================-


#### Question 1 ####

# Create a dataframe of nodes named wiki_ex_nodes.
# Then, create a dataframe of edges, wiki_ex_edges, where the cosine_sim value 
# is greater than 0.75.
# Change the column names of the wiki_ex_edges to "from", "to", and "value".

# Answer:


#================================================-
#### Question 2 ####

# Construct a network visualization using wiki_ex_nodes and wiki_ex_edges.
# Make sure to set highilightNearest = T and nodesIdSelection = T.

# Answer:



#================================================-
#### Question 3 ####

# Create a DTM matrix named wiki_ex_DTM_matrix which is the transpose of wiki_ex_TDM_matrix.
# Next, create a cosine similarity matrix using the CosineSim function and the wiki_ex_TDM_matrix.
# Name this matrix wiki_ex_doc_sim.

# Answer:



#================================================-
#### Question 4 ####

# Change the colnames and rownames of wiki_ex_doc_sim to the heading of the metadata
# from wiki_exercise_corpus_clean, similar to how it was conducted in class.
# Create a tidy dataframe, wiki_ex_doc_sim_df, which is a tidy object of the distance object
# of wiki_ex_doc_sim.
# Rebane the columns "doc1", "doc2", and "cosine_sim" and arrange in descending order
# of cosine sum.

# Answer:




#================================================-
#### Question 5 ####

# Create a heat map of our terms in wiki_ex_doc_sim_df, using doc1 as x and doc2 as y.
# fill by the cosine_sum value. 
# Add the my_ggtheme as shown in class.
# Rotate the text on the x-axis 90 degrees.
# Provide appropriate labels for the axes and a title.

# Answer:



#================================================-
#### Question 6 ####

# Create a dataframe of nodes named wiki_ex_doc_nodes which has ID the column names
# of wiki_ex_doc_sim.
# Then, create a dataframe of edges from wiki_ex_doc_sim_df with 
# only cosine_sum values greater than 0.15. Rename these columns to "from", "to", and "value".
# Finally, create a visual network with the nodes and edges, with 
# highlightNearest = TRUE and nodesIdSelection = TRUE.

# Answer:



#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Create a TF-IDF weighting DTM for wiki_exercise_corpus_clean 
# and name it as wiki_ex_DTM_weighted.

# Answer:



#================================================-
#### Question 2 ####

# Remove the Sparse Terms from wiki_ex_DTM_weighted by setting sparse = 0.75
# Inspect the wiki_ex_DTM_weighted

# Answer:



#================================================-

#### Question 3 ####

# Convert the DTM as matrix and calculate the cosine similarity of documents 
# in wiki_exercise_corpus_clean and name it as wiki_ex_weighted_doc_sim.
# Rename the columns and rows of similarity matrix.View the wiki_ex_weighted_doc_sim.

# Answer:




#================================================-
#### Question 4 ####

# Tidy up the matrix to convert it to a data frame and rename the columns. Also, sort rows by scores of decreasing order.

# Answer:




#================================================-
#### Question 5 ####

# Compare the similarity scores between wiki_ex_doc_sim_df and wiki_ex_weighted_doc_sim_df.

# Answer:




#================================================-
#### Question 6 ####

# Create a heatmap of wiki_ex_weighted_doc_sim_df and compare with the 
# heatmap of wiki_ex_doc_sim_df.

# Answer:




#### Exercise 4 ####
# =================================================-


#### Question 1 ####
# Compute the cosine distance between the wiki docs and save it 
# as a `dist` object named wiki_ex_weighted_doc_dist. 
# Scale the distance matrix to a 2D space.

# Answer:



#================================================-
#### Question 2 ####

# Plot the documents on to the x-y plane.

# Answer:



#================================================-
#### Question 3 ####

# Create a weighted DTM with TF-IDF of arxiv articles called as arxic_ex_DTM_weighted. 
# Remove the sparse terms, convert to matrix, compute the cosine similarity,
# and name it 'arvix_ex_weighted_doc_sim'.
# Tidy up the similarity matrix by naming it as 'arxiv_ex_weighted_doc_sim_df'.
# Rename the columns from the data frame.
# Sort data by descending similarity.

# Answer:




#================================================-
#### Question 4 ####

# Plot the similarity data of arxiv_ex_weighted_doc_sim_df on a heatmap.

# Answer:




#================================================-
#### Question 5 ####

# Compute the cosine distance by naming it as arxiv_ex_docs and scale the arxiv_document_data and view the head. Plot arxiv_documents on the x-y plane.

# Answer:




#================================================-
#### Question 6 ####

# Create a data frame of unique nodes. 
# Create a data frame of edges and keep only those having score > 0.75. 
# Rename the columns to match the network graph syntax.
# Construct the network visualization.

# Answer:



