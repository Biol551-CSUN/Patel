
# Load the libraries
library(tidyverse)
library(palmerpenguins)
library(PNWColors) # for the PNW color palette

# First create a dataframe of random numbers
df <- tibble::tibble(
  a = rnorm(10), # draws 10 random values from a normal distribution
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)
head(df)

# Rescale every column individually
df<-df %>%
  mutate(a = (a-min(a, na.rm = TRUE))/(max(a, na.rm = TRUE)-min(a, na.rm = TRUE)),
         b = (b-min(b, na.rm = TRUE))/(max(b, na.rm = TRUE)-min(b, na.rm = TRUE)),
         c = (c-min(c, na.rm = TRUE))/(max(c, na.rm = TRUE)-min(c, na.rm = TRUE)),
         d = (d-min(d, na.rm = TRUE))/(max(d, na.rm = TRUE)-min(d, na.rm = TRUE)))

## What is the calculation for F to C?
# temp_C <- (temp_F - 32) * 5 / 9 (we are manipulating temp_F- should be identical)

temp_F_to_C <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5 / 9
  return(temp_C)
  }
temp_F_to_C(32)

## Write a function that converts celcius to kelvin. (Remember Kelvin is celcius + 273.15).

temp_C_to_K <- function(temp_C) {
  temp_K <- (temp_C + 273.15)
  return(temp_K)
}
temp_C_to_K(25)


myplot<-function(){
pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 

ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island))+
  geom_point()+
  geom_smooth(method = "lm")+ # add a linear model
  scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
  theme_bw()
}

# how can i make it more versatile?
myplot<-function(data, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = x, y =y , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}


# {rlang} uses what is literally called a"curly-curly" {{}} to help us assign variables 
# that are column names in dataframes.
#Let's add curly-curlies to the column names

myplot<-function(data, x, y){ 
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

myplot(data = penguins, x = body_mass_g, y = bill_length_mm)

# Let's say you want to create a default for the function to always default to the penguins dataset.

myplot<-function(data = penguins, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

# now you can just write:

myplot(x = body_mass_g, y = flipper_length_mm)

# You can also layer onto your plot using '+' just like it is a regular ggplot to change things like labels.
myplot(x = body_mass_g, y = flipper_length_mm)+
  labs(x = "Body mass (g)",
       y = "Flipper length (mm)")


## An aside on if-else statements....
# Imagine you want a variable to be equal to a certain value if a condition is met. 
# This is a typical problem that requires the if ... else ... construct.

a <- 4
b <- 5

# Suppose that if a > b then f should be = to 20, else f should be equal to 10. 
# Using if/else we:

if (a > b) { # my question
  f <- 20 # if it is true give me answer 1
} else { # else give me answer 2
  f <- 10
}

# When I type f I get...
f


## Back to plotting
# Using if...else... we can make our function even more flexible. 
# Let's say we want the option of adding the geom_smooth lines. 
# We can create a variable that if set to TRUE add the geom_smooth, otherwise print without.
# First add a new argument for lines and make the default TRUE for ease

myplot<-function(data = penguins, x, y ,lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
    geom_point()+
    geom_smooth(method = "lm")+ # add a linear model
    scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
    theme_bw()
}

### Next, add an if-else statement 
myplot<-function(data = penguins, x, y, lines=TRUE ){ # add new argument for lines
  pal<-pnw_palette("Lake",3, type = "discrete") # my color palette 
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+
      geom_smooth(method = "lm")+ ## add a linear model ##
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
  else{
    ggplot(data, aes(x = {{x}}, y = {{y}} , color = island))+
      geom_point()+ ## No linear model ##
      scale_color_manual("Island", values=pal)+   # use pretty colors and change the legend title
      theme_bw()
  }
}

# test it (with lines)
myplot(x = body_mass_g, y = flipper_length_mm)

# test it (Without lines)
myplot(x = body_mass_g, y = flipper_length_mm, lines = FALSE)
