### This script is a part of homework for dplyr lab ###
### Created by: Lipi Patel ###
### Date: 2023/02/14 ###

### Load the libraries ###
library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(ggplot2)
library(ggridges)

glimpse(penguins)

### Q.1 calculates the mean and variance of body mass by species, island, and sex without any NAs

penguins %>%
  drop_na(species, island, sex) %>%  ## drops NA
  group_by(species, island, sex) %>% ## Groups by Species, islands, sex
  summarise(mean_body_mass = mean(body_mass_g, na.rm = TRUE)) # calculates mean

### Q.2 filters out (i.e. excludes) male penguins, 
# then calculates the log body mass, 
# then selects only the columns for species, island, sex, and log body mass, 
# then use these data to make any plot. 
# Make sure the plot has clean and clear labels and follows best practices. 
# Save the plot in the correct output folder.

data_penguin_log<-penguins %>% # use penguin dataframe
  filter(sex == "female") %>% #select females, exclude males
  mutate(log_body_mass = log(body_mass_g)) %>% # add a new column of log of body mass
  select(species, island, sex, log_body_mass) %>% # selects these variables
  drop_na(sex, log_body_mass) # drops NA from these variables

data_penguin_log %>% # uses data_penguin_log
  drop_na(sex) %>% # drops NA from sex
  ggplot(aes(x = log_body_mass, ## makes a ggplot with given x and y axes
             y = species,
             group = species, # remember to use "group" when using density gridges2
             fill = species)) +
  geom_density_ridges2() +
  labs(x = "Species", y = "Log of Body Mass", 
       title = "Log of Body Mass in various species") + # adds labels to axes
  scale_fill_manual(values = beyonce_palette(5)) # color codes

### Save your plot ###
ggsave(here("Week_04","Output","Homework_dplyr_lab.png"),
       width = 7, height = 5) # in inches)

