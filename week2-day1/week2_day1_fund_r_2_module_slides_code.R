#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## WEEK2 DAY1 FUND R 2 MODULE SLIDES ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#=================================================-
#### Slide 8: Installing packages and loading data  ####

#install.packages("nycflights13")
library(nycflights13)


#=================================================-
#### Slide 9: Installing packages and loading data  ####

setwd(data_dir)
load("tidyr_tables.RData")



#=================================================-
#### Slide 13: Data transformation  ####

# Load the dataset and save it as 'flights' 
# It is native to r so we can load it like this
flights = nycflights13::flights	

?flights


#=================================================-
#### Slide 17: Exercise 1  ####




#=================================================-
#### Slide 20: Filter   ####

# Load the flights dataset into the environment.
data(flights)

# Filter `flights` data frame to display all records from January (month == 1) of 2013 (year == 2013).
filter(flights,      #<- set data 
       month == 1,   #<- filter by month 
       year == 2013) #<- filter by year


#=================================================-
#### Slide 21: Filter   ####

# You will have to make sure to save the subset. To do this, use `=`.
filter_flights = filter(flights, month == 1, day == 25)

# View your output.
filter_flights


#=================================================-
#### Slide 24: Filter - examples of logical operators  ####

# Filter with just `&`.
filter(flights, month == 1 & day == 25)


#=================================================-
#### Slide 25: Filter - examples of logical operators (cont...)  ####

# Filter with `!`.
filter(flights, month != 1 & day != 25)


#=================================================-
#### Slide 26: Filter - examples of logical operators (cont...)  ####

# Filter with `%in%`.
filter(flights, month %in% c(1, 2) & day == 25)


#=================================================-
#### Slide 27: Using filter with NA values  ####

# Create a data frame with 2 columns.
NA_df = data.frame(x = c(1, NA, 2),  #<- column x with 3 entries with 1 NA
                   y = c(1, 2, 3))   #<- column y with 3 entries

# Filter without specifying anything regarding NAs.
filter(NA_df, x >= 1)

# Filter with specifying to keep rows if there is an NA.
filter(NA_df, is.na(x) | x >= 1)


#=================================================-
#### Slide 29: Arrange example  ####

# Arrange data by year, then month, and then day.
arrange(flights, #<- data frame we want to arrange
        year,    #<- 1st: arrange by year
        month,   #<- 2nd: arrange by month 
        day)     #<- 3rd: arrange by day


#=================================================-
#### Slide 30: Arrange options  ####

# Arrange data by year, descending month and then day.
arrange(flights,     #<- data frame we want to arrange
        year,        #<- 1st: arrange by year
        desc(month), #<- 2nd: arrange by month in descending order
        day)         #<- 3rd: arrange by day 


#=================================================-
#### Slide 31: Arrange with NA values  ####

# Arrange data with missing values.
arrange(NA_df, x)

# Even when we use `desc` the `NA` is taken to the last row.
arrange(NA_df, desc(x))



#=================================================-
#### Slide 33: Exercise 2  ####




#=================================================-
#### Slide 36: Select a subset  ####

# Select columns from `flights` data frame.
select(flights, #<- specify the data frame
       year,    #<- specify the 1st column
       month,   #<- specify the 2nd column
       day)     #<- specify the 3rd column
# Select columns from `flights` data frame
select(flights,  #<- specify the data frame
       year:day) #<- specify the range of columns


#=================================================-
#### Slide 37: Select by excluding  ####

# Select multiple columns from `flights` data frame by providing which columns to exclude in selection
select(flights,     #<- specify the data frame
       -(year:day)) #<- specify the range of columns to exclude


#=================================================-
#### Slide 40: Mutate  ####

# Let's select columns of `flights` data frame and save them as `flights_sml`.
flights_sml = select(flights,            #<- specify data fra,e
                     year:day,           #<- specify range of columns to include
                     ends_with("delay"), #<- find all columns that end with `delay`
                     distance,           #<- select `distance` column
                     air_time)           #<- select `air_time` column
flights_sml


#=================================================-
#### Slide 41: Mutate  ####

# Add two columns `gain` and `speed` to `flights_sml`. 
mutate(flights_sml,                      #<- specify the data frame
       gain = arr_delay - dep_delay,     #<- create `gain` column by subracting depature delay 
                                         #   from arrival delay
       speed = distance / air_time * 60) #<- create `speed` from distance and air time columns


#=================================================-
#### Slide 43: Transmute Example  ####

# Add two columns `gain` and `speed` to `flights_sml`. 
example = transmute(flights_sml,                      #<- specify the data frame
       gain = arr_delay - dep_delay,     #<- create `gain` column by subracting depature delay 
                                         #   from arrival delay
       speed = distance / air_time * 60) #<- create `speed` from distance and air time columns
example


#=================================================-
#### Slide 47: Exercise 3  ####




#=================================================-
#### Slide 51: Summarise and group_by alone  ####

# Produce a summary 
summarise(flights, delay = mean(dep_delay, na.rm = TRUE)) 
# Create `by_day` by grouping `flights` by year, month, and day.
by_day = group_by(flights, year, month, day)     
by_day


#=================================================-
#### Slide 52: Summarise and group_by together  ####

# Now use grouped `by_day` data and summarise it to see the average delay by year, month and day.
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))


#=================================================-
#### Slide 54: Dplyr and the pipe: a better way  ####

delays = flights %>%                                   #<- take flights data
  group_by(dest) %>%                                   #<- group it by destination
  summarise(count = n(),                               #<- then summarize by creating count variable
            dist = mean(distance, na.rm = TRUE),       #<- and computing mean distance
            delay = mean(arr_delay, na.rm = TRUE)) %>% #<- and mean arrival delay
  filter(count > 20, dest != "HNL")                    #<- then filter it
