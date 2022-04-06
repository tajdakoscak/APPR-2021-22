# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Analiza kaznivih dejanj v Evropi

V projektni nalogi bom analizira kazniva dejanja v Evropi. Osredotočila se bom na obdobje od leta 2008 do leta 2020

Cilj projektne naloge je prikazati, kateri dejavniki bi lahko najbolj vplivali na količino kriminala v posamezni Evropski državi in kako se količina kriminala z leti spreminja. 

1. Tabela:  Stopnja in kategorija kriminala v posameznih evropskih državah https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&region=150&displayColumn=0 (HTML), https://ec.europa.eu/eurostat/databrowser/view/CRIM_OFF_CAT__custom_2456657/default/table?lang=en (CSV)
    * Država
    * Leto
    * Indeks kriminala
    * Kategorija kaznivega dejanja 
    * Število kaznivih dejanj po kategorijah na 1000 prebivalcev

2. Tabela: Značilnosti zapornikov https://ec.europa.eu/eurostat/databrowser/view/crim_pris_off/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/crim_pris_age/default/table?lang=en (CSV)
    * Število zapornikov
    * Spol
    * Starost 
    * Kategoriji kaznivega dejanja 

3. Tabela: Stopnja izobrazbe, revščine, odstotek brezposelnih ter zadolženih ljudi v posameznih evropskih državah https://ec.europa.eu/eurostat/databrowser/view/edat_lfs_9903/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/ilc_di12/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/edat_lfs_9903/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/lfsq_urgan/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/hlth_dm050/default/table?lang=en (CSV), https://ec.europa.eu/eurostat/databrowser/view/ilc_li02$DV_548/default/table?lang=en (CSV)
    * Država
    * Leto
    * Stopnja izobrazbe
    * Odstotek brezposelnih
    * Odstotek zadolženih ljudi
    * Stopnja revščine
    * Porazdelitev dohodka - Ginijev koeficient 



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
