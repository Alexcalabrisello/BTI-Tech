


# install.packages("tidyverse")

library(tidyverse)


diamonds2 <- diamonds %>% 
        filter(color == G & depth > 60) %>% 
        group_by(clarity) %>% 
        arrange(clarity) %>% 
        mutate(av_carat = mean(carot))

ggplot(diamonds2, aes(car0t, price)) %>% 
        geom_point(aes(colour=cut size=table, alpha=1/10)) +

