### Week_5b: Data wrangling: lubridate dates and times ###
### Date: 2023-02-23 ###
### Created by: Lipi Patel ###

### Load the libraries 

library(tidyverse)
library(here)
library(lubridate)

now() #what time is it now?

now(tzone = "EST") # what time is it on the east coast

now(tzone = "GMT") # what time in GMT

today() # If you only want the date and not the time

today(tzone = "GMT") # Specific time zone

am(now()) # is it morning?

leap_year(now()) # is it a leap year?

### These will all produce the same results as ISO dates

ymd("2021-02-24")
mdy("02/24/2021")
mdy("February 24 2021")
dmy("24/02/2021")

### Date and Time specifications with lubridate

ymd_hms("2021-02-24 10:22:20 PM")
mdy_hms("02/24/2021 22:22:20")
mdy_hm("February 24 2021 10:22 PM")

### Extracting specific date or time elements from datetimes

# make a character string
datetimes<-c("02/24/2021 22:22:20",
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")

# convert to datetimes ## Extract the months from the character string.
datetimes <- mdy_hms(datetimes) 

month(datetimes)
month(datetimes, label = TRUE, abbr = FALSE) #Spell it out (february)


### Let's make a vector of dates and covert them to datetimes. Extract the days.

# make a character string
datetimes<-c("02/24/2021 22:22:20", 
             "02/25/2021 11:21:10", 
             "02/26/2021 8:01:52") 

# convert to datetimes
datetimes <- mdy_hms(datetimes) 
month(datetimes, label = TRUE, abbr = FALSE) #Spell it out

day(datetimes) # extract day

wday(datetimes, label = TRUE) # extract day of week

hour(datetimes)
minute(datetimes)
second(datetimes)

### Adding dates and times

datetimes + hours(4) # this adds 4 hours

### Notice the s in hours
### hour() extracts the hour component from a time and hours() is used to add hours to a datetime

datetimes + days(2) # this adds 2 days

### day() extracts the hour component from a time and days() is used to add hours to a datetime


### Rounding dates
round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minute

#Think, pair, share
#Read in the conductivity data (CondData.csv) and convert the date column to a datetime. 
#Use the %>% to keep everything clean.

#This is temperature and salinity data taken at a site with groundwater while being dragged behind a float. 
#Data were collected every 10 seconds. 
#You will also notice depth data. 
#That dataset will be used later during lab. 
#Those data are taken from a pressure sensor, also collected data every 10 seconds.

# read in data
CondData<-read_csv(here("Week_05","data","CondData.csv")) %>%
  mutate(Date = mdy_hm(Date))
View(CondData)


# Today's totally awesome R package
# Ever wanted to plot with cats? Now you can with {catterplots}!
library(devtools)
library(CatterPlots)

x <-c(1:10)# make up some data
y<-c(1:10)
catplot(xs=x, ys=y, cat=3, catcolor='blue')

######################################################################################