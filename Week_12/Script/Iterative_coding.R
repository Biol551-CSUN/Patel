# load the libraries
library(tidyverse)
library(here)

print(paste("The year is", 2000))

years<-c(2015:2021)
for (i in years){ # set up the for loop where i is the index
  print(paste("The year is", i)) # loop over i
}

#Pre-allocate space for the for loop
# empty matrix
year_data<-data.frame(matrix(ncol = 2, nrow = length(years)))
# add column names
colnames(year_data)<-c("year", "year_name")
year_data

# Add the for loop
for (i in 1:length(years)){ # set up the for loop where i is the index
  year_data$year_name[i]<-paste("The year is", years[i]) # loop over year
  year_data$year[i]<-years[i] # loop over year
}
year_data

testdata<-read_csv(here("Week_12", "Data","cond_data", "011521_CT316_1pcal.csv"))
glimpse(testdata)

# point to the location on the computer of the folder
CondPath<-here("Week_12", "Data", "cond_data")
# list all the files in that path with a specific pattern
# In this case we are looking for everything that has a .csv in the filename
# you can use regex to be more specific if you are looking for certain patterns in filenames
files <- dir(path = CondPath,pattern = ".csv")
files


1:10 %>% # list 1:10 
  map(function(x) rnorm(15, x)) %>% # make your own function
  map_dbl(mean)

1:10 %>%
  map(~ rnorm(15, .x)) %>% # changes the arguments inside the function
  map_dbl(mean)

# pre-allocate space
# make an empty dataframe that has one row for each file and 3 columns
cond_data<-data.frame(matrix(nrow = length(files), ncol = 3))
# give the dataframe column names
colnames(cond_data)<-c("filename","mean_temp", "mean_sal")
cond_data

raw_data<-read_csv(paste0(CondPath,"/",files[i])) # test by reading in the first file and see if it works
head(raw_data)

for (i in 1:length(files)){ # loop over 1:3 the number of files 
  raw_data<-read_csv(paste0(CondPath,"/",files[i]))
  glimpse(raw_data)
}


# Bring in files using purrr instead of a for loop
# Reminder: find the files

# point to the location on the computer of the folder
CondPath<-here("Week_12", "Data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
files
## [1] "011521_CT316_1pcal.csv" "011621_CT316_1pcal.csv" "011721_CT354_1pcal.csv"

# # point to the location on the computer of the folder
CondPath<-here("Week_12", "data", "cond_data")
files <- dir(path = CondPath,pattern = ".csv")
read.csv()