### This is my homework from tidyr lab (Week_4B) #######
### Tidy with biogeochemistry data from Hawaii ####
### Created by: Lipi Patel #############
### Updated on: 2023-02-16 ####################

#### Load Libraries ######
library(tidyverse)
library(here)
library(ggridges)


### Load data ######
ChemData<-read_csv(here("Week_04","data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)


ChemData_clean<-ChemData %>%
  drop_na() %>%  #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", # separate by _
           remove = FALSE) # keep the original tide_time column)
head(ChemData_clean)


ChemData_FALL<-ChemData_clean %>%
  filter(Season == "FALL" & Salinity >= 34.000000)
View(ChemData_FALL)


ChemData_long <-ChemData_FALL %>%
  pivot_longer(cols = Salinity:TA, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values
View(ChemData_long)


ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance


ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_point() +
  geom_jitter() +
  facet_wrap(~Variables, scales = "free")
