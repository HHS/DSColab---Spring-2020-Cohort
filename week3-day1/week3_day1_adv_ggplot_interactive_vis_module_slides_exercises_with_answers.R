#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK3 DAY1 ADV GGPLOT INTERACTIVE VIS MODULE SLIDES EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

#### Question 1 ####

# Set up data:
# Confirm your working directory. Make sure it is set to `data_dir`.
# Read in "fast_food_data.csv" to a data frame `fast_food`.
# We are going to transform `fast_food` to a long dataset `fast_food_long`.
# Select only the variables that end with "g.", BUT DO NOT start with "Serving" and 
# gather them using `key` and `value`.
# Make sure to check the data afterwards.

# Answer:
getwd() #<- check working directory
setwd(data_dir)

fast_food = read.csv("fast_food_data.csv")

fast_food_long = fast_food %>%
    select(ends_with("g."), -starts_with("Serving")) %>%   #<- select and ends_with
    gather(key = "variable", value = "value")    #<- set key and value with gather

head(fast_food_long) #<- check results

#================================================-
#### Question 2 ####

# Set up data:
# Use separate `mutate` statements to acheive the following goals:
# - Convert all strings in variable to lower case
# - Use `substr` and `nchar` to remove the last "." from `variable`
# - Remove remaining "."" from variable names. The ideal variable reads "trans_fat__g" 

# Hint: use `str_replace_all`.
# Confirm the changes in `fast_food_long`.

# Answer: 
fast_food_long = fast_food_long %>%
                 mutate(variable = tolower(variable)) %>%                        #<- lower case of characters
                 mutate(variable = substr(variable, 1, nchar(variable)-1)) %>%   #<- removes last . from the string
                 mutate(variable = str_replace_all(variable,  "[.]",  "_"))      # <- removes last .

head(fast_food_long)

#================================================-
#### Question 3 ####

# Set up & connect:
# Create a base box plot of of `fast_food_long` and save it as `ffboxplot`.

# Answer: 
ffboxplot = ggplot(fast_food_long,   #<- set the base plot and data for it
                  aes(x = variable,  #<- map each `variable` to x-axis
                      y = value)) +  #<-     `value` to be the extent of y-axis
           geom_boxplot()           #<- add boxplot geom

#================================================-
#### Question 4 ####

# Polish:
# Update the aesthetics of the box plot by filling the boxplot with color, 
# but make sure a legend for color is not included in the plot.

# Answer:
ffboxplot = ggplot(fast_food_long, 
                   aes(x = variable, 
                       y = value,
                       fill = variable)) + 
            geom_boxplot() + 
            guides(fill = FALSE)
ffboxplot

#================================================-
#### Question 5 ####

# Update `ffboxplot` by highlighting the outliers. Make them red and size 3.
# Add a title "Fast Food Data" and subtitle "Boxplot" to the plot.

# Answer:
ffboxplot = ffboxplot +                 #<- previously saved plot
  geom_boxplot(outlier.color = "red",   #<- adjust outlier color
               outlier.size = 3) +      #<- adjust outlier size
  labs(title = "Fast Food Data",
       subtitle = "Boxplot")
ffboxplot

#================================================-
#### BONUS ####

# Use the fast food data to recreate the normalized denisty plots from the class exercise,
# except use the MEAN rather than the MAX to normalize the data.
# Set up & mutate data. Create, adjust, and polish plot.
# Create the base plot `base_food_norm`.
# Then add a density plot to `base_food_norm` save it to `food_density`.
# Separate the overlapping plots into facets.
# Add a `vline` to show the mean of each normalized food element.
# Make sure the final plot does not have a legend.
# Add title "Fast food data" and subtitle "Faceted density plot".

# Answer:

# Set up and mutate data
fast_food_long = fast_food_long %>%
  group_by(variable) %>%              #<- group values by variable
  mutate(norm_value =                 #<- make `norm_value` column
           value/mean(value,          #<- calc. value: divide value by its group maximum
                     na.rm = TRUE))
fast_food_long


base_food_norm = ggplot(fast_food_long,         #<- set data for base plot
                        aes(x = norm_value,     #<-   `norm_value` -> x-axis
                            fill = variable)) 
base_food_norm


# Add density geom to base plot.
food_density = base_food_norm +          #<- base plot
               geom_density(alpha = 0.3) #
food_density

food_density = food_density +          #<- previously saved plot
               facet_wrap (~ variable, #<- wrap into facets by variable
                           ncol = 4)   #<-  set a 4-column grid
food_density

# View updated plot.
food_density

food_density = food_density + 
  geom_vline(data = fast_food_long,         
             aes(xintercept =  
                   mean(norm_value,  
                        na.rm = TRUE),    
                 color = variable),           
             linetype = "dashed", size = 1.5) +
  guides(color = FALSE, fill = FALSE) +
  labs(title = "Fast Food Data",
       subtitle = "Faceted density plot")
 

