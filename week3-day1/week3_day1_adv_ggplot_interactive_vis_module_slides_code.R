#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK3 DAY1 ADV GGPLOT INTERACTIVE VIS MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 7: Set up: load tidyverse and set up ggplot2 theme  ####

# Load tidyverse library 
# (it includes ggplot2).
library(tidyverse)
# Save our custom `ggplot` theme to a variable.
my_ggtheme = theme_bw() +                     
  theme(axis.title = element_text(size = 20),
        axis.text = element_text(size = 16),
        legend.text = element_text(size = 16),              
        legend.title = element_text(size = 18),             
        plot.title = element_text(size = 25),               
        plot.subtitle = element_text(size = 18))          


#=================================================-
#### Slide 8: Set up: load dataset for EDA  ####

# Set working directory to where we store data.
setwd(data_dir)

# Read CSV file called 
#"ChemicalManufacturingProcess.csv".
CMP = 
  read.csv("ChemicalManufacturingProcess.csv",
           header = TRUE)
# View CMP dataset in the tabular data explorer.
View(CMP)


#=================================================-
#### Slide 10: Set up: subset data with select  ####

# Select variables from CMP data.
CMP_subset = select(CMP,                                           #<- set data
                    Yield:BiologicalMaterial03,                    #<- range of columns to select
                    ManufacturingProcess01:ManufacturingProcess03) #<- range of columns to select

# Inspect the first few observations in the subset.
head(CMP_subset)


#=================================================-
#### Slide 11: Set up: wide to long data conversion with gather  ####

CMP_subset_long = CMP_subset %>%
  gather(key = "variable",
         value = "value") 
# Inspect the first few observations.
head(CMP_subset_long)

# Inspect the last few observations.
tail(CMP_subset_long)


#=================================================-
#### Slide 12: Set up: data cleaning with mutate  ####

# Make names of processes and materials
# more user friendly and readable.
CMP_subset_long = CMP_subset_long %>%
  
     # Replace `Biological` with `Bio`.
     mutate(variable = 
              str_replace(variable,     #<- in column `variable`
                          "Biological", #<- replace "Biological"
                          "Bio ")) %>%  #<- with "Bio "
  
     # Replace `Manufacturing` with `Man.`.
     mutate(variable = 
              str_replace(variable, 
                          "Manufacturing", 
                          "Man. ")) %>%
  
     # Remove `0` from numbering.
     mutate(variable = 
              str_replace(variable, 
                          "0", 
                          " "))
# Inspect few first 
# entries in the data.
head(CMP_subset_long)

# Inspect few last 
# entries in the data.
tail(CMP_subset_long)


#=================================================-
#### Slide 16: Set up & link data: make boxplots  ####

# A basic box plot with pre-saved theme.
boxplots = ggplot(CMP_subset_long,   #<- set the base plot + data
                  aes(x = variable,  #<- map `variable` to x-axis
                      y = value)) +  #<- map `value` to y-axis
           geom_boxplot() +          #<- add boxplot geom
           my_ggtheme                #<- add pre-saved theme

# View plot.
boxplots


#=================================================-
#### Slide 17: Adjust: boxplot aesthetics  ####

# Make color of fill based on variable.
boxplots = ggplot(CMP_subset_long,        
                  aes(x = variable, 
                      y = value, 
                      fill = variable)) + #<- add fill to aesthetics
  geom_boxplot() + 
  my_ggtheme

# View plot.
boxplots


#=================================================-
#### Slide 18: Adjust & polish: boxplot legends  ####

# Remove redundant legend.
boxplots = boxplots + 
  labs(title = "CMP data variables", #<- add title and subtitle
       subtitle = "Boxplot of unscaled data") +
  guides(fill = FALSE)               #<- remove fill legend

# View plot.
boxplots


#=================================================-
#### Slide 19: Set up: normalize data with group_by + mutate  ####

# Normalize the CMP data.
CMP_subset_long = CMP_subset_long %>%
  group_by(variable) %>%              #<- group values by variable
  mutate(norm_value =                 #<- make `norm_value` column
           value/max(value,           #<- divide value by group max
                     na.rm = TRUE))   #<- don't forget the NAs!

CMP_subset_long


