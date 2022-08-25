# 3. faza: Vizualizacija podatkov

library(tidyverse)
library(ggplot2)
library(dplyr)
library(viridis)
library(hrbrthemes)


source("uvoz/uvoz.r", encoding="UTF-8")




#Povprečen delež posamezne vrste kriminala v evropskih državah:
#torta

Povprecno <-aggregate(TABELA1$obsojeni, list(TABELA1$Vrsta), FUN=mean)  %>% filter(x>15)
colnames(Povprecno) <- c("Vrsta", "kolicina")

g1<-ggplot(Povprecno, aes(x = "", y = kolicina, fill = Vrsta)) +
  geom_col() +
  labs(y = "",
       x = "",
       title = "Povprečen delež posamezne vrste kriminala") + 
  coord_polar(theta = "y")


#Ker je prikaz števila kaznivih dejanj na 1000 prebivalcev po vseh državah precej nepregleden,sem
# izbranih le nekaj držav:

#Število kaznivih dejanj na 1000 prebivalcev v izbranih Evropskih državah
zozano <-c("SI", "DK", "SE", "NO", "EL", "HR", "AU","FI", "NL", "BG")

drzave1 <- Skupno_Kriminala %>% filter(Drzava %in% zozano)

gr2 <- drzave1 %>%
      ggplot(mapping = aes(x = Leto, y = obsojeni, color = drzava))+
      labs(x = "leto",
           y = "obsojeni",
           title = "Število kaznivih dejanj na 1000 prebivalcev v izbranih Evropskih državah", 
           color = "Država") + 
      geom_line() + geom_point()





#Število kaznivih dejanj na 1000 prebivalcev glede na  stopnjo revščine in neenakosti v porazdelitvi dohodka -GINI koeficient

g4 <- TABELA2 %>%
  ggplot(
    mapping = aes(x = GINI, y = obsojeni, color= Indeks)
  ) +
  labs(y = "Število obsojenih na 1000 prebivalcev",
       x = "Ginijev koeficient",
       title = "Število obsojenih glede na ginijev koeficient (prikazuje neenakosti v \n porazdelitvi dohodka) in indeks varnosti",
       color = "Indeks varnosti") + 
  geom_point(position = position_jitter(width = 0.15))+
  theme(plot.title = element_text(hjust = 0.5))+
  geom_smooth(se = FALSE, method = stats::lm) 
g4



g5 <- TABELA2 %>%
  ggplot(
    mapping = aes(x = revscina, y = obsojeni, color= Indeks)
  ) +
  labs(y = "Število obsojenih na 1000 prebivalcev",
       x = "Stopnja revščine",
       title = "Število obsojenih glede na stopnjo revščine in indeks varnosti",
       color = "Indeks varnosti") + 
  geom_point(position = position_jitter(width = 0.15))  +
  geom_smooth(se = FALSE, method = stats::lm)    
g5



g6 <- TABELA2 %>%
  ggplot(
    mapping = aes(x = zadolzeni, y = obsojeni, color= Indeks)
  ) +
  labs(y = "Število obsojenih na 1000 prebivalcev",
       x = "Zadolženost",
       title = "Število obsojenih glede na zadolženost in indeks varnosti",
       color = "Indeks varnosti") + 
  geom_point(position = position_jitter(width = 0.15))+
  geom_smooth(se = FALSE, method = stats::lm) 
g6

gr6 <- TABELA2 %>%
  ggplot(
    mapping = aes(x = brezposelni, y = obsojeni, color= Indeks)
  ) +
  labs(y = "Število obsojenih na 1000 prebivalcev",
       x = "Brezposelnost",
       title = "Število obsojenih glede na brezposelnost in indeks varnosti",
       color = "Indeks varnosti") + 
  geom_point(position = position_jitter(width = 0.15)) +
  geom_smooth(se = FALSE, method = stats::lm)     

gr6


g7 <- ggplot(Povprecno111, aes(fill=obmocje, y=st, x=obmocje)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_fill_viridis(discrete = T, option = "E") +
  ggtitle("Število samomorov in število zaprtih ljudi na 100,000 prebivalcev") +
  facet_wrap(~tip) +
  theme_ipsum() +
  xlab("")+
  theme(text = element_text(size=20),axis.text.x = element_text(angle=90, hjust=1))

g7




library(sp)
library(rgdal)
library(rgeos)
library(raster)
library(tidyverse)
library(tmap)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(rgeos)

world <- ne_countries(scale = "medium", returnclass = "sf")
Europe <- world[which(world$continent == "Europe"),] %>% dplyr::rename("drzava" = name)
Europe$drzava[Europe$drzava == "Slovakia"] = "Slovak Republic"
Europe$drzava[Europe$drzava == "Czech Rep."] = "Czech Republic"




kriminal = left_join(Europe, Skupno_Kriminala, by= "drzava")



zemljevid_kriminala = kriminal %>% filter(Leto == "2020") %>% ggplot() +
  aes(fill = obsojeni)+
  geom_sf() +
  theme(
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank()
  ) +
  theme_classic() +
  coord_sf(xlim = c(-24,45), ylim = c(35,70)) +
  labs(fill = "Kriminal") + ggtitle("Zemljevid števila obsojenih ljudi za evropske države") +
  geom_sf_text(aes(label = drzava), color = "gray", size = 2)

zemljevid_kriminala



