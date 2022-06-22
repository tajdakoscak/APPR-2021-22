# 2. faza: Uvoz podatkov
library(readr)
library(tidyr)
library(dplyr)
library(rvest)
library(XML)
library(stringr)

#=======================================================================================================================================
#Stopnja in kategorija kriminala v posameznih evropskih državah


KRIMINALITETA <- read_csv("podatki/kriminaliteta.csv",na=":",
                        locale=locale(encoding="windows-1250")) %>% select(-"DATAFLOW",-"LAST UPDATE",-"freq","iccs","unit","geo","TIME_PERIOD","OBS_VALUE",-"OBS_FLAG")


KRIMINALITETA[KRIMINALITETA == "ICCS0101"] <- "Namerni umor"
KRIMINALITETA[KRIMINALITETA == "ICCS0601"] <- "Nezakonita dejanja, ki vključujejo prepovedane droge"
KRIMINALITETA[KRIMINALITETA == "ICCS050211"] <- "Kraja motornega vozila"
KRIMINALITETA[KRIMINALITETA == "ICCS0502"] <- "Kraja"
KRIMINALITETA[KRIMINALITETA == "ICCS05012"] <- "Vlom v zasebne stanovanjske prostore"
KRIMINALITETA[KRIMINALITETA == "ICCS0401"] <- "Rop"
KRIMINALITETA[KRIMINALITETA == "ICCS03012"] <- "Spolni napad"
KRIMINALITETA[KRIMINALITETA == "ICCS03011"] <- "Posiljstvo"
KRIMINALITETA[KRIMINALITETA == "ICCS0301"] <- "Spolno nasilje"
KRIMINALITETA[KRIMINALITETA == "ICCS020221"] <- "Ugrabitev"
KRIMINALITETA[KRIMINALITETA == "ICCS02011"] <- "napad"
KRIMINALITETA[KRIMINALITETA == "ICCS0102"] <- "Poskus namernega umora"
KRIMINALITETA[KRIMINALITETA == "ICCS0501"] <- "vlom"



KRIMINALITETA<-KRIMINALITETA[!(KRIMINALITETA$"unit"=="NR"),]

#-----------------------
#2020
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&region=150&displayColumn=1"
stran <- read_html(url)
KRIMINAL20 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL20) <-  c("država", "indeks varnosti20")

KRIMINAL20["TIME_PERIOD"] = 2020
#-----------------------
#2019
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2019&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL19 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL19)<-  c("država", "indeks varnosti19")

KRIMINAL19["TIME_PERIOD"] = 2019
#------------------
#2018
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2018&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL18 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL18)<-  c("država", "indeks varnosti18")

KRIMINAL18["TIME_PERIOD"] = 2018


#------------------
#2017
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2017&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL17 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL17)<-  c("država", "indeks varnosti17")

KRIMINAL17["TIME_PERIOD"] = 2017


#------------------
#2016
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2016&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL16 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL16)<-  c("država", "indeks varnosti16")

KRIMINAL16["TIME_PERIOD"] = 2016


#------------------
#2015
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2015&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL15 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL15)<-  c("država", "indeks varnosti15")

KRIMINAL15["TIME_PERIOD"] = 2015


#------------------
#2014
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2014&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL14 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL14)<-  c("država", "indeks varnosti14")

KRIMINAL14["TIME_PERIOD"] = 2014


#------------------
#2013
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2013-Q1&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL13 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL13)<-  c("država", "indeks varnosti13")

KRIMINAL13["TIME_PERIOD"] = 2013

#------------------
#2012
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2012-Q1&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL12 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL12)<-  c("država", "indeks varnosti12")

KRIMINAL12["TIME_PERIOD"] = 2012

#--------------------

#ZDRUŽITEV TABEL


#imena in kratice držav
url2 <- "https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_N454670.html"
stran <- read_html(url2)
drzave <- stran %>% html_nodes(xpath = '//table') %>%
  .[[1]] %>%
  html_table

colnames(drzave) <-  c("geo", "država")

KRIMINALITETA <- left_join(KRIMINALITETA, drzave, by="geo")
KRIMINALITETA <- KRIMINALITETA %>% select("država", "TIME_PERIOD", "OBS_VALUE", "iccs")

