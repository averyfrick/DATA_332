# Uber Project 
## Link to shiny app 

## Code Snipets

```
ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = Month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of Trips by Hour and Month",
       x = "Hour of Day",
       y = "Number of Trips",
       fill = "Month") +
  theme_minimal()

``` 
