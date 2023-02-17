library(palmerpenguins)
library(tidyverse)
library(here)

glimpse(penguins)
head(penguins)
## filter(.data = penguins, sex == "female" )
## filter(.data = penguins, sex == "female" & body_mass_g >5000)

filter(.data = penguins, year == "2008" | year == "2009")
filter(.data = penguins, year %in% c("2008", "2009"))

filter(.data = penguins, 
       island!= "Dream")

filter(.data = penguins, 
       species == "Adelie" | species == "Gentoo")
filter(.data = penguins, species %in% c("Adelie", "Gentoo"))
filter(.data = penguins, species != "Chinstrap")

### mutate my data
data2<-mutate(.data = penguins,
             body_mass_kg = body_mass_g/1000,
            bill_length_depth = bill_length_mm/bill_depth_mm)
# convert mass to kg 
# calculate the ratio of bill length to depth

View(data2)

### mutate with ifelse
data2<- mutate(.data = penguins,
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"))
View(data2)

### 1. Use mutate to create a new column to add flipper length and body mass together
data2<- mutate(.data = penguins,
               Flipper_body_together = flipper_length_mm + body_mass_g)
View(data2)

### 2. Use mutate and ifelse to create a new column where body mass greater than 4000 is labeled as big and everything else is small
data2<- mutate(.data = penguins,
               size = ifelse(body_mass_g > 4000, "big", "small"))
View(data2)


### pipe
penguins %>% # use penguin dataframe
  filter(sex == "female") #select females
  mutate(log_mass = log(body_mass_g)) #calculate log biomass
  select(Species = species, island, sex, log_mass)

penguins %>% # 
  group_by(island, sex) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),
            min_flipper = min(flipper_length_mm, na.rm=TRUE))

### How to drop NAs 
penguins %>%
  drop_na(sex)
  group_by(island, sex) %>%
  summarise(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +
  geom_boxplot()

library(devtools) # load the development tools library
devtools::install_github("jhollist/dadjokeapi")  

library(dadjoke)
dadjoke()