#=================================================-
#### Slide 20: Set up: make base plot with normalized data  ####

# Construct the base plot for normalized data.
base_norm_plot = ggplot(CMP_subset_long,        #<- set data
                        aes(x = variable,       #<- map `variable`
                            y = norm_value,     #<- map `norm_value`
                            fill = variable)) + #<- set fill
                 my_ggtheme                     #<- add theme

# View base plot + theme.
base_norm_plot


#=================================================-
#### Slide 21: Adjust: normalized boxplot's effects & legends  ####

# Make color of fill based on variable.
boxplots_norm = base_norm_plot +     #<- set base plot   
                geom_boxplot() +     #<- add geom
                guides(fill = FALSE) #<- remove redundant legend 

# View updated plot.
boxplots_norm


#=================================================-
#### Slide 22: Polish: normalized boxplot details  ####

# Make outliers stand out with red color and bigger size.
boxplots_norm = boxplots_norm +       #<- previously saved plot
  geom_boxplot(outlier.color = "red", #<- adjust outlier color
               outlier.size = 5) +    #<- adjust outlier size
  labs(title = "CMP data variables",  #<- add title and subtitle
       subtitle = "Boxplot of scaled data")

# View updated plot.
boxplots_norm


#=================================================-
#### Slide 23: Set up: density plot of normalized data   ####

# Let's save base plot for density as well.
base_norm_plot = ggplot(CMP_subset_long,        #<- set data
                        aes(x = norm_value,     #<- map `norm_value`
                            fill = variable)) + #<- map fill
                 my_ggtheme                     #<- add theme

# Add density geom to base plot.
density_norm = base_norm_plot +          #<- base plot
               geom_density(alpha = 0.3) #<- adjust density fill


#=================================================-
#### Slide 24: Adjust: density plot  ####

# View updated plot.
density_norm


#=================================================-
#### Slide 25: Adjust: axes of density plot  ####

# Instead of overlaying densities, split them into
# individual plots called facets.
density_norm = density_norm +          #<- previously saved plot
               facet_wrap (~ variable, #<- make facets by variable
                           ncol = 4)   #<- set a 4-column grid
# View updated plot.
density_norm


#=================================================-
#### Slide 26: Adjust: visual effects of density plot  ####

# Add a vertical reference line for mean of each variable.
density_norm = density_norm +                      
               geom_vline(data = CMP_subset_long,   #<- set data
                          aes(xintercept =          #<- set x-intercept 
                                mean(norm_value,    #<- to mean
                                     na.rm = TRUE), #<- handle NAs!  
                              color = variable),    #<- map color
                          linetype = "dashed",      #<- set line type 
                          size = 1.5)               #<- set line size
# View updated plot.
density_norm


#=================================================-
#### Slide 27: Polish: legends of density plot  ####

# Remove redundant legend.
density_norm = density_norm +        #<- previously saved plot
               guides(fill = FALSE,  #<- no legend for `fill` of density
                      color = FALSE) #<- no legend for `color` of line

# View updated plot.
density_norm


#=================================================-
#### Slide 28: Polish: text size of labels in density plot  ####

# Make adjustments to the theme: name strips of facets
# are too small, we need to increase text size.
density_norm = density_norm +                            
  theme(strip.text.x = 
         element_text(size = 14)) +    #<- set strip text size
  labs(title = "CMP data variables",   #<- add title and subtitle
       subtitle = "Density of scaled data")

# View updated plot.
density_norm


#=================================================-
#### Slide 32: Set up: transform data for scatterplot  ####

CMP_subset_long2 = CMP_subset %>%
  gather(BiologicalMaterial01:ManufacturingProcess03, #<- gather all variables but `Yield`
         key = "variable",                            #<- set key to `variable`
         value = "value") %>%                         #<- set value to `value`
  # All other transformations we've done before.
  mutate(variable = str_replace(variable, "Biological", "Bio ")) %>%
  mutate(variable = str_replace(variable, "Manufacturing", "Man. ")) %>%
  mutate(variable = str_replace(variable, "0", " ")) %>%
  group_by(variable) %>%
  mutate(norm_value = value/max(value, na.rm = TRUE))

# Inspect the data.
head(CMP_subset_long2)


#=================================================-
#### Slide 33: Set up & link: normalized data base plot  ####

