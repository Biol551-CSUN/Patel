### This is my first ggplot (made in class-Week_3a) ###

library(palmerpenguins)
library(tidyverse)
glimpse(penguins)
ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species)) +
geom_point()+
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package")+
  scale_color_viridis_d()
