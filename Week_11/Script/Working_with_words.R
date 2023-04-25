### Lecture on working with words, Week_11 ###
### Created by: Lipi Patel ###
### Date: 2023-04-18 ###

# Load the libraries
library(here)
library(tidyverse)
library(tidytext)
library(wordcloud2)
library(janeaustenr)


words<-"This is a string"
words
# returns the exact sentence

words_vector<-c("Apples", "Bananas","Oranges")
words_vector
# returns a vector of multiple fruit types

# Paste words together
paste("High temp", "Low pH") # returns both words separated by a space distance

paste("High temp", "Low pH", sep = "-") # Add a dash in between the words

paste0("High temp", "Low pH") # Remove the space in between the words


# Working with vectors
shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes)

two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.") # This is very useful when making labels for your plots


shapes # vector of shapes
str_length(shapes) # how many letters are in each word?

# Let's say you want to extract specific characters. Do you work with sequence data? 
#This could be super useful to exact specific bases in a sequence.
seq_data<-c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA

# You can also modify strings
str_sub(seq_data, start = 3, end = 3) <- "A" # replaces an A in the 3rd position
seq_data

# You can also duplicate patterns in your strings. Here I am duplicating it 2 and 3 times
str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string

# Whitespace
# Say you have a column and you did not copy and paste your treatments like you learned in the first week of class. 
# You now have some words with extra white spaces and R thinks its an entirely new word. 
# Here is how to deal with that...
badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments

# Remove white space
str_trim(badtreatments) # this removes both

# You can also just remove from one side or the other
str_trim(badtreatments, side = "left") # this removes left

# The opposite of str_trim is str_pad, to add white space to either side
str_pad(badtreatments, 5, side = "right") # add a white space to the right side after the 5th character

# add a character instead of white space
str_pad(badtreatments, 5, side = "right", pad = "1") # add a 1 to the right side after the 5th character

# Make everything upper case
x<-"I love R!"
str_to_upper(x)

# Make it lower case
str_to_lower(x)

# Make it title case (Cap first letter of each word)
str_to_title(x)

# {stringr} has functions to view, detect, locate, extract, match, replace, and split strings based on specific patterns.
#View a specific pattern in a vector of strings.
data<-c("AAA", "TATA", "CTAG", "GCTT")
# find all the strings with an A
str_view(data, pattern = "A")

# Detect a specific pattern
str_detect(data, pattern = "A")

str_detect(data, pattern = "AT")

# Locate a pattern
str_locate(data, pattern = "AT")


#### regex
## metacharacters

# Let's say that you have the following set of strings...
vals<-c("a.b", "b.c","c.d")

# And you want to replace all the "." with a space. Here is how you would do it:
# string, pattern, replace
str_replace(vals, "\\.", " ")

# Let's say we had multiple "." in our character vector
vals<-c("a.b.c", "b.c.d","c.d.e")
#string, pattern, replace
str_replace(vals, "\\.", " ")

# str_replace only replaces the first instance. Let's try str_replace_all()
#string, pattern, replace
str_replace_all(vals, "\\.", " ")


## Sequences

# Let's subset the vector to only keep strings with digits
val2<-c("test 123", "test 456", "test")
str_subset(val2, "\\d")


## Character class

# Let's count the number of lowercase vowels in each string
str_count(val2, "[aeiou]")

# count any digit
str_count(val2, "[0-9]")


## Quantifiers

strings<-c("550-153-7578",
           "banana",
           "435.114.7586",
           "home: 672-442-6739")

phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

# Which strings contain phone numbers?


#### Think pair share

strings<-c("444.5694.92",
           "126.4971.34")

ip <- "([0-9][0-9]{2})[.]([0-9]{4})[.]([0-9]{2})"
str_detect(strings, ip)

#### Think, pair, share
# Let's clean it up. Lets replace all the "." with "-" and extract only the numbers (leaving the letters behind). 
# Remove any extra white space. You can use a sequence of pipes.

# subset only the strings with phone numbers
test<-str_subset(strings, phone)
test

clean_test <- test %>%
  str_replace_all("\\.", "-") %>%
  str_trim() %>% # this removes both 
  str_subset("\\D", "")
head(clean_test)

## tidytext
# explore it
head(austen_books())
tail(austen_books())

original_books <- austen_books() %>% # get all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # find every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # count the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% #ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
# don't try to view the entire thing... its >73000 lines...
head(original_books)


tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) # add a column named word, with the input as the text column
head(tidy_books) # there are now >725,000 rows. Don't view the entire thing!

#see an example of all the stopwords
head(get_stopwords())

cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) # dataframe without the stopwords

## Joining with by = join_by(word)
head(cleaned_books)

# Let's count the most common words across all her books

cleaned_books %>%
  count(word, sort = TRUE)

## sentiments
sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keep pos or negative words
  count(word, sentiment, sort = TRUE) # count them

# We can now use ggplot to visualize counts of positive and negative words in the books

sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")

# Use the {wordcloud} package to make an interactive word cloud

words<-cleaned_books %>%
  count(word) %>% # count all the words
  arrange(desc(n))%>% # sort the words
  slice(1:100) #take the top 100
wordcloud2(words, shape = 'triangle', size=0.3) # make a wordcloud out of the top 100 words