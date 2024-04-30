library(dplyr)
library(lubridate)
library(tidyr)
library(ggplot2)
library(shiny)



setwd('~/Documents/Senior Year /DATA 332/UberProject')

## Improt Data
uber1 <- read.csv('uber-raw-data-apr14.csv')
uber2 <- read.csv('uber-raw-data-aug14.csv')
uber3 <- read.csv('uber-raw-data-jul14.csv')
uber4 <- read.csv('uber-raw-data-jun14.csv')
uber5 <- read.csv('uber-raw-data-may14.csv')
uber6 <- read.csv('uber-raw-data-sep14.csv')



## Bind the data together
uber_data <- bind_rows(uber1, uber2, uber3, uber4, uber5, uber6)

write.csv(uber_data, "uber_data.csv", row.names = FALSE)

## Changing the date column to a data schema
## Make it a POSIX format
uber_data$Date.Time <- as.POSIXct(uber_data$Date.Time, format = "%m/%d/%Y %H:%M:%S")

## Make 2 columns for date and time
uber_data$Date <- as.Date(uber_data$Date.Time)
uber_data$Time <- format(uber_data$Date.Time, "%H:%M:%S")


## Make a pivot table to display trips by hour
uber_data$Time <- hms(uber_data$Time)
uber_data$Hour <- hour(uber_data$Time)
uber_data$Date <- as.Date(uber_data$Date)
uber_data$Month <- month(uber_data$Date)
uber_data$Day_of_Week <- wday(uber_data$Date.Time, label = TRUE)
uber_data$Week <-  week(uber_data$Date)

# make pivot
trips_by_hour <- uber_data %>%
  group_by(Hour, Month) %>%
  summarise(trips_count = n())

#Trips by Hour and month
ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = Month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of Trips by Hour and Month",
       x = "Hour of Day",
       y = "Number of Trips",
       fill = "Month") +
  theme_minimal()

