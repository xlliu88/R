library(tidyr)
library(tidyverse)

fruits <- c("banana",
            "coconut",
            "cucumber",
            "jujube",
            "papaya",
            "salal berry",
            "baabo")

str_view(fruits, "(.)\1\1")
str_view(fruits, "(..)\\1")
str_view(fruits, "(.)(.)\\2\\1")
str_view(fruits, "(.).\\1.\\1")
str_view(fruits, "(.)(.)(.).*\\3\\2\\1")

test_case <- c("banana", "church", "label", "eleven")
## start and end with same character
ptn <- "^(.).*\\1$"
str_view(test_case, ptn)
## contain repeated pair of letters
ptn <- "(..).*\\1"
str_view(words, ptn)
## contain one letter repeated in at least three places
ptn <- "(.).*\\1.*\\1"
str_view(test_case, ptn)


hasvowl <- str_detect(words, "[aeiou]")
sum(hasvowl)

summary(str_count(words, "[aeiou]"))
volcount <- str_count(words, "[aeiou]")

## all words start or end with "a"
ptn <- "^a|a$"
a1 <- words[str_detect(words, ptn)]
# a2 <- words[str_detect(words, "^a")]
# a3 <- words[str_detect(words, "a$")]
# all(a1 %in% c(a2, a3))
## Find all words that start with a vowel and end with a consonant
ptn <- "^[aeiou].*[^aeiou]$"
vow <- words[str_detect(words, ptn)]

## words contain at least one of each different vowel
five_vow <- words[str_detect(words, "a") &
                  str_detect(words, "e") & 
                      str_detect(words, "i") &
                      str_detect(words, "o") &
                      str_detect(words, "u")]
## highest # of vowels
vow_num <- str_count(words, "[aeiou]")
max(vow_num)
max_vow_word <- words[vow_num == max(vow_num)]

vow_prop <- vow_num/str_length(words)
max(vow_prop)
words[vow_prop == max(vow_prop)]


# extract match
colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
str_extract(sentences, colour_match)


## find all Find all words that come after a “number” like,
## “one”, “two”, “three” etc. Pull out both the number and the word
numb <- c("zero", "one", "two", "three", "four", "five", "six", "seven", 
          "eight", "nine", "ten")

num_ptn <- str_c(numb, collapse = "|")
ptn <- str_c(" (", num_ptn, ") ([^\\s]+)\\s")
num_word <- sentences %>%
    str_subset(ptn) %>%
    str_extract_all(ptn) %>%
    unlist() %>%
    str_trim()

## Find all contractions. Separate out the pieces before and after the apostrophe.
apo_ptn <- "[^\\s]+\\'[^\\s]+\\s"
sentences %>% str_subset(apo_ptn) %>% 
    str_extract(apo_ptn) %>%
    unlist() %>%
    str_trim() %>%
    str_split("\\'")

## str_replace with back referenceing
sentences %>% 
    str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
    head(5)

## Replace all forward slashes in a string with backslashes.
sentences %>% str_replace("\\/", "\\")










