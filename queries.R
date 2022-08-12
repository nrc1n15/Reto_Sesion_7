
suppressWarnings(suppressMessages(install.packages("dplyr")))
suppressWarnings(suppressMessages(install.packages("DBI")))
suppressWarnings(suppressMessages(install.packages("RMySQL")))
suppressWarnings(suppressMessages(install.packages("ggplot2")))
                                  
library(dplyr)
library(DBI)
library(RMySQL)
library(ggplot2)

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

dbListTables(MyDataBase)

DataDB <- dbGetQuery(MyDataBase, "SELECT Name, Percentage, Language, IsOfficial FROM CountryLanguage JOIN Country ON CountryLanguage.CountryCode = Country.Code")
lang.spa <- DataDB %>% filter(Language == "Spanish")


ggplot(lang.spa, aes(x = Percentage, y = Name, fill = IsOfficial)) + 
  geom_bar(stat = "identity") +
  ggtitle('Países con hispanoparlantes') + 
  labs(x = 'Porcentaje', y = 'País', fill = 'Es oficial')+
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5, size = 16))  

 