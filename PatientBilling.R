library(readxl)
library(dplyr)
library(ggplot2)
library(here)

setwd('~/Documents/Senior Year /DATA 332/Patient')
df_billing<-read_excel('Billing.xlsx', .name_repair = 'universal')
df_patient<- read_excel('Patient.xlsx', .name_repair = 'universal')
df_visit<- read_excel('Visit.xlsx',.name_repair = 'universal' )

df_visit_txt<- readLines("Visit.txt")

df <- left_join(df_patient, df_visit, by = c('PatientID'))%>%
  left_join(df_billing, by = c('VisitID'))

group_reasons <- function(Reason) {
  case_when(
    grepl("Laceration", Reason) ~ "Laceration of hand",
    grepl("Allergic", Reason) ~ "Allergic Reaction",
    grepl("Annual", Reason) ~ "Annual Wellness Visit", 
    grepl("Bronchitis", Reason) ~ "Bronchitis",
    grepl("Cyst", Reason) ~ "Cyst",
    grepl("Dermatitis", Reason) ~ "Dermatitis",
    grepl("Hypertension", Reason) ~ "Hypertension",
    grepl("Hypotension", Reason) ~ "Hypotension",
    grepl("Migraine", Reason) ~ "Migarine",
    grepl("Rhinitis", Reason) ~ "Rhinitis",
    grepl("Spotted", Reason) ~ "Spotted Fever Rickettsioss",
    grepl("UTI", Reason) ~ "UTI",
    grepl("Fracture", Reason) ~ "Fractures",
    grepl("Hypothyroidism", Reason) ~ "Hypothyroidism",
    grepl("right", Reason) ~ "Right forarm/hand injury",
    TRUE ~ Reason
  )
}

df <- df %>%
  mutate(group_reasons = group_reasons(Reason))

#reason for visit by month of year
df$VisitMonth <- gsub('^\\d{4}-(\\d{2})-\\d{2}', '\\1', as.character(df$VisitDate))

ggplot(df_VisitMonth, aes(x = group_reasons, y = VisitDate , fill = VisitDate)) + 
  geom_col()+
  labs(title = "Reason for Visit by Month", x = "Reason", y = "Count")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))
ggsave(here("ReasonByMonth.png"))

#reason for visit by walk in or not
df_VisitReason<- df%>%
  select(group_reasons, WalkIn)

ggplot(df_VisitReason, aes(x = group_reasons, y = WalkIn, fill = WalkIn)) + 
  geom_col()+
  labs(title = "Reason for Visit by Walk in", x = "Reason", y = "Count")+
  theme(axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1),axis.text.y = element_blank() )
ggsave(here("ReasonByWalkIn.png"))

#reason for visit based on city
df_VisitCity<- df%>%
  select(group_reasons, City)

ggplot(df_VisitCity, aes(x = group_reasons, y = City , fill = City)) + 
  geom_col()+
  labs(title = "Reason for Visit by City", x = "Reason", y = "City")+
  theme(axis.text.x = element_text(angle = 90, vjust = .5, hjust = 1), axis.text.y= element_text(angle = 0, hjust = 0.5))
ggsave(here("ReasonByCity.png"))

#reason for visit by zip
df_ReasonZip<- df%>%
  group_by(Zip, group_reasons) %>%
  summarize(count=n())

ggplot(df_ReasonZip, aes(x = group_reasons, y = count , fill = Zip)) + 
  geom_col()+
  labs(title = "Reason for Visit by Zip", x = "Reason", y = "Count of Reason")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))
ggsave(here("ReasonByZip.png"))

#total invoice based on reason for visit. if it was paid 
df_InvoicePaidReason<- df%>%
  select(InvoiceAmt, group_reasons, InvoicePaid)

ggplot(df_InvoicePaidReason, aes(x = group_reasons, y = InvoiceAmt , fill = InvoicePaid)) + 
  geom_col()+
  labs(title = "Total Invoice based on reason", x = "Reason", y = "Invoice Amt")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))
ggsave(here("InvoiceTotalByReason.png"))

#one interesting insight -- invoice item and invoice amount by walk in 
df_InvoiceItemAmount<- df%>%
  select(InvoiceAmt, InvoiceItem, WalkIn)

ggplot(df_InvoiceItemAmount, aes(x = InvoiceItem, y = InvoiceAmt , fill = WalkIn)) + 
  geom_col()+
  labs(title = "Invoice Item and Amount", x = "Invoice Item", y = "Invoice Amt")+
  theme(axis.text = element_text(angle = 90, vjust = .5, hjust = 1))
ggsave(here("InvoiceItemAmountByWalkIn.png"))