delays


#=================================================-
#### Slide 55: Summarise and handling NAs  ####

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))
flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, 
                        na.rm = TRUE))


#=================================================-
#### Slide 57: Summarise n to count  ####

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE),  
            n = n()) #<- add a column with summary counts


#=================================================-
#### Slide 58: Summarise not needed to count  ####

flights %>% 
  count(day) #<- count number of instances of entry in `day` column


#=================================================-
#### Slide 59: Summarise rank  ####

flights %>% 
  group_by(year, month) %>% 
  summarise(first = min(dep_time, na.rm = TRUE),
            last = max(dep_time, na.rm = TRUE))


#=================================================-
#### Slide 60: Summarise position  ####

# 1. Build a subset of all flights that were not cancelled.
not_cancelled = flights %>%
  filter(!is.na(dep_time))  #<- filter flights where `dep_time` was not `NA`

# 2. Group and summarize all flights that were not calcelled to get desired results.
not_cancelled  %>%
  group_by(year, month, day) %>%   #<- group the not cancelled flights
  summarise(first = min(dep_time), #<- then summarise them by calculating the first
            last = max(dep_time))  #<- and last flights in the `dep_time` in each group


#=================================================-
#### Slide 61: Summarise distinct values  ####

# Number of flights that take off, by day.
not_cancelled  %>%
  group_by(year, month, day) %>%
  summarise(flights_that_take_off = n_distinct(dep_time)) #<- calculate distinct departure times


#=================================================-
#### Slide 62: Remember to ungroup before you regroup  ####

# Take the same `not_cancelled` data, but now group by month instead of by day.
not_cancelled %>%                                  #<- set data frame
  ungroup() %>%                                    #<- first ungroup it
  group_by(year, month) %>%                        #<- then group by year and month
  summarise(flights_by_year = n_distinct(dep_time))#<- then do the rest ...


#=================================================-
#### Slide 64: Would analysis be easy with these datasets?  ####

key_value_country
year_country
rate_country


#=================================================-
#### Slide 65: What makes data 'tidy'?  ####

tidy_country


#=================================================-
#### Slide 68: Gathering problem - colnames as values  ####

year_country


#=================================================-
#### Slide 69: Gather function example   ####

# Gather the `year_country` data frame to make it tidy.
year_country %>%          #<- set the data frame and use pipe to use it as input into `gather`
  gather(`1999`,          #<- set 1st column to gather
         `2000`,          #<- set 2nd column to gather
         key = "year",    #<- set `year` column as a key
         value = "cases") #<- set `cases` column as the values from the columns we gather


#=================================================-
#### Slide 70: Gather function: specifying a range  ####

# Gather the `year_country` data frame to make it tidy.
year_country %>%          #<- set the data frame and use pipe to use it as input into `gather`
  gather(2:3,             #<- provide a range of columns to gather
         key = "year",    #<- set `year` column as a key
         value = "cases") #<- set `cases` column as the values from the columns we gather


#=================================================-
#### Slide 72: Spreading  ####

# Let's look at `key_value_country`.
key_value_country


#=================================================-
#### Slide 73: Spread: two ways  ####

# Spread the data
# Pass data to spread with pipe.
key_value_country %>%      
  spread(key = key,      
         value = value)  

# Spread without the pipe.
# Data frame passed in.
spread(key_value_country,   
       key = key,         
       value = value)    


#=================================================-
#### Slide 74: Separating and uniting  ####

rate_country


#=================================================-
#### Slide 76: Separate  ####

# Using `rate_country` separate its `rate` column into two.
rate_country %>%                   #<- set data frame and pass it to next function with pipe           
  separate(rate,                   #<- separate `rate`
           into = c("cases",       #<- into column `cases`, and
                    "population")) #<-      column `population`


#=================================================-
#### Slide 77: Separate  ####

# Using `rate_country` separate its `rate` column into two.
rate_country %>% 
  separate(rate, 
           into = c("cases", 
                    "population"), 
           sep = "/")              #<- set the separating character to `/`


#=================================================-
#### Slide 78: Separate: sep set to index  ####

# Using `rate_country` separate its `year` column into two.
rate_country %>%
  separate(year,              #<- separate `year`
           into= c("century", #<- into two columns: `century`, and 
                   "year"),   #<-                   `year`
           sep = 2)           #<- set the separator at index = 2


#=================================================-
#### Slide 79: Separate: data type conversion  ####

# The new columns 
# are now also characters.
rate_country %>%
  separate(rate, into = c("cases", "population"))
rate_country %>%
  separate(rate, into = c("cases", "population"), convert = TRUE)


#=================================================-
#### Slide 81: Unite example  ####

# Let's separate the `rate_country`'s `year` column into `century` and `year` first.
ex_table = rate_country %>% 
  separate(year, into = c("century", "year"), sep = 2, convert = TRUE)

# Now we use `unite` to combine the two new columns back into one.
# By default, unite will combine columns using `_` so we can use `sep` to specify that we 
# do not want anything between the two columns when combined into one cell.
ex_table %>%      #<- specify the data frame to pipe into `unite`
  unite(time,     #<- set the column `time` for combined values
        century,  #<- 1st column to unite
        year,     #<- 2nd column to unite
        sep = "") #<- set the separator to an empty string 


#=================================================-
#### Slide 83: Exercise 4  ####




#######################################################
####  CONGRATULATIONS ON COMPLETING THIS MODULE!   ####
#######################################################
