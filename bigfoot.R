library(tidyverse)
library(lubridate)

bigfoot_raw<- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-13/bigfoot.csv')

bigfoot <- bigfoot_raw %>% mutate(year = year(date))

bigfoot %>% ggplot(aes(x=year)) + geom_histogram()

bigfoot %>% filter(year > 1950) %>% ggplot(aes(x=year)) + geom_histogram()




bigfoot %>% ggplot(aes(longitude, latitude)) + geom_point()


bigfoot %>% filter(state != "Alaska") %>% filter(longitude > -130) %>% ggplot(aes(longitude, latitude)) + geom_point()

bigfoot %>% filter(state != "Alaska") %>% filter(longitude > -130) %>% ggplot(aes(longitude, latitude, color=season)) + geom_point()

bigfoot %>% filter(state != "Alaska") %>% filter(longitude > -130) %>% ggplot(aes(longitude, latitude, color=year)) + geom_point()
#gradiner


bigfoot %>% filter(state != "Alaska") %>% filter(longitude > -130) %>% ggplot(aes(longitude, latitude, color=year)) + 
  geom_point() + borders("state")
#data on state denitsy

density <- read_csv("https://raw.githubusercontent.com/camillol/cs424p3/master/data/Population-Density%20By%20State.csv")

density <- density %>% rename(state = `GEO.display-label`,
                              density = `Density per square mile of land area`) 

big_den <- bigfoot %>% left_join(density) 


big_den %>% count(state, density) %>% ggplot(aes(x=n, y=density)) +geom_point()

big_den %>% count(state, density) %>% 
  #mutate(state = fct_reorder(n, density)) %>% 
  ggplot(aes(x=density, y=n, color=state)) + geom_point() + geom_text(aes(label=state), check_overlap = T) 



big_den %>% ggplot() +
  geom_polygon(aes(fill=den), fill="white", color="grey") 

library(gganimate)

bigfoot %>% filter(state != "Alaska") %>% filter(longitude > -130) %>% ggplot(aes(longitude, latitude)) + 
  geom_point() + transition_manual(year, cumulative = TRUE) + ggtitle("year: {current_state}") + borders("state")

bigfoot %>% filter(state != "Alaska") %>% filter(longitude > -130) %>% ggplot(aes(longitude, latitude)) + 
  geom_point() + transition_reveal(year, ) + ggtitle("year: {frame_along}") + borders("state")