# Create a base plot.
base_norm_plot = ggplot(data = CMP_subset_long2,  #<- set data 
                        aes(x = norm_value,       #<- set x-axis to represent normalized value
                            y = Yield,            #<-   y-axis to represent `Yield` 
                            color = variable)) +  #<- set color to depend on `variable`
                        my_ggtheme                #<- set theme


#=================================================-
#### Slide 34: Set up & adjust: normalized data scatterplot  ####

# Create a scatterplot.
scatter_norm = base_norm_plot +        #<- base plot
               geom_point(size = 3,    #<- add point geom with size of point = 3
                          alpha = 0.7) #<-  make it 70% opaque

# View updated plot.
scatter_norm


#=================================================-
#### Slide 35: Adjust: add density geom to scatterplot  ####

# Adjust scatterplot to include 2D density.
scatter_norm = scatter_norm +              #<- previously saved plot
               geom_density2d(alpha = 0.7) #<- add 2D density geom with 70% opaque color

# View updated plot.
scatter_norm


#=================================================-
#### Slide 36: Adjust: wrap scatterplots in facets  ####

# Wrap each scatterplot into a facet.
scatter_norm = scatter_norm +                   #<- previously saved plot
               facet_wrap(~ variable, ncol = 3) #<- wrap plots by variable into 3 columns

# View updated plot.
scatter_norm


#=================================================-
#### Slide 37: Adjust & polish: legends and text in scatterplot  ####

# Add finishing touches to the plot.
scatter_norm = scatter_norm +                        #<- previously saved plot
  guides(color = FALSE) +                            #<- remove legend for color mappings
  theme(strip.text.x = element_text(size = 14)) +    #<- increase text size in strips of facets
  labs(title = "CMP data: Yield vs. other variables",#<- add title and subtitle
       subtitle = "2D distribution of scaled data")

# View updated plot.
scatter_norm


#=================================================-
#### Slide 39: Saving plots in R: PNG exported  ####

# Set working directory 
# to where we want to save our plots.
setwd(plot_dir)

png("CMP_boxplots_norm.png",
    width = 1200, 
    height = 600, 
    units = "px")
boxplots_norm
dev.off()

png("CMP_density_norm.png",
    width = 1200, 
    height = 600, 
    units = "px")
density_norm
dev.off()

png("CMP_scatterplot_norm.png",
    width = 1200, 
    height = 600, 
    units = "px")
scatter_norm
dev.off()


#=================================================-
#### Slide 42: Saving plots in R: PDF exported  ####

# Set working directory to where you want to save plots.
setwd(plot_dir)

pdf("CMP_plots.pdf", #<- name of file
    width = 16,      #<- width in inches
    height = 8)      #<- height ...

boxplots_norm        #<- plot 1
density_norm         #<- plot 2
scatter_norm         #<- plot 3

dev.off()            #<- clear graphics device


#=================================================-
#### Slide 44: Exercise 1  ####




#=================================================-
#### Slide 46: Interactive visualizations: highcharter  ####

# Install `highcharter` package.
install.packages("highcharter")

# Load the library.
library(highcharter)

# View documentation.
library(help = "highcharter")


#=================================================-
#### Slide 52: Highcharts generic function hchart: scatter  ####

# Construct an interactive scatterplot.
scatter_interactive =              #<- name the plot   
  hchart(CMP_subset_long2,         #<- set data
         "scatter",                #<- make type "scatter"
          hcaes(x = norm_value,    #<- map x-axis
                y = Yield,         #<- map y-axis
                group = variable)) #<- group by



#=================================================-
#### Slide 53: Highcharts generic function hchart: scatter  ####

scatter_interactive


#=================================================-
#### Slide 55: Highcharts generic function hchart: scatter  ####

# Pipe chart options to original chart.
scatter_interactive = scatter_interactive %>%
  # Use chart options to specify zoom.
  hc_chart(zoomType = "xy") 

scatter_interactive


#=================================================-
#### Slide 56: Highcharts generic function hchart: scatter  ####

# Pipe chart options to original chart.
scatter_interactive = scatter_interactive %>%
 # Add title to your plot.
 hc_title(text = "CMP data: Yield vs. other variables")

scatter_interactive


