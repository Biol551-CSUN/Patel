### Homework for Week_5b: Data wrangling: lubridate dates and times ###
### Date: 2023-02-23 ###
### Created by: Lipi Patel ###

### Lab
#Read in both the conductivity and depth data.
#Convert date columns appropriately
#Round the conductivity data to the nearest 10 seconds so that it matches with the depth data
#Join the two dataframes together (in a way where there will be no NAs... i.e. join in a way where only exact matches between the two dataframes are kept)
#take averages of date, depth, temperature, and salinity by minute (hint: easiest way to do this is to make a new column where the hours and minutes are extracted)
#Make any plot using the averaged data
#Do the entire thing using mostly pipes (i.e. you should not have a bunch of different dataframes). Keep it clean.
#Don't forget to comment!
#Save the output, data, and scripts appropriately

######### summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE)) # calculates mean

# Load the libraries

library(tidyverse)
library(here)
library(lubridate)
library(beyonce)


# Read in data- conductivity and depth data
CondData<-read_csv(here("Week_05","Data","CondData.csv"))

View(CondData)

DepthData<-read_csv(here("Week_05","Data","DepthData.csv"))
  
View(DepthData)

#Convert date columns appropriately. Round the conductivity data to the nearest 10 seconds 
# so that it matches with the depth data

CondData_mutated<- CondData %>%
  mutate(date = mdy_hms(date),
         date = round_date(date, "10 seconds"))

View(CondData_mutated)



DepthData_mutated <- DepthData %>%
  mutate(date = ymd_hms(date),
         date = round_date(date, "10 seconds"))

View(DepthData_mutated)

#Join the two dataframes together (in a way where there will be no NAs... 
#i.e. join in a way where only exact matches between the two dataframes are kept)

FullData_left<- left_join(CondData_mutated, DepthData_mutated)
# Joining, by = "date"

View(FullData_left)



Summarised_FullData <- FullData_left %>%
  mutate(timestamp = round_date(date, "1 minute")) %>%
  drop_na(Temperature, Serial, Salinity, AbsPressure, Depth) %>%  ## drops NA
  group_by(Temperature, Serial, Salinity, AbsPressure, Depth) %>% ## Groups by Temperature, Serial, Salinity, AbsPressure, Depth
  group_by(timestamp) %>%
  summarise(mean_Temp = mean(Temperature, na.rm = TRUE),
            mean_Salinity = mean(Salinity, na.rm = TRUE),
            mean.date = mean(date, na.rm = TRUE),
            mean_Depth = mean(Depth, na.rm = TRUE)) # calculates mean

View(Summarised_FullData)


#Make any plot using the averaged data

ggplot(data=Summarised_FullData, 
       mapping = aes(x = timestamp,
                     y = mean_Temp)) +
  geom_line() +
  labs(title = "Variation in Mean Salinity with Mean temperature", x = "Mean Salinity",
       y = "Mean Temperature") +
  scale_color_manual(values = beyonce_palette(2)) +
  theme_bw() +
  theme(panel.grid.major = element_line(colour = "black"))

### Save your plot ###
ggsave(here("Week_05","Output","Homework_Week_05.png"),
       width = 10, height = 5) # in inches)

#################################################################################