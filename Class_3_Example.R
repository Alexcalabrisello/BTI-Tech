setwd("~/Documents/UTS/Tech Lab /Class_3")

library(tidyverse)
library(lubridate)

(df1 <- read_csv("Crop_example2.csv"))


df2 <- df1 %>% 
        gather("Date", "Value",c(-Crop,-Type))


View(df2)

######
df3 <- df2 %>% 
        separate(Date, c("Month", "Year"))%>% 
        mutate(Year2=paste("20", Year, sep="")) %>% 
        mutate(Day=1) %>% 
        mutate(Date=paste (Year, Month, Day, sep="-")) %>% 
        # select(-Month, -Year ,-Day) %>% 
        mutate(Date = ymd(Date)) 




ggplot(df3, aes(Date, Value, group=Type, colour=Type)) +
        geom_line() +
        facet_wrap(~Crop)