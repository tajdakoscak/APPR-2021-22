library(readr)
library(tidyr)
library(dplyr)
library(rvest)


#=======================================================================================================================================
#stopnja kriminala v posameznih Evropskih državah

url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&region=150&displayColumn=1"
stran <- read_html(url)
KRIMINAL <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")


#=======================================================================================================================================

#Stopnja izobrazbe v posameznih državah v letih od 2011 do 2020

IZOBRAZBA <- read_csv("podatki/izobrazba.csv",na=":",skip=1,
                      col_names=c("1","2","3","4", "5", "6","7","država", "leto", "stopnja izobrazbe", "opombe"),
                      locale=locale(encoding="windows-1250")) %>%
  select(-"1",-"2",-"3",-"4",-"5",-"6",-"7",-"opombe")



#=======================================================================================================================================

#Stopnja izobrazbe v posameznih državah v letih od 2011 do 2020

IZOBRAZBA <- read_csv("podatki/izobrazba.csv",na=":",skip=1,
                     col_names=c("1","2","3","4", "5", "6","7","država", "leto", "stopnja izobrazbe", "opombe"),
                     locale=locale(encoding="windows-1250")) %>%
  select(-"1",-"2",-"3",-"4",-"5",-"6",-"7",-"opombe")



#=======================================================================================================================================

#Število brezposelnost v posameznih Evropskih državah (v tisočih)

BREZPOSELNOST <- read_csv("podatki/brezposelnost.csv",na=":",skip=1,
                      col_names=c("DATAFLOW","LAST UPDATE","freq","age","unit","sex","država","leto","odstotek brezposelnih","OBS_FLAG"),
                      locale=locale(encoding="windows-1250")) %>%
  select(-"DATAFLOW",-"LAST UPDATE",-"freq",-"age",-"unit",-"sex",-"OBS_FLAG")

#=======================================================================================================================================

#Odstotek zadolženih ljudi v posameznih Evropskih državah

DOLGOVI<- read_csv("podatki/dolgovi.csv",na=":",skip=1,
                   col_names=c("DATAFLOW","LAST UPDATE","freq","unit","lev_limit","age","sex","država","leto","odstotek","OBS_FLAG"),
                   locale=locale(encoding="windows-1250")) %>%
  select(-"DATAFLOW",-"LAST UPDATE",-"freq",-"unit",-"lev_limit",-"age",-"sex",-"OBS_FLAG")

#=======================================================================================================================================

#Stopnja revščine

REVSCINA <- read_csv("podatki/revscina.csv",na=":",skip=1,
                     col_names=c("DATAFLOW","LAST UPDATE","freq","unit","lev_limit","age","sex","država","leto","odstotek","OBS_FLAG"),
                     locale=locale(encoding="windows-1250")) %>%
  select(-"DATAFLOW",-"LAST UPDATE",-"freq",-"unit",-"lev_limit",-"age",-"sex",-"OBS_FLAG")
