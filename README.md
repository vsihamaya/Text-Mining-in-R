Thirukkural (Tamil: திருக்குறள், literally Sacred Verses), or shortly the Kural, is a classic Tamil text consisting of 1,330 couplets or Kurals, dealing with the everyday virtues of an individual. Considered one of the greatest works ever written on ethics and morality, chiefly secular ethics, it is known for its universality and non-denominational nature.

# Text-Mining-in-R
#thirukkural text - explore biases

#load packages
library(tidyverse)
library(tm)

#importing the text file
text <- readLines(file.choose())

#load the data as a corpus
wisdomTamil <- Corpus(VectorSource(text))

#pre-processing applied to corpus using the function tm_map()
wisdom_Tamil <- wisdomTamil %>%
  tm_map(removePunctuation) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords("en")) %>%
  tm_map(removeWords, c("translation", "explanation")) %>%
  tm_map(stripWhitespace) %>%
  tm_map(stemDocument)

#view the document
content(wisdom_Tamil)

#DocumentTermMatrix() used to create feature representations
#TF-IDF integrates term frequency with inverse document freq that tries to measure info brought by each term
wisdom_Tamil_data <- DocumentTermMatrix(wisdom_Tamil, control = list(weighting=weightTfIdf))
wisdom_Tamil_data

inspect(wisdom_Tamil_data[1:2, 1:5])

findFreqTerms(wisdom_Tamil_data, 0.9)

#findAssocs() allows you to specify a term and correlation threshold
#returns the terms in the document collection that have a correlation with the supplied term higher than the threshold

findAssocs(wisdom_Tamil_data, "daughter", 0.2)

#RESULTS: 

> findAssocs(wisdom_Tamil_data, "mother", 0.5)
$mother
numeric(0)

> findAssocs(wisdom_Tamil_data, "father", 0.5)
$father
son 
0.5 

> findAssocs(wisdom_Tamil_data, "women", 0.5)
$women
numeric(0)

> findAssocs(wisdom_Tamil_data, "womanhood", 0.5)
$womanhood
numeric(0)

> findAssocs(wisdom_Tamil_data, "women", 0.2)
$women
 singleheart       corps  goldbracelet     treacher
       0.34        0.25         0.25           0.23 
       
> findAssocs(wisdom_Tamil_data, "womanhood", 0.2)
$womanhood
manhood   devic  behest   obedi   woman  modest 
   0.43    0.40    0.31    0.27    0.25    0.21 

> findAssocs(wisdom_Tamil_data, "woman", 0.3)
$woman
chastiti  garland 
    0.31     0.30 
    
> findAssocs(wisdom_Tamil_data, "daughter", 0.2)
$daughter
numeric(0)