food_density



#### Exercise 2 ####
# =================================================-

#### Question 1 ####

# Create a new subset from `fast_food`, named `fast_food_sub`, 
# that selects only `Calories` and variables that end in "g.", 
# BUT NOT variables that start with "Serving" from `fast_food`.

# Answer:
fast_food_sub = fast_food %>%
  select(Calories, ends_with("g."), -starts_with("Serving")) #<- select and ends_with

#================================================-
#### Question 2 ####

# Set up & specify:
# To made a scatterplot of normalized nutritional components compared to calories,
# we need to convert `fast_food_sub` into a long dataset `FF_subset_long2`
# and normalize the nutrition components.
# This sequence of steps is essentially the same as the in-class exercise except 
# we are adding calories back on the dataset instead of `Yield`.
# Remember to pipe through the results to each next step.
# These steps should help:
# Explicitly exclude `Calories` from the gather, 
# otherwise keep the gather statement the same as in the previous exercise.
# Use the same code used previously to:
# - change the case of all letters to lower case
# - remove the last character from the end of the nutrition variables
# - replace all remaining . with _ in the variable names
# Then use the group_by & mutate statements to normalize the nutritional values, using the MEAN to normalize.
# Check the top of FF_subset_long2 to confirm you have four columns. What are those column names?
# Answer: Calories, variable, value, norm_value

FF_subset_long2 = fast_food_sub %>%
  gather(-Calories, #<- gather all variables but `Calories`
         key = "variable",                   #<-   set key to `variable`
         value = "value")%>%
  mutate(variable = tolower(variable)) %>%   #<- lower case of characters
  mutate(variable = substr(variable, 1, nchar(variable)-1)) %>%   #<- removes last . from the string
  mutate(variable = str_replace_all(variable,  "[.]",  "_")) %>%  #<- removes first . in string and replaces it with _
  group_by(variable) %>%
  mutate(norm_value = value/mean(value, na.rm = TRUE))

head(FF_subset_long2)

#================================================-
#### Question 3 ####

# Create a scatterplot named ff_inter_satter using hchart. 
# Plot the normalized values against `Calories` and set the group = variables.
# View `ff_inter_scatter`.

# Answer:
ff_inter_scatter =                #<- name the plot   
  hchart(FF_subset_long2,         #<- set data
         "scatter",               #<- make type "scatter"
         hcaes(x = norm_value,    #<- map x-axis
               y = Calories,      #<- map y-axis
               group = variable)) #<- group by


ff_inter_scatter

#================================================-
#### Question 4 ####

# Use `hc_chart` to specif zoom for `ff_inter_scatter`.
# Add a title to the plot "Fast Food Data Scatterplot"
# Do you notice any patterns in this dataset by looking at the scatterplot?
# If so, describe what you see and try to interpret it.

# Answer:
ff_inter_scatter = ff_inter_scatter %>%  
  hc_chart(zoomType = "xy") %>%                #<- use chart options to specify zoom.
  hc_title(text = "Fast Food Data Scatterplot")#<- use `hc_title` to add a title

# The `trans_fat__g` variable has a very distinct pattern, it seems like there are few 
# unique values present in this variable, which leads us to a conclusion that
# even though the data is encoded as numeric it is actually categorical data.
# Uncovering patterns like this is exactly why you should do EDA and plot your data
# before running any analyses as it may affect the output of your algorithms and models.

#================================================-
#### Question 5 ####

# Create a version of `fast_food_sub`, named `fast_food_sub2`, 
# that has has dropped all rows with NA values. 
# Then create a correlation matrix, named cor_matrix2, that includes all columns of `fast_food_sub` except Calories.
# Plot `cor_matrix2` using hcart and assign it to `correlation_interactive2`.

# Answer:
fast_food_sub2 = drop_na(fast_food_sub, "Trans.Fat..g.")
cor_matrix2 = cor(fast_food_sub2[, 2:8])
correlation_interactive2 = hchart(cor_matrix2) %>%
  hc_title(text = "Fast Food Data Correlation")

correlation_interactive2


#### Question 6 ####

# While removed NAs in the previous exercise using one method, it was not the most efficient.
# We had to manually check the summary to review the output.
# Let's replicate the method used in the class exercise and use `tidyr` to automate some of the analysis.
# Save the output of `summary(fast_food_sub)` to `ffood_summary` and a data frame object.
# Then inspect `ffood_summary`.
# Remove `Var1` from `ffood_summary` and rename the remaining columns to be "Variable" and "Summary".
# Inspect `ffood_summary` after you make those changes

# Answer: 

# Create data summary.
ffood_summary = summary(fast_food_sub)

# Save it as a data frame.
ffood_summary = as.data.frame(ffood_summary)

# Inspect the data.
head(ffood_summary)

# Remove an empty variable.
ffood_summary$Var1 = NULL