#Trips by the Hour 
ggplot(trips_by_hour, aes(x = Hour, y = trips_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Trips by Hour of the Day",
       x = "Hour of Day",
       y = "Number of Trips") +
  theme_minimal()

## make pivot table for day of the week and month
DOW_and_Month <- uber_data %>%
  group_by(Month, Day_of_Week) %>%
  summarise(trips_count = n())

## add levels to the day of the week
DOW_and_Month$Day_of_Week <- factor(DOW_and_Month$Day_of_Week, levels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"))

## Trips by day and month 
ggplot(DOW_and_Month, aes(x = Month, y = trips_count, fill = Day_of_Week)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Month", y = "Number of Trips", fill = "Day of the Week") +
  ggtitle("Trips by Day of the Week and Month") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###Trips taken during every day of the month
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

## Make a chart that displaying trips per day of month---NEED TO FILL IN MINE 
ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) +
  geom_col() +
  labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

##trips by month
ggplot(trips_by_day, aes(x = Month, y = trips_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Number of Trips by Month",
       x = "Month",
       y = "Number of Trips") +
  theme_minimal()


## Make a pivot table that displays base and month
trips_by_base <- uber_data %>%
  group_by(Base, Month) %>%
  summarise(trips_count = n())

ggplot(trips_by_base, aes(x = Base, y = trips_count, fill = Month)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(x = "Base", y = "Number of Trips", fill = "Month") +
  ggtitle("Trips by Bases and Month") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Heat Maps
## pivot for hour and day
trips_by_hour_day<- uber_data %>%
  group_by(Hour, Day_of_the_month) %>%
  summarise(trips_count = n())

## heat map by hour and day
ggplot(trips_by_hour_day, aes(x = Hour, y = Day_of_the_month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(x = "Hour of the Day", y = "Day of the Week", fill = "Number of Trips") +
  ggtitle("Trips by Hour and Day of the Week") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## pivot table for heat map of month and Day of month
heat_day_month <- uber_data %>%
  group_by(Month, Day_of_the_month) %>%
  summarise(trips_count = n())

## make heat map for month and week
ggplot(heat_day_month, aes(x = Month, y = Day_of_the_month, fill = trips_count)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "blue") +
  labs(x = "Week of the Year", y = "Month", fill = "Number of Trips") +
  ggtitle("Trips by Month and Week of the Year") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## Pivot table for month and day of week 
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


## Pivot for base and day of week
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


## make a shiny app
ui <- fluidPage(
  
  titlePanel("Uber Trips Analysis"),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Trips by Hour",
               plotOutput("hourPlot")),
      tabPanel("Trips by Hour and Month",
               plotOutput("tripsbyhourandmonth")),
      tabPanel("Trips every Hour of the Day", 
               plotOutput("everyHourPlot")), 
      tabPanel("Trips by Date", 
               plotOutput("datePlot")), 
      tabPanel("Trips by Day of Month",
               plotOutput("DayOfMonthPlot")),
      tabPanel("Trips by Day of Week and Month",
               plotOutput("dayOfMonthPlot")),
      tabPanel("Trips by Month",
               plotOutput("monthPlot")),
      tabPanel("Trips by Base",
               plotOutput("basePlot")),
      tabPanel("Heatmap of Hour and Day",
               plotOutput("hourDayHeatmap")),
      tabPanel("Heatmap of Month and Day",
               plotOutput("monthDayHeatmap")),
      tabPanel("Heatmap of Month and Week of the Year",
               plotOutput("heatdayofweek")),
      tabPanel("Heatmap of Bases and Day of the Week",
               plotOutput("heatbases")),
      tabPanel("Leaflet Geospatial Map",
               plotOutput("geospatial"))
    )
  )
)

server <- function(input, output) {

  output$hourPlot <- renderPlot({
    ggplot(trips_by_hour, aes(x = Hour, y = trips_count)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(title = "Number of Trips by Hour of the Day",
           x = "Hour of Day",
           y = "Number of Trips") +
      theme_minimal()
  })
  output$tripsbyhourandmonth <- renderPlot({
    ggplot(trips_by_hour, aes(x = Hour, y = trips_count, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Number of Trips by Hour and Month",
           x = "Hour of Day",
           y = "Number of Trips",
           fill = "Month") +
      theme_minimal()
  })
  output$everyHourPlot <- renderPlot({
    ggplot(trips_by_hour, aes(x = Hour, y = trips_count)) +
      geom_line() +
      labs(title = "Number of Trips by Hour of the Day",
           x = "Hour of Day",
           y = "Number of Trips") +
      theme_minimal()
  })
  output$datePlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count)) +
      geom_line() +
      labs(title = "Number of Trips by Day",
           x = "Date",
           y = "Number of Trips") +
      theme_minimal()
  })
  output$dayOfMonthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Day_of_the_month, y = trips_count, fill = Month)) +
      geom_col() +
      labs(title = "Trips by Day of the Month", x = "Day of the Month", y = "Uber Trips", fill = "Month") +
      theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
    
  })
  output$DayOfMonthPlot <- renderPlot({
    ggplot(DOW_and_Month, aes(x = Month, y = trips_count, fill = Day_of_Week)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Month", y = "Number of Trips", fill = "Day of the Week") +
      ggtitle("Trips by Day of the Week and Month") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
  })
  output$monthPlot <- renderPlot({
    ggplot(trips_by_day, aes(x = Month, y = trips_count)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(title = "Number of Trips by Month",
           x = "Month",
           y = "Number of Trips") +
      theme_minimal()
  })

  output$basePlot <- renderPlot({
    ggplot(trips_by_base, aes(x = Base, y = trips_count, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(x = "Base", y = "Number of Trips", fill = "Month") +
      ggtitle("Trips by Bases and Month") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
  
  output$hourDayHeatmap <- renderPlot({
    ggplot(trips_by_hour_day, aes(x = Hour, y = Day_of_the_month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Hour of the Day", y = "Day of the Week", fill = "Number of Trips") +
      ggtitle("Trips by Hour and Day of the Week") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })

  output$monthDayHeatmap <- renderPlot({
    ggplot(heat_day_month, aes(x = Month, y = Day_of_the_month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "red") + # Adjust color gradient as needed
      labs(title = "Heatmap of Month and Day of the month", x = "Month of the Year", y = "Day of the Month", fill = "Trips")
    
  })
  
  ###need to fix this
  output$heatbases <- renderPlot({
    ggplot(base_heat, aes(x = Base, y = Day_of_Week, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Base", y = "Day of the Week", fill = "Number of Trips") +
      ggtitle("Heatmap of Base and Day of the Week") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })

  output$heatdayofweek <- renderPlot({
    ggplot(heat_month_week, aes(x = Week, y = Month, fill = trips_count)) +
      geom_tile() +
      scale_fill_gradient(low = "white", high = "blue") +
      labs(x = "Day of Week", y = "Month", fill = "Number of Trips") +
      ggtitle("Trips by Day of the Week and Month") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })

 }

shinyApp(ui, server)