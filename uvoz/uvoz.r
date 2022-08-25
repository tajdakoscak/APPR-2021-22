# 2. faza: Uvoz podatkov
library(readr)
library(tidyr)
library(dplyr)
library(rvest)
library(XML)
library(stringr)
library(naniar)
library(tidyverse)



#=======================================================================================================================================
#Stopnja in kategorija kriminala v posameznih evropskih drzavah


KRIMINALITETA <- read_csv("podatki/kriminaliteta.csv",na=":", locale=locale(encoding="windows-1250")) %>%  select(-"DATAFLOW",-"LAST UPDATE",-"freq","iccs","unit","geo","TIME_PERIOD","OBS_VALUE",-"OBS_FLAG")



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
KRIMINALITETA[KRIMINALITETA == "ICCS02011"] <- "Napad"
KRIMINALITETA[KRIMINALITETA == "ICCS0102"] <- "Poskus namernega umora"
KRIMINALITETA[KRIMINALITETA == "ICCS0501"] <- "Vlom"




KRIMINALITETA <- KRIMINALITETA %>% select(-"unit")

Skupno_Kriminala <- KRIMINALITETA %>% 
  group_by(geo, TIME_PERIOD) %>% 
  summarise_if(is.numeric, funs(sum))

colnames(Skupno_Kriminala) <-  c("Drzava", "Leto", "obsojeni")

Skupno_Kriminala <- transform(
  Skupno_Kriminala,Leto = as.integer(Leto))


url2 <- "https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_N454670.html"
stran <- read_html(url2)
drzave <- stran %>% html_nodes(xpath = '//table') %>%
  .[[1]] %>%
  html_table



colnames(drzave) <-  c("Drzava", "drzava")
drzave$Drzava[drzave$Drzava == "GR"] <- "EL"
drzave$drzava[drzave$drzava == "Croatia/Hrvatska"] <- "Croatia"


Skupno_Kriminala <- left_join(Skupno_Kriminala, drzave, by=c("Drzava"))

colnames(KRIMINALITETA) <-  c("Vrsta", "Drzava","Leto","obsojeni")
KRIMINALITETA <- left_join(KRIMINALITETA, drzave, by=c("Drzava"))



TABELA1 <- KRIMINALITETA %>% select("Leto", "Drzava", "drzava","Vrsta","obsojeni")

#rm(KRIMINALITETA)



#-----------------------

#DODALA INDEKS VARNOSTI


#2020
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&region=150&displayColumn=1"
stran <- read_html(url)
KRIMINAL20 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL20) <-  c("drzava", "indeks varnosti20")

KRIMINAL20["TIME_PERIOD"] = 2020
#-----------------------
#2019
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2019&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL19 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL19)<-  c("drzava", "indeks varnosti19")

KRIMINAL19["TIME_PERIOD"] = 2019
#------------------
#2018
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2018&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL18 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL18)<-  c("drzava", "indeks varnosti18")

KRIMINAL18["TIME_PERIOD"] = 2018


#------------------
#2017
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2017&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL17 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL17)<-  c("drzava", "indeks varnosti17")

KRIMINAL17["TIME_PERIOD"] = 2017


#------------------
#2016
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2016&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL16 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL16)<-  c("drzava", "indeks varnosti16")

KRIMINAL16["TIME_PERIOD"] = 2016


#------------------
#2015
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2015&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL15 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL15)<-  c("drzava", "indeks varnosti15")

KRIMINAL15["TIME_PERIOD"] = 2015


#------------------
#2014
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2014&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL14 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL14)<-  c("drzava", "indeks varnosti14")

KRIMINAL14["TIME_PERIOD"] = 2014


#------------------
#2013
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2013-Q1&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL13 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL13)<-  c("drzava", "indeks varnosti13")

KRIMINAL13["TIME_PERIOD"] = 2013

#------------------
#2012
url <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2012-Q1&displayColumn=0&region=150"
stran <- read_html(url)
KRIMINAL12 <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  select(-"Rank")

colnames(KRIMINAL12)<-  c("drzava", "indeks varnosti12")

KRIMINAL12["TIME_PERIOD"] = 2012






#--------------------

#ZDRUŽITEV TABEL



#končna tabela - TABELA1



colnames(Skupno_Kriminala) <- c("Drzava","TIME_PERIOD","obsojeni", "drzava")
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL20, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL19, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL18, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL17, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL16, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL15, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL14, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL13, by=c("drzava","TIME_PERIOD"))
Skupno_Kriminala <- left_join(Skupno_Kriminala, KRIMINAL12, by=c("drzava","TIME_PERIOD"))


