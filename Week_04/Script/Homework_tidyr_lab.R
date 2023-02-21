### This is my homework from tidyr lab (Week_4B) #######
### Tidy with biogeochemistry data from Hawaii ####
### Created by: Lipi Patel #############
### Updated on: 2023-02-16 ####################

#### Load Libraries ######
library(tidyverse)
library(here)
library(ggridges)
library(beyonce)
library(ggthemes)

### Load data ######
ChemData<-read_csv(here("Week_04","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

### Remove all the NAs
ChemData_clean<-ChemData %>%
  drop_na() %>%  #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), ### separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) # keep the original tide_time column)
head(ChemData_clean)

### Filter out a subset of data (your choice)- i chose Season = FALL and Salinity greater than or equan to 34.0

ChemData_FALL<-ChemData_clean %>%
  filter(Season == "FALL" & Salinity >= 34.000000)
View(ChemData_FALL)

### use either pivot_longer or pivot_wider at least once-- i used pivot longer

ChemData_long <-ChemData_FALL %>%
  pivot_longer(cols = Salinity:TA, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values
View(ChemData_long)


ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance

######################################################################################################
### Calculate some summary statistics (can be anything) and export the csv file into the output folder

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) %>%
  pivot_longer(cols = Salinity:TA, # the cols you want to pivot. This says select the temp to percent SGD cols  
               names_to = "Variables", # the names of the new cols with all the column names 
               values_to = "Values") %>% # names of the new column with all the values 
  group_by(Variables, Site, Zone, Tide) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
  write_csv(here("Week_04","Output","summary_Homework_tidyr_lab.csv"))  # export as a csv to the right folder



### Make any kind of plot (it cannot be a boxplot) and export it into the output folder 
## Jitter plot

ChemData_long %>%
  ggplot(aes(x = Site, y = Values, color = Site))+ # assign x and y axes
  geom_point() +
  geom_jitter(width = 0.02) +
  facet_wrap(~Variables, scales = "free")

### Save your plot ##
ggsave(here("Week_04","Output","Homework_tplyr_lab.png"),
       width = 7, height = 5) # in inches)

########################################################################################################