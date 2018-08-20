
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

wisdom_Tamil_data <- DocumentTermMatrix(wisdom_Tamil, control = list(weighting=weightTfIdf))
wisdom_Tamil_data

inspect(wisdom_Tamil_data[1:2, 1:5])

findFreqTerms(wisdom_Tamil_data, 0.9)

findAssocs(wisdom_Tamil_data, "mother", 0.5)

findAssocs(wisdom_Tamil_data, "father", 0.5)

findAssocs(wisdom_Tamil_data, "women", 0.5)

findAssocs(wisdom_Tamil_data, "womanhood", 0.5)

findAssocs(wisdom_Tamil_data, "women", 0.2)


findAssocs(wisdom_Tamil_data, "womanhood", 0.2)

findAssocs(wisdom_Tamil_data, "daughter", 0.2)