#=================================================-
#### Slide 57: Correlation matrix with hchart  ####

# Compute a correlation matrix for the first 
# 4 variables in our data.
cor_matrix = cor(CMP_subset[, 1:4])

# Construct a correlation plot by 
# simply giving the plotting function
# a correlation matrix.
correlation_interactive = hchart(cor_matrix) %>%
 # Add title to your plot.
 hc_title(text = "CMP data: correlation")

correlation_interactive


#=================================================-
#### Slide 58: Summary column plot with hchart  ####

# Create data summary.
CMP_summary = summary(CMP_subset)

# Save it as a data frame.
CMP_summary = as.data.frame(CMP_summary)

# Inspect the data.
head(CMP_summary)
# Remove an empty variable.
CMP_summary$Var1 = NULL

# Rename remaining columns.
colnames(CMP_summary) = c("Variable", 
                          "Summary")
# Inspect updated data.
head(CMP_summary)


#=================================================-
#### Slide 59: Summary column plot with hchart  ####

# Separate `Summary` column into 2 columns.
CMP_summary = CMP_summary %>%              #<- set original data 
  separate(Summary,                        #<- separate `Summary` variable 
           into = c("Statistic", "Value"), #<- into 2 columns: `Statistic`, `Value`
           sep = ":",                      #<- set separating character
           convert = TRUE)                 #<- where applicable convert data (to numeric)

# Inspect the first few entries in data.
head(CMP_summary)

# Inspect total number of rows in data including NAs.
nrow(CMP_summary)


#=================================================-
#### Slide 60: Summary column plot with hchart  ####

# Inspect `Value` column for `NAs`.
which(is.na(CMP_summary$Value) == TRUE)

# Subset only rows where `Value` is not NAs.
CMP_summary = subset(CMP_summary, !is.na(Value))

# Now the number of rows should be 4 less.
nrow(CMP_summary)

# Construct the summary chart.
CMP_summary_interactive = 
  hchart(CMP_summary,             #<- set data
         "column",                #<- set type (`column` in highcharts)
         hcaes(x = Statistic,     #<- arrange `Statistics` across x-axis
               y = Value,         #<- map `Value` of each `Statistic` to y-axis
               group = Variable)) #<- group columns by `Variable`



#=================================================-
#### Slide 61: Summary column plot with hchart  ####

CMP_summary_interactive


#=================================================-
#### Slide 62: Summary column plot with hchart  ####

# Adjust tooltip options by piping `hc_tooltip` to base plot.
CMP_summary_interactive = CMP_summary_interactive %>% 
  hc_tooltip(shared = TRUE)  %>%               #<- `shared` needs to be set to `TRUE`
  hc_title(text = "CMP data variable summary") #<- add title to your plot



#=================================================-
#### Slide 63: Summary column plot with hchart  ####

CMP_summary_interactive


#=================================================-
#### Slide 65: Highcharts boxplot: hcboxplot  ####

# Construct an interactive boxplot.
boxplot_interactive =  
  hcboxplot(x = CMP_subset_long$norm_value,
            var = CMP_subset_long$variable,
            name = "Normalized value") %>%
  hc_title(text = "CMP data variables")
boxplot_interactive


#=================================================-
#### Slide 68: Highcharts boxplot: hcboxplot  ####

# Ehance original boxplot with some options.
boxplot_interactive = boxplot_interactive %>% 
  hc_plotOptions(   #<- plot options
    boxplot = list(     #<- for boxplot 
      colorByPoint = TRUE)) #<- color each box
boxplot_interactive


#=================================================-
#### Slide 70: Exercise 2  ####




#=================================================-
#### Slide 73: Datasets in R: state.x77 data  ####

# Late's take a look at `state.x77` dataset.
View(state.x77)
class(state.x77)


#=================================================-
#### Slide 74: Datasets in R: state.x77 data  ####

# This dataset is of type `matrix`. We don't want to modify the original dataset,
# so let's set this dataset to a variable, so that we can manipulate it freely.
state_data = state.x77

# The dataset contains 50 rows (i.e. 50 states) and 8 columns.
# It's easy to check the dimensions of any object in R with a simple `dim` function.
dim(state_data)

