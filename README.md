# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Analiza kaznivih dejanj v Evropi

V projektni nalogi bom analizira kazniva dejanja v Evropi po tipu kaznivega dejanja. Poskušala bom najti povezavo med kriminaliteto in stopnjo revščine, odstotekom brezposelnih in odstotekom zadolženih ljudi.Na koncu pa bom analizirala še svetovne podatke o kriminaliteti in jih primerjala z Evropskimi.

Cilj projektne naloge je prikazati, kateri dejavniki bi lahko najbolj vplivali na količino kriminala v posamezni Evropski državi in kako se količina kriminala v Evropi razlikuje od količine kriminala po svetu. 

1. Tabela:  Stopnja in kategorija kriminala v posameznih evropskih državah 
https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&region=150&displayColumn=0 (HTML), https://ec.europa.eu/eurostat/databrowser/view/CRIM_OFF_CAT__custom_2456657/default/table?lang=en (CSV)
    * Država
    * Leto
    * Indeks kriminala
    * Kategorija kaznivega dejanja 
    * Število kaznivih dejanj po kategorijah na 1000 prebivalcev


2. Tabela: Stopnja revščine, odstotek brezposelnih, odstotek zadolženih ljudi, Ginijev koeficient v posameznih evropskih državah po letih    
https://ec.europa.eu/eurostat/databrowser/view/tipsun20/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/hlth_dm050/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/ilc_li02$DV_548/default/table?lang=en (CSV) 
    * Država
    * Leto
    * Odstotek brezposelnih
    * Odstotek zadolženih ljudi
    * Stopnja revščine
    * Število kaznivih dejanj na 1000 prebivalcev
    
3. Tabela: Število ljudi v zaporih 
https://en.wikipedia.org/wiki/List_of_countries_by_incarceration_rate (HTML)
    * Država
    * število zaprtih na 100,000 prebivalcev


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Potrebne knjižnice so v datoteki `lib/libraries.r`
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).
