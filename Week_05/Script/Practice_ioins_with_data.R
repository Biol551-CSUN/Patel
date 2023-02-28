### Today we are going to practice joins with data from Becker and Silbiger (2020) ####
### Created by: Dr. Nyssa Silbiger #############
### Updated on: 2023-02-21 ####################

#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######
# Environmental data from each site
EnviroData<-read_csv(here("Week_05","data", "site.characteristics.data.csv"))

#Thermal performance data
TPCData<-read_csv(here("Week_05","data","Topt_data.csv"))

glimpse(EnviroData)
glimpse(TPCData)
# also use View()
View(EnviroData)
View(TPCData)

EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured,
              values_from = values)
View(EnviroData_wide)

EnviroData_wide <- EnviroData %>% 
  pivot_wider(names_from = parameter.measured, # pivot the data wider
              values_from = values) %>%
  arrange(site.letter) # arrange the dataframe by site
View(EnviroData_wide)

FullData_left<- left_join(TPCData, EnviroData_wide)
## Joining with by = join_by(site.letter)
head(FullData_left)

FullData_left<- left_join(TPCData, EnviroData_wide) %>%
  relocate(where(is.numeric), .after = where(is.character)) # relocate all the numeric data after the character data

## Joining with by = join_by(site.letter)
head(FullData_left)

#### Think, Pair, Share

EnviroData_long <- fulldata_leftData %>% 
  pivot_longer(names_from = parameter.measured,
               values_from = values)
View(EnviroData_long)



##### tibble #####

# Make 1 tibble
T1 <- tibble(Site.ID = c("A", "B", "C", "D"), 
             Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

# make another tibble
T2 <-tibble(Site.ID = c("A", "B", "D", "E"), 
            pH = c(7.3, 7.8, 8.1, 7.9))
T2

left_join(T1, T2)