# Since matrix is a 2-dimensional object we get a vector with 2 entries:
# 1. The first one corresponds to the number of rows
dim(state_data)[1]

# 2. The second tells us how many columns we have
dim(state_data)[2]


#=================================================-
#### Slide 75: Converting a matrix into a data frame  ####

# 1. We need to convert our matrix to a data frame.
state_df = as.data.frame(state_data)
class(state_df)
str(state_df)


#=================================================-
#### Slide 76: Adding a column to a data frame  ####

# 2. The names of the rows of the dataframe will now become a column `State`. 
state_df$State = rownames(state_df)  #<- to add a named column to a data frame, we can use the
                                     #   `$` operator followed by the name of the column.
str(state_df)


#=================================================-
#### Slide 77: Reset row names of a data frame to indices  ####

# Take a look at the 
# current data frame that 
# contains the row names.
View(state_df)

# Reset row names to their default values 
# (i.e. indices of rows).
rownames(state_df) = NULL
View(state_df)


#=================================================-
#### Slide 79: Working with GEO data and JSON files: jsonlite  ####

# Install `jsonlite` package.
install.packages("jsonlite")

# Load the library.
library(jsonlite)

# View documentation.
library(help = "jsonlite")

?fromJSON


#=================================================-
#### Slide 80: Working with GEO data and JSON files: jsonlite  ####

# Set working directory to data folder.
setwd(data_dir)

# Read data from JSON file, don't simplify vectors.
US_map = fromJSON("us-all.geo.json", simplifyVector = FALSE)


#=================================================-
#### Slide 81: Creating an interactive population map  ####

# Create an interactive map.
interactive_population_map = 
  highchart(type = "map") %>%    #<- base plot 
  hc_add_series(mapData = US_map)#<- map series

interactive_population_map


#=================================================-
#### Slide 82: Preparing map data  ####

# To see what metadata is available in the `geo.json` use `get_data_from_map` function.
geodata = get_data_from_map(US_map)

str(geodata)


#=================================================-
#### Slide 84: Preparing map data  ####

# Select columns to display on map.
data_for_map = select(state_df, 
                      Population, #<- select `Population` to display as value on shape
                      State)      #<- select `State` to join this data with map data

# Rename columns: `Population` -> `value`, because highcharts needs a column 
# called `value` to attach it to shape.
colnames(data_for_map) = c("value", "State") 

# Adjust data (divide population by 1000, to make units in millions).
data_for_map$value = data_for_map$value/1000
head(data_for_map)


#=================================================-
#### Slide 86: Creating an interactive population map  ####

interactive_population_map = 
  highchart(type = "map") %>% 
  
  hc_add_series(mapData = US_map,
                data = data_for_map,               #<- data to plot on shapes
                name = "Population in 1975",       #<-  series name is `Population`
                joinBy = c("name",                 #<-  join by `name` property in `mapData`
                           "State")) %>%           #<-    with `State` column in `data`
  
  hc_colorAxis(min = min(data_for_map$value),      #<- set colors: min value => minimum population
               max = max(data_for_map$value),      #<-  max value => maximum population
               minColor = "#CCCCFF",               #<-  min value color
               maxColor = "#000066") %>%           #<-  max value color
  
  hc_tooltip(valueSuffix = " million") %>%         #<- set value suffix in the tooltip
  
  hc_title(text = "US States Population (1975)")   #<- set plot title


#=================================================-
#### Slide 87: Creating an interactive population map  ####

interactive_population_map


#=================================================-
#### Slide 88: Saving interactive plots with htmlwidgets  ####

# Install `htmlwidgets` package.
install.packages("htmlwidgets")

# Load the library.
library(htmlwidgets)

# View documentation.
library(help = "htmlwidgets")


#=================================================-
#### Slide 90: Saving interactive plots with htmlwidgets  ####

# Set working directory to where you save plots.
setwd(plot_dir)

# Save desired interactive plot to an HTML file.
saveWidget(interactive_population_map,        #<- plot object to save
           "interactive_population_map.html", #<- name of file to where the plot is to be saved
           selfcontained = TRUE)              #<- set `selfcontained` to TRUE, so that 
                                              #   all necessary files and scripts are embedded 
                                              #   into the HTML file itself  


#=================================================-
#### Slide 92: Exercise 3  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
