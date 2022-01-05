install.packages("tidyverse")
install.packages("XML")
install.packages("rvest")

library(tidyverse)
library(XML)
library(rvest)

data <- read_html("https://www.tutiempo.net/clima/ws-121350.html?fbclid=IwAR0rH4LTdjlZ1F0CLdTQ0rtwLwBM9FuLubS_pkf4HEYNN20geYxDopgAqsA.html")
tables <- data %>% html_table(fill=TRUE)
table <- tables[[4]]

database <- table[c(34:44), c(1,2,8)] #zaimportowane dane
database <- as.data.frame(apply(database, 2, as.numeric)) #zmiana typu danych z char na int
database[,2]*(9/5)+32 -> database[,2] #przeliczenie C na F

for(i in c(1:11)){
  if(is.na(database[i,3])){
    database[i,3]=(database[(i-1),3]+database[(i+1),3])/2
  }
  if(is.na(database[i,2])){
    database[i,2]=(database[(i-1),2]+database[(i+1),2])/2
  }
}    

while(TRUE){  
  year <- readline(prompt = "Enter year: ")
  test <- switch(
    year,
    "2000"= (i = 1),
    "2001"= (i = 2),
    "2002"= (i = 3),
    "2003"= (i = 4),
    "2004"= (i = 5),
    "2005"= (i = 6),
    "2006"= (i = 7),
    "2007"= (i = 8),
    "2008"= (i = 9),
    "2009"= (i = 10),
    "2010"= (i = 11),
  )
  
  cat(database[i,2], database[i,3], " ")
  if(database[i,3]>50)
    cat(" ale prószyło sniegiem ")
}
