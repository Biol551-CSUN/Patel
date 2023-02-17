### Today we are going to practice tidy with biogeochemistry data from Hawaii ####
### Created by: Lipi Patel #############
### Updated on: 2023-02-16 ####################


#### Load Libraries ######
library(tidyverse)
library(here)

### Load data ######
ChemData<-read_csv(here("Week_04","Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

ChemData_clean<-ChemData %>%
  drop_na() %>% #filters out everything that is not a complete row
  separate(col = Tide_time, # choose the tide time col
           into = c("Tide","Time"), # separate it into two columns Tide and time
           sep = "_", 
           remove = FALSE) %>% # keep the original tide_time column
  unite(col = "Site_Zone", # the name of the NEW col
        c(Site,Zone), # the columns to unite
        sep = ".", # lets put a . in the middle
        remove = FALSE) # keep the original
head(ChemData_clean)

ChemData_long <-ChemData_clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") # names of the new column with all the values
View(ChemData_long)

ChemData_long %>%
  group_by(Variables, Site) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE)) # get variance

## summarise() has grouped output by 'Variables'. You can override using the
## .groups argument.

##### Think, Pair, Share
## Calculate mean, variance, and standard deviation for all variables by site, zone, and tide
ChemData_long %>%
  group_by(Variables, Site, Zone, Tide) %>% # group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE), # get mean
            Param_vars = var(Values, na.rm = TRUE), # get variance
            Param_sd = sd(Values, na.rm = TRUE)) # get standard deviation

##### Example using facet_wrap with long data
ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables)
## we did not use proper units here

###### Create boxplots of every parameter by site, fix the axes.

###### scales = "free" releases both the x and y axes

ChemData_long %>%
  ggplot(aes(x = Site, y = Values))+ 
  geom_boxplot()+ 
  facet_wrap(~Variables, scales = "free")

##### Let's say we got data in long format and need to convert it to wide
## We use pivot_wider()

ChemData_wide<-ChemData_long %>%
  pivot_wider(names_from = Variables, # column with the names for the new columns
              values_from = Values) # column with the values
View(ChemData_wide)

###########################################################################################

ChemData_clean<-ChemData %>%
    drop_na() %>% #filters out everything that is not a complete row
    separate(col = Tide_time, # choose the tide time col
             into = c("Tide","Time"), # separate it into two columns Tide and time
             sep = "_", # separate by _
             remove = FALSE) %>%
    pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. This says select the temp to percent SGD cols  
                 names_to = "Variables", # the names of the new cols with all the column names 
                 values_to = "Values") %>% # names of the new column with all the values 
    group_by(Variables, Site, Time) %>% 
    summarise(mean_vals = mean(Values, na.rm = TRUE)) %>%
    pivot_wider(names_from = Variables, 
                values_from = mean_vals) %>% # notice it is now mean_vals as the col name
    write_csv(here("Week_04","output","summary.csv"))  # export as a csv to the right folder