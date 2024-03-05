library(readxl)
library(dplyr)
library(ggplot2)

setwd('~/Documents/Senior Year /DATA 332/Student')
df_course<-read_excel('Course.xlsx', .name_repair = 'universal')
df_registration<- read_excel('Registration.xlsx', .name_repair = 'universal')
df_student<- read_excel('Student.xlsx',.name_repair = 'universal' )

df <- left_join(df_registration, df_student, by = c('Student.ID'))%>%
  left_join(df_course, by = c('Instance.ID'))

#Chart number of majors 
df_major_pivots <- df %>%  
  group_by(Title) %>%
  summarize(count = n()) 

ggplot(df_major_pivots, aes(x = Title, y = count , fill = Title)) + 
  geom_col()+
  labs(title = "Amount of Students in Each Major", x = "Major", y = "Amount of Students")+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

#chart on the birth year of the student 
df$Birth.Year<- gsub('-.*', " ", df$Birth.Date)

df_birthyear<- df%>%
  group_by(Birth.Year) %>%
  summarize(count=n())

ggplot(df_birthyear, aes(x = Birth.Year, y = count , fill = Birth.Year)) + 
  geom_col()+
  labs(title = "Birth Year of the Student", x = "Birth Year", y = "Amount of Students")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))

# total cost per major, segment by payment plan 
df_totalcost<- df%>%
  select(Cost, Title, Payment.Plan) 

ggplot(df_totalcost, aes(x = Title, y = Cost , fill = Payment.Plan)) + 
  geom_col()+
  labs(title = "Cost per Major by payment plan", x = "Major", y = "Cost")+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

#total balance due by major, segment (bar chart. stacked bar chart) by payment plan 
df_balancedue<- df%>%
  select(Balance.Due, Title, Payment.Plan)

ggplot(df_balancedue, aes(x = Title, y = Balance.Due , fill = Payment.Plan)) + 
  geom_col()+
  labs(title = "Total Balance Due by Major by payment plan", x = "Major", y = "Balance.Due")+
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))
