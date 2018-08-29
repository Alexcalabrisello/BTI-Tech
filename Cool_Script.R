


# install.packages("tidyverse")



library(tidyverse)

# manipulate data set

diamonds2 <- diamonds %>% 
        filter(color == "G" & depth > 60) %>% 
        group_by(clarity) %>% 
        arrange(clarity) %>% 
        mutate(av_carat = mean(carat)) %>% 
        mutate(med_carat = median(carat)) 

ggplot(diamonds2, aes(carat, price)) +
        geom_point(aes(colour=cut, size=table, alpha=1/10)) 

