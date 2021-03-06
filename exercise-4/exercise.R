# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`
install.packages("nycflights13")
library("nycflights13")
# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
nrow(flights)
ncol(flights)
row.names(flights)
colnames(flights)
View(flights)
# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
library("dplyr")
delay_during_flight <- mutate(flights, delay_arriving = arr_delay - dep_delay) %>% 

# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
delay_during_flight <- arrange(delay_during_flight, desc(delay_arriving))

# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
delay_flight_pipe <- flights %>% 
  mutate(delay_arriving = arr_delay - dep_delay) %>% 
  arrange(desc(delay_arriving))

# Make a histogram of the amount of time gained using the `hist()` function
hist(delay_during_flight$delay_arriving)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(delay_during_flight$delay_arriving, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
jfk_sea <- delay_during_flight %>% 
  filter(origin == "JFK", dest == "SEA") %>% 
  select(origin, dest, delay_arriving)

# On average, did flights to SeaTac gain or loose time?
summarize(jfk_sea, mean = mean(delay_arriving, na.rm = TRUE))

# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)
summary <- delay_during_flight %>% 
  filter(origin == "JFL", dest == "SEA") %>% 
  summarise(
    avg_time = mean(air_time, na.rm = TRUE)
    min_time = min(air_time, na.rm = TRUE)
    max_time = max(air_time, na.rm = TRUE)
  )
