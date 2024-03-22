#import libraries 
library(tidytext)
library(textdata)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(wordcloud)
library(RColorBrewer)
library(reshape2)
library(here)

#removes objects from workpace 
rm(list=ls())

## import sentiments 
get_sentiments("bing")
get_sentiments("nrc")

## import text data 
setwd('~/Documents/Senior Year /DATA 332')
complaints<-read.csv("/Users/averyfrick/Documents/Senior Year /DATA 332/Consumer_Complaints3.csv")

#clean complaints to make it useable 
tidy_complaints <- complaints %>%
  group_by(Company)%>%
  mutate(lineNumber=row_number()) %>%
  ungroup()%>%
  unnest_tokens(word, Issue)

#joy sentiments 
nrc_joy <- get_sentiments("nrc") %>%
  filter(sentiment=="joy")

#count number of joy sentiments in complaints 
tidy_complaints%>%
  filter(Company == "Citibank") %>%
  inner_join(nrc_joy)%>%
  count(word, sort=TRUE)

#only keep companies that are Citibank 
citibank <- tidy_complaints %>%
  filter(Company== "Citibank")

#joining the data that will be charted 
bing_and_nrc<- bind_rows(
  citibank %>%
    inner_join(get_sentiments("bing"))%>%
    mutate(method="Bing et al."), 
  citibank %>%
    inner_join(get_sentiments("nrc") %>%
                 filter(sentiment %in% c("positive", 
                                         "negative"))
               
    ) %>%
    mutate(method= "NRC")) %>% 
  count(method, index=lineNumber %/% 80, sentiment) %>%
  pivot_wider(names_from = sentiment, 
              values_from = n, 
              values_fill=0) %>%
  mutate(sentiment= positive-negative)

#create the charts 
bind_rows(bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill=method)) +
  geom_col(show.legned = FALSE) +
  facet_wrap(~method, ncol=1, scales= "free_y")

#save image 
ggsave(here("Bing and nrc sentiment.png"))

#gather sentiments
get_sentiments("nrc") %>%
  filter(sentiment %in% c("positive", "negative")) %>%
  count(sentiment)

get_sentiments("bing") %>%
  count(sentiment)

#count sentiments for bing and join them 
bing_word_counts <- tidy_complaints %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort=TRUE) %>%
  ungroup()

#graphs bing 
bing_word_counts %>%
  group_by(sentiment) %>%
  slice_max(n, n=10) %>%
  ungroup() %>%
  mutate(word=reorder(word, n)) %>%
  ggplot(aes(n, word, fill=sentiment)) +
  geom_col(show.legend= FALSE) +
  facet_wrap(~sentiment, scales= "free_y")+
  labs(x= "Contribution to Sentiment", 
       y=NULL)

#save image
ggsave(here("contribution to sentiment.png"))

#creating word cloud 
tidy_complaints %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words= 100))

#save image
ggsave(here("wordcloud.png"))
