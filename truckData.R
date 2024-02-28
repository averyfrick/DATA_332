library(readxl)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(stringr)

rm(list=ls())
#setting up working directory 
setwd('~/Documents/Senior Year /DATA 332')
df_truck<-read_excel('NP_EX_1-2.xlsx', sheet=2, skip=3, .name_repair = 'universal') 

#view(df_truck) to run and get data 

#select columns 
df <- df_truck [, c(4:15)]
#de select columns 
df<- subset(df, select= -c(...10))

#getting difference of days within a column, will be stored as value on right side 
date_min <- min(df$Date)
date_max <- max(df$Date)

number_of_days_on_the_road <- date_max- date_min
print (number_of_days_on_the_road)

days <- difftime(max(df$Date), min(df$Date))
print(days)

number_of_days_recorded <- nrow(df)

total_hours<- sum(df$Hours)
avg_hrs_per_day_rec <- round(total_hours / number_of_days_recorded, digits=3)
print(avg_hrs_per_day_rec)

#making new columns, combining current columns together 
df$fuel_cost <- df$Gallons * df$Price.per.Gallon
df$total_cost <- df$Tolls * df$Misc * df$fuel_cost

total_expenses <- sum(df$total_cost)
total_fuel_expenses <- sum(df$fuel_cost)
other_expense <- sum(df$Misc)
total_gallons_consumed <- sum(df$Gallons)

total_miles_driven <- sum(df$Odometer.Ending - df$Odometer.Beginning)
miles_per_gallon <- total_miles_driven / total_gallons_consumed 

cost_of_gallons_per_state <- df$Gallons*df$Price.per.Gallon
total_cost <- cost_of_gallons_per_state + df$total_cost 
full_total <- sum(total_cost)
print (full_total)
cost_per_mile <- full_total / total_miles_driven 
print(cost_per_mile)

df[c('warehouse', 'starting_city_state')]<-str_split_fixed(df$Starting.Location, ',', 2)
view(df)

#string extract by comma for city state column
df$starting_city_state<- gsub(',', "", df$starting_city_state)
view(df)

#df[c('col1', 'col2')]<-str_split_fixed(df$city_state, ' ', 2)
#view(df)

df_starting_pivot <- df %>% 
  group_by(starting_city_state) %>%
  summarize(count=n(),
            mean_size_hours=mean(Hours, na.rm=TRUE), 
            sd_hours=sd(Hours, na.rm= TRUE), 
            total_hours=sum(Hours, na.rm=TRUE), 
            total_gallons=sum(Gallons, na.rm=TRUE) 
            )
view(df_starting_pivot)

ggplot(df_starting_pivot, aes(x=starting_city_state, y=count)) + 
  geom_col()+
  theme(axis.text=element_text(angle=45, vjust=.5, hjust=1))



#same thing but for delivery location 
df[c('warehouse', 'delivery_location')]<-str_split_fixed(df$Delivery.Location, ',', 2)
view(df)

df$delivery_location<- gsub(',', "", df$delivery_location)
view(df)

df_delivery_pivot<- df%>%
  group_by(delivery_location) %>%
  summarize(count=n(), 
            mean_size_hours=mean(Hours, na.rm=TRUE), 
            sd_hours=sd(Hours, na.rm= TRUE), 
            total_hours=sum(Hours, na.rm=TRUE), 
            total_gallons=sum(Gallons, na.rm=TRUE) 
            )
view(df_delivery_pivot)

ggplot(df_delivery_pivot, aes(x=delivery_location, y=count)) + 
  geom_col()+
  theme(axis.text=element_text(angle=45, vjust=.5, hjust=1))