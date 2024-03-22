# Consumer Complaints- Citibank

I had a very hard time at the beggining of the project. I was trying too hard to copy the code from the class exmaple instead of thinking about what needed to be done. I also was focused on the big picture instead of one step at a time. 


The following code I kept trying to change and put my own word in replace of joy...

joy sentiments 
nrc_joy <- get_sentiments("nrc") %>%
  filter(sentiment=="joy")


Once I picked one bank to focus on it solved a lot of errors and got me rolling...
citibank <- tidy_complaints %>%
  filter(Company== "Citibank")


A major roadblock I had was there being a many to many relationship when I was trying to join data. By getting the above (nrc_joy and picking citibank) I was able to join without there being an error. 

tidy_complaints%>%
  filter(Company == "Citibank") %>%
  inner_join(nrc_joy)%>%
  count(word, sort=TRUE)


Once I got through these problems I was confident creating the charts, plotting, and saving. 

## Sentiment for bing and nrc
### Shows the positive and negative distrubution for each sentiment on a line graoh 
![Bing and nrc sentiment](https://github.com/averyfrick/DATA_332/assets/159860783/cbecb365-1381-471d-9523-0f742a1bb7b6)

# Contribution to Sentiment 
## Bar chart that seperates negative and positive and is color coded based on sentiment. It picked a few words and shows how much that word appears 
![contribution to sentiment](https://github.com/averyfrick/DATA_332/assets/159860783/db91780b-e078-4740-a2dd-3c33d8c0c611)

# Wordcloud 
## Picks 100 words that are related to banking and Citibank these words are both positive and negative 
![wordcloudSentiment](https://github.com/averyfrick/DATA_332/assets/159860783/5a512bd5-d638-4caf-8626-f6df0452a6cb)