#končna tabela - TABELA1

KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL20, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL19, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL18, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL17, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL16, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL15, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL14, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL13, by=c("država","TIME_PERIOD"))
KRIMINALITETA <- left_join(KRIMINALITETA, KRIMINAL12, by=c("država","TIME_PERIOD"))

TABELA1 <- KRIMINALITETA %>% mutate (Indeks_varnosti = coalesce(`indeks varnosti20`,`indeks varnosti19`,`indeks varnosti18`,`indeks varnosti17`, `indeks varnosti16`, `indeks varnosti15`, `indeks varnosti14`, `indeks varnosti13`, `indeks varnosti12`)) %>%
  select("država", "TIME_PERIOD", "OBS_VALUE", "iccs", Indeks_varnosti)

TABELA1 <- TABELA1 %>% select("TIME_PERIOD","država",Indeks_varnosti, "iccs", "OBS_VALUE")

colnames(TABELA1) <-c("Leto","Država","Indeks varnosti", "Kategorija kaznivega dejanja", "Število kaznivih dejanj na 1000 prebivalcev") 





#=======================================================================================================================================
#Značilnosti zapornikov

ZAPORNIKI <- read_csv("podatki/zaporniki.csv",na=":",
                      locale=locale(encoding="windows-1250"),  
                      col_types = cols(
                        .default = col_guess(), 
                        "unit" = col_factor(), 
                        "sex" = col_factor(),
                        "age" = col_factor()
                      )) %>% select("unit","geo", "sex", "age","TIME_PERIOD", "OBS_VALUE" )


TABELA2 <- ZAPORNIKI[!(ZAPORNIKI$"unit"=="NR"),]  %>%
  select(-"unit")

colnames(TABELA2) <- c("geo", "sex", "age","TIME_PERIOD", "OBS_VALUE")
TABELA2 <- left_join(TABELA2, drzave, by="geo") %>% select("TIME_PERIOD","država","sex","age", "OBS_VALUE")

colnames(TABELA2) <- c("Leto", "Država", "Spol", "Starostna skupina", "Število zapornikov na 1000 prebivalcev")

#=======================================================================================================================================
#Stopnja izobrazbe, revščine, odstotek brezposelnih ter zadolženih ljudi v posameznih evropskih državah




IZOBRAZBA <- read_csv("podatki/izobrazba.csv",na=":",
                   locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )
BREZPOSELNOST <- read_csv("podatki/brezposelnost.csv",na=":",
                          locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA3 <- left_join(IZOBRAZBA, BREZPOSELNOST, by=c("geo", "TIME_PERIOD"))


ZADOLZENOST <- read_csv("podatki/zadolzenost.csv",na=":",
                        locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA3 <- left_join(TABELA3, ZADOLZENOST, by=c("geo", "TIME_PERIOD"))
colnames(TABELA3) <- c("geo", "TIME_PERIOD", "odstotek NEizobraženih", "odstotek brezposelnih", "odstotek zadolženih")

REVSCINA <-  read_csv("podatki/revscina.csv",na=":",
                      locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA3 <- left_join(TABELA3, REVSCINA, by=c("geo", "TIME_PERIOD"))

GINI <-  read_csv("podatki/GINIkoeficient.csv",na=":",
                  locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA3 <- left_join(TABELA3, GINI, by=c("geo", "TIME_PERIOD"))

colnames(TABELA3) <- c("geo", "TIME_PERIOD", "odstotek NEizobraženih", "odstotek brezposelnih", "odstotek zadolženih", "revscina", "neenakosti")


TABELA3 <- TABELA3 %>% select( "TIME_PERIOD", "geo", "odstotek NEizobraženih", "odstotek brezposelnih", "odstotek zadolženih", "revscina", "neenakosti")

colnames(TABELA3) <- c("Leto","Država", "Odstotek pribivalstav z zgolj osnovnošolsko ali nižjo srednješolsko izobrazbo ","Odstotek brezposelnih", "Odstotek zadolženih", "Revščina", "Neenakosti - GINI koeficient")