# Rename remaining columns.
colnames(ffood_summary) = c("Variable", "Summary")

# Inspect updated data.
head(ffood_summary)

#================================================-
#### Question 7 ####

# Set up:
# Replicate the transformation used in the class exercise to separate 
# the `Summary` column into two different columns.
# You want the statistic and the value to be in different columns.
# And convert the applicable data to numeric, rather than character.
# What separator will you use to split the column into two?
# Use `subset` to retain only values that are not NA.

# Answer:
# Separator should be ":" and the number of rows in the `ffood_summary` is 63

# Transformation using tidyr
ffood_summary = ffood_summary %>%          #<- set original data 
  separate(Summary,                        #<- separate `Summary` variable 
           into = c("Statistic", "Value"), #<- into 2 columns: `Statistic`, `Value`
           sep = ":",                      #<- set separating character
           convert = TRUE)                 #<- where applicable convert data (to numeric)

# Subset only rows where `Value` is not NAs.
ffood_summary = subset(ffood_summary, !is.na(Value))

#================================================-
#### Question 8 ####

# Set up & connect:
# Construct the summary chart `ffood_summary_interactive` using `hchart`.
# Add the setting that the tool tip is shared to `ffood_summary_interactive`.
# View `ffood_summary_interactive`.
# What's off about this chart? 
# What's wrong with Sodium? 
# What should we have done before summarizing the data?

# Answer: 
# Sodium looks larger than everything else because of the units of measurement. 
# We should have scaled all the data to the same scale, or transformed sodium to grams.
ffood_summary_interactive = 
  hchart(ffood_summary,           #<- set data
         "column",                #<- set type (`column` in highcharts)
         hcaes(x = Statistic,     #<- arrange `Statistics` across x-axis
               y = Value,         #<- map `Value` of each `Statistic` to y-axis
               group = Variable)) #<- group columns by `Variable`


ffood_summary_interactive = ffood_summary_interactive %>% 
  hc_tooltip(shared = TRUE) #<- `shared` needs to be set to `TRUE`

ffood_summary_interactive

#================================================-
#### Question 9 ####

# Replicate creating the boxplots with ggplot of `FF_subset_long2` from exercise 2 question 2, but use highcharter instead.
# Create an interactive boxplot called `ff_bp_interactive`.

ff_bp_interactive =  
  hcboxplot(x = FF_subset_long2$norm_value,
            var = FF_subset_long2$variable,
            name = "Normalized value")

ff_bp_interactive

#================================================-
#### Question 10 ####

# Ehance the boxplot options using `hc_plotOptions`, to color each box plot.
# Add a title to the plot "Fast Food Data Boxplot".
# View the plot.

# Answer:
# Use code from exercise in class, but replace references to data set. 

# Ehance original boxplot with some options.
ff_bp_interactive = ff_bp_interactive %>% 
  hc_plotOptions(                #<- plot options
    boxplot = list(              #<- for boxplot 
      colorByPoint = TRUE)) %>%  #<- color each box
  hc_title(text = "Fast Food Data Boxplot")

ff_bp_interactive


#### Exercise 3 ####
# =================================================-

#### Question 1 ####

# Select the `Murder` rate and `state` from the `state_df` to create `data_for_map2`.
# And rename the columns values and state.

# Answer: 
data_for_map2 = select(state_df, 
                       Murder, #<- select `Murder` to display as value on shape
                       State)  

colnames(data_for_map2) = c("value", "State") 

#================================================-
#### Question 2 ####

# Create an interactive map of murder rate by state in 1975 named `interactive_murder_map`.
# Make sure to use mapping best practices, such as a title & suffixed values.
# Use color codes "#ba3030" for max and "#f9f2f2" for `min`.

interactive_murder_map = 
  highchart(type = "map") %>% 
  hc_add_series(mapData = US_map,
                data = data_for_map2,               
                name = "Murder Rate in 1975",      
                joinBy = c("name",                 
                           "State")) %>%           
  hc_colorAxis(min = min(data_for_map2$value), 
               max = max(data_for_map2$value),
                minColor = "#f9f2f2",               
               maxColor = "#ba3030") %>% 
  hc_tooltip(valueSuffix = "%") %>%         
  hc_title(text = "US States Murder Rate (1975)")   

interactive_murder_map

#================================================-
#### Question 3 ####

# Using `saveWidget` command, save the plot to `plot_dir`
# and email it to the instructor.

# Answer:
# Set working directory to where you save plots.
setwd(plot_dir)

# Save desired interactive plot to an HTML file.
saveWidget(interactive_murder_map,            #<- plot object to save
           "interactive_muerder_map.html",    #<- name of file to where the plot is to be saved
           selfcontained = TRUE)              #<- set `selfcontained` to TRUE, so that 
                                              #   all necessary files and scripts are embedded 
                                              #   into the HTML file itself  
  


