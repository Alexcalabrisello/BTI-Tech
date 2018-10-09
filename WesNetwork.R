# setwd("~/Documents/Network Examples")
library(tidyverse)

##reading in data file
wes1 <- read_csv("WesAndersonCast.csv")
# View(wes1)

##removing some of the bad characters & combining O Wilson's records
wes1$Name <- gsub("\xca", "", wes1$Name)
wes1$Name <- gsub("Owen C. Wilson", "Owen Wilson", wes1$Name)

# View(wes1)

##creating matrix
combo2 <- wes1 %>%
  mutate (n =1) %>%
  spread(Name, n, fill=0) %>%
  select(-Movie) %>%
  {crossprod(as.matrix(.))}


##set up data frameworks / tibble
combo3 <- as.data.frame(combo2, keep.rownames = FALSE)
combo4 <- add_rownames(combo3, "Actor")


##creating edge file
WesEdge <- combo4 %>% 
  gather(Actor1, Actor2, -Actor) %>% 
  filter(Actor2 !=0) %>% 
  filter(Actor!=Actor1) %>% 
  rename(Weight= Actor2)
  
View(WesEdge)



##creating node file

WesNode <- WesEdge %>% 
        distinct(Actor) %>% 
        rowid_to_column("NodeID") %>% 
        mutate(NodeID2= NodeID - 1) %>% ##recoding first node as 0
        select(-NodeID) %>% 
        select(NodeID2, Actor) %>% 
        rename(NodeID=NodeID2)


##creating final edge file with numerical values

WesEdge2 <- WesEdge %>% 
  full_join(by="Actor", WesNode) %>% 
  rename(Actor2=NodeID) %>% 
  select(-Actor) %>% 
  rename(Actor=Actor1) %>% 
  full_join(by="Actor", WesNode) %>% 
  select(-Actor) %>% 
  rename(Actor=NodeID) %>% 
  rename(Actor1=Actor) %>% 
  select(Actor1, Actor2, Weight) %>% 
  rename(Source=Actor1, Target=Actor2)

  

write.csv(WesNode, "wesNode.csv", row.names=FALSE)
write.csv(WesEdge2, "wesEdge.csv", row.names=FALSE)


