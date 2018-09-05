setwd("~/Desktop")
library(tidyverse)

df1 <- read_csv("SA3.csv")

df2 <-  df1 %>% 
        gather("HH_Type", "Value", -"SA3_CODE_2016") %>% 
        rename(SA3Code = SA3_CODE_2016) 