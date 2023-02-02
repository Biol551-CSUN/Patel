### This is my first script. I am learning how to import data
### Created by: Lipi Patel
### Created on: 2023-02-02
###############################################

### Load libraries ###########
library(tidyverse)
library(here)

### Read in data ###
weightdata <- read_csv(here("Week_02","Data","weightdata.csv"))

### Data Analysis ###
head(weightdata) # Looks at the top 6 lines of the dataframe
tail(weightdata) # Looks at the bottom 6 lines of the dataframe
View(weightdata) # Opens a new window to look at the entire dataframe
glimpse(weightdata)
