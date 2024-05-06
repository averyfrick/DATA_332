# Uber Project - Avery Frick
## Link to shiny app -- (INSERT HERE). Could not get the shiny app published. 

## Code Snipets and Images of Plots
### Trips by Hour and Month 
```
ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = Month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of Trips by Hour and Month",
       x = "Hour of Day",
       y = "Number of Trips",
       fill = "Month") +
  theme_minimal()

```
![hourandMonth2](https://github.com/averyfrick/DATA_332/assets/159860783/7889c31a-3f8b-44b9-9705-7c06e07f92a1)



### Trips By Hour 
```
ggplot(trips_by_hour, aes(x = Hour, y = trips_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Trips by Hour of the Day",
       x = "Hour of Day",
       y = "Number of Trips") +
  theme_minimal()

```
![hourday2](https://github.com/averyfrick/DATA_332/assets/159860783/038399b4-d918-4fa5-a797-8321dd2ed224)



### Trips by Day of the Week and Month 
```
DOW_and_Month <- uber_data %>%
  group_by(Month, Day_of_Week) %>%
  summarise(trips_count = n())

DOW_and_Month$Day_of_Week <- factor(DOW_and_Month$Day_of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"))

ggplot(DOW_and_Month, aes(x = Month, y = trips_count, fill = Day_of_Week)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Month", y = "Number of Trips", fill = "Day of the Week") +
  ggtitle("Trips by Day of the Week and Month") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

```
![weekandmonth2](https://github.com/averyfrick/DATA_332/assets/159860783/5a7060bb-779d-4d56-9fe2-93be2c6d792d)



### Trips During every day of the Month 
```
uber_data$Day_of_the_month <- day(uber_data$Date)

trips_by_day <- uber_data %>%
  group_by(Day_of_the_month, Month) %>%
  summarise(trips_count = n())

ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count)) +
  geom_line() +
  labs(title = "Number of Trips by Day of the Month",
       x = "Day of the Month",
       y = "Number of Trips") +
  theme_minimal()

```
![dayandmonth2](https://github.com/averyfrick/DATA_332/assets/159860783/0d9e5349-f414-4b72-af1b-97b54217fb86)



### Trips Per Day of the Month 
```
ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) +
  geom_col() +
  labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

```

![daymonth2](https://github.com/averyfrick/DATA_332/assets/159860783/fe5c301c-c0ec-4962-9068-1c21a91a9891)


### Trips by Month 
```
ggplot(trips_by_day, aes(x = Month, y = trips_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Trips by Month",
       x = "Month",
       y = "Number of Trips") +
  theme_minimal()
```
![month2](https://github.com/averyfrick/DATA_332/assets/159860783/198bfd70-c783-4eef-befe-cc150091e4f7)

### Trips by Bases and Month 
```
trips_by_base <- uber_data %>%
  group_by(Base, Month) %>%
  summarise(trips_count = n())

ggplot(trips_by_base, aes(x = Base, y = trips_count, fill = Month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Base", y = "Number of Trips", fill = "Month") +
  ggtitle("Trips by Bases and Month") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```
![basesmonth2](https://github.com/averyfrick/DATA_332/assets/159860783/046c65ba-3e05-4585-8ff0-b07bd0f4ecca)


## Heatmaps 
### Hour and Day 
```
trips_by_hour_day<- uber_data %>%
  group_by(Hour, Day_of_the_month) %>%
  summarise(trips_count = n())

ggplot(trips_by_hour_day, aes(x = Hour, y = Day_of_the_month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(x = "Hour of the Day", y = "Day of the Week", fill = "Number of Trips") +
  ggtitle("Trips by Hour and Day of the Week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

```


![heathourday2](https://github.com/averyfrick/DATA_332/assets/159860783/8e2e40d8-71c3-46ea-aced-f43f3b8f2e53)




### Month and Week 
```
heat_day_month <- uber_data %>%
  group_by(Month, Day_of_the_month) %>%
  summarise(trips_count = n())

ggplot(heat_day_month, aes(x = Month, y = Day_of_the_month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(x = "Week of the Year", y = "Month", fill = "Number of Trips") +
  ggtitle("Trips by Month and Week of the Year") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

```

![monthweek2](https://github.com/averyfrick/DATA_332/assets/159860783/41a28e43-99e3-4644-b814-8eda7f430251)




### Month and Day of Week 
```
heat_month_week <- uber_data %>%
  group_by(Week, Month) %>%
  summarise(trips_count = n())

## Make heat map for month and week
ggplot(heat_month_week, aes(x = Week, y = Month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(x = "Base", y = "Day of the Week", fill = "Number of Trips") +
  ggtitle("Trips by Base and Day of the Week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```

![basemonth2](https://github.com/averyfrick/DATA_332/assets/159860783/3fcb49ef-89b8-4b32-a85c-533e0d31bbed)



### Base and Day of Week 
```
base_heat<- uber_data %>%
  group_by(Base, Day_of_Week) %>%
  summarise(trips_count = n())

ggplot(base_heat, aes(x = Base, y = Day_of_Week, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(x = "Base", y = "Day of the Week", fill = "Number of Trips") +
  ggtitle("Heatmap of Base and Day of the Week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
```
![basedow2](https://github.com/averyfrick/DATA_332/assets/159860783/02629c6b-4929-45c2-870b-6c0b9220b3d3)


