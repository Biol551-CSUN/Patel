library(palmerpenguins)
library(tidyverse)
glimpse(penguins)
ggplot(penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm,
           color = species,
           )) +
  geom_point() +
  scale_color_viridis_d()+
  facet_grid(species~sex)+
  guides(color = FALSE)
