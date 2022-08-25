# 4. faza: Napredna analiza podatkov

library(ggplot2)
library(dplyr)
ggplot(TABELA2, aes(x = revscina, y = obsojeni)) + 
  geom_point() + 
  geom_smooth(se = FALSE, method = stats::lm) 

#linearna
fit <- lm(obsojeni ~ revscina, data=TABELA2)


prihodno<- data.frame(revscina=c(30, 35,40))
prihodno <-prihodno %>% mutate(obsojeni=predict(fit, .))

NAPOVED <- ggplot(TABELA2, aes(x = revscina, y = obsojeni)) + 
  labs(y = "Število obsojenih na 1000 prebivalcev",
       x = "Revščina")  +
  geom_point(shape=1) + 
  geom_smooth(method=lm) +
  geom_point(data=prihodno, aes(x = revscina, y = obsojeni), color='red', size=3) 
NAPOVED  

NAPOVED



slovenija <- Skupno_Kriminala %>% filter(drzava=="Slovenia")

prilagojeno <- lm(data=slovenija,`obsojeni`~I(Leto^2) +Leto)

graf <- data.frame(Leto = seq(2021, 2022, 1))

napoved <- mutate(graf, napovedano=predict(prilagojeno,graf))

graf <- ggplot(slovenija, aes(x=Leto, y=`obsojeni`))+
  geom_point() + geom_smooth(method = lm, formula =y~ x + I(x^2), fullrange = TRUE)+
  geom_point(data = napoved, aes(x=Leto, y=napovedano), color='red', size = 2) 


