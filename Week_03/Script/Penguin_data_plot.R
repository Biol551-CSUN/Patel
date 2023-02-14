### Today we are going to plot penguin data ####
### Created by: Lipi Patel ####
### Class: Week_3b ####
### Date: Feb 9, 2023 ####

#### Load Libraries ####
library(palmerpenguins)
library(tidyverse)
library(here)
library(praise)
praise()
library(beyonce)
library(ggthemes)

### Load data ######
# The data is part of the package and is called penguins
glimpse(penguins)

### Make a simple plot ####
ggplot(data=penguins, 
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species,
                     color = species)) +
  geom_point()+
  geom_smooth(method = "lm") + ### "lm" means line ###
  labs(x = "Bill depth (mm)", 
       y = "Bill length (mm)"
       ) +
###  scale_color_viridis_d() +
###  scale_x_continuous(breaks = c(14, 17, 21),
###                     labels = c("low", "medium", "high")) # set x limits from 0 to 20
# Note anytime you make a vector you need to put "c" which means "concatenate

###  scale_color_viridis_d()
###  scale_color_manual(values = c("orange", "purple", "green"))
  
  scale_color_manual(values = beyonce_palette(2)) +
#  coord_flip() # flip x and y axes
#  coord_fixed() # fix axes
#  coord_polar("x") # make the polar
#  theme_classic()
  theme_bw() +
#  theme(axis.title = element_text(size = 20,
#                                  color = "red"),
#        panel.background = element_rect(fill = "linen"))
  theme(panel.grid.major = element_line(colour = "black"))

### Save your plot ###
  ggsave(here("Week_03","Output","Penguin_data_plot.png"),
         width = 7, height = 5) # in inches)