Skupno_Kriminala <- Skupno_Kriminala %>% mutate (Indeks_varnosti = coalesce(`indeks varnosti20`,`indeks varnosti19`,`indeks varnosti18`,`indeks varnosti17`, `indeks varnosti16`, `indeks varnosti15`, `indeks varnosti14`, `indeks varnosti13`, `indeks varnosti12`)) %>%
  select("Drzava","drzava","TIME_PERIOD","obsojeni", Indeks_varnosti)




#=======================================================================================================================================
#Stopnja revščine, odstotek brezposelnih ter zadolženih ljudi v posameznih evropskih drzavah




BREZPOSELNOST <- read_csv("podatki/brezposelnost.csv",na=":",
                          locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )



ZADOLZENOST <- read_csv("podatki/zadolzenost.csv",na=":",
                        locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA2 <- left_join(BREZPOSELNOST, ZADOLZENOST, by=c("geo", "TIME_PERIOD"))





REVSCINA <-  read_csv("podatki/revscina.csv",na=":",
                      locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA2 <- left_join(TABELA2, REVSCINA, by=c("geo", "TIME_PERIOD"))

GINI <-  read_csv("podatki/GINIkoeficient.csv",na=":",
                  locale=locale(encoding="windows-1250")) %>% select("geo", "TIME_PERIOD", "OBS_VALUE" )

TABELA2 <- left_join(TABELA2, GINI, by=c("geo", "TIME_PERIOD"))


colnames(TABELA2) <- c("Drzava","Leto","Odstotek brezposelnih", "Odstotek zadolženih", "revscina", "GINI")

colnames(Skupno_Kriminala) <- c("Drzava","drzava","Leto", "obsojeni", "Indeks")


#----------------------------
#dodala število obsojenih




TABELA2 <- left_join(TABELA2, drzave, by="Drzava")

TABELA2 <- left_join(TABELA2, Skupno_Kriminala, by=c("Drzava", "Leto", "drzava"))  %>% 
  select("Leto","Drzava","drzava","Odstotek brezposelnih", "Odstotek zadolženih", "revscina", "GINI", "obsojeni", "Indeks")

colnames(TABELA2) <- c("Leto","Drzava","drzava","brezposelni", "zadolzeni", "revscina", "GINI", "obsojeni", "Indeks")

#=================================================================================
na_strings <- c(" ", "  ", "","—")


url3 <- "https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate"
stran <- read_html(url3)
zaprti <- stran %>% html_nodes(xpath = '//table') %>%
  .[[1]] %>%
  html_table %>%
  dplyr::select(c("Country or subnational area", "Region", "Rate per 100,000 [3]"))  %>%
  rename(
    "Country" = "Country or subnational area",
    "Obmocje" = "Region",
    "stevilo" = "Rate per 100,000 [3]")%>%
  replace_with_na_all(condition = ~.x %in% na_strings)%>%  #spremeni polja kjer so bli prej -, "", " ",...
  mutate(across(everything(), gsub, pattern = "\\*.*", replacement = ""))%>%
  mutate(across(everything(), gsub, pattern = "U.S.", replacement = "US"))%>%
  mutate_if(is.character, str_trim)




url4 <- "https://en.wikipedia.org/wiki/List_of_countries_by_suicide_rate"
stran <- read_html(url4)
samomori <- stran %>% html_nodes(xpath = '//table') %>%
  .[[2]] %>%
  html_table %>%
  dplyr::select(c("Country", "All")) %>%
  replace_with_na_all(condition = ~.x %in% na_strings)%>%  #spremeni polja kjer so bli prej -, "", " ",...
  mutate(across(everything(), gsub, pattern = "\\*.*", replacement = "")) %>%
  mutate_if(is.character, str_trim)




TABELA3<- left_join(samomori, zaprti, by="Country")
TABELA3 <- TABELA3[-(184:190), ]

TABELA3$All <- as.numeric(TABELA3$All)      
TABELA3$stevilo <- as.numeric(TABELA3$stevilo)  
colnames(TABELA3)<-c("Drzava","samomor","Obmocje", "zaprt")

#=====================================================

Povprecno1 <-aggregate(TABELA3$samomor, list(TABELA3$Obmocje), FUN=mean) 
colnames(Povprecno1) <- c("obmocje", "samomori")

TABELAA3 <- TABELA3 %>% na.omit()
Povprecno2 <-aggregate(TABELAA3$zaprt, list(TABELAA3$Obmocje), FUN=mean) 
colnames(Povprecno2) <- c("obmocje", "zaprti")

Povprecno11<-left_join(Povprecno1,Povprecno2, by = "obmocje")

Povprecno111<- gather(Povprecno11, "samomori", "zaprti", key = "tip", value = "st")





