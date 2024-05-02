# Uber Project - Avery Frick
## Link to shiny app -- (INSERT HERE)

## Code Snipets
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
![hourmonthchart](https://github.com/averyfrick/DATA_332/assets/159860783/b2bbb4dc-93bd-4d64-bb50-c4a4d2d16210)


### Trips By Hour 
```
ggplot(trips_by_hour, aes(x = Hour, y = trips_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Trips by Hour of the Day",
       x = "Hour of Day",
       y = "Number of Trips") +
  theme_minimal()

```
![tripshourchart](https://github.com/averyfrick/DATA_332/assets/159860783/a26376f9-8b16-494b-bf2e-924f3c9c3418)


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
![DOWmonthchart](https://github.com/averyfrick/DATA_332/assets/159860783/3ab3ac76-a3c3-45ef-b861-fd20ec3844ef)


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
![everydaymonthchart](https://github.com/averyfrick/DATA_332/assets/159860783/7b91549e-cc59-4476-b8dd-66da2dd7a7fa)


### Trips Per Day of the Month 
```
ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) +
  geom_col() +
  labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

```
![perdaymonthheat](https://github.com/averyfrick/DATA_332/assets/159860783/b83805fb-e746-40a9-b54e-8dc2ba9f0536)


### Trips by Month 
```
ggplot(trips_by_day, aes(x = Month, y = trips_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Trips by Month",
       x = "Month",
       y = "Number of Trips") +
  theme_minimal()
```
![monthtripschart](https://github.com/averyfrick/DATA_332/assets/159860783/f277e529-878a-4bc4-a7c4-e7598f8e2c51)


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
![basemonthchart](https://github.com/averyfrick/DATA_332/assets/159860783/deab003f-01a4-4118-9a23-5ab2903101ad)


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


![hourdayheat](https://github.com/averyfrick/DATA_332/assets/159860783/46be8679-2ada-4d99-91c0-a17be57571b7)



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

![monthweekheat](https://github.com/averyfrick/DATA_332/assets/159860783/738b0755-49b5-473f-9352-c59d753c2148)



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

![basemonthheat](https://github.com/averyfrick/DATA_332/assets/159860783/460dc87b-e8c2-4082-b7ea-c36207b37bbf)





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

![basedayheat](https://github.com/averyfrick/DATA_332/assets/159860783/4f59a2a3-c87c-48e2-aee7-bfdf67e9ade6)

