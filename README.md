# Analiza podatkov s programom R - 2021/22

Vzorčni repozitorij za projekt pri predmetu APPR v študijskem letu 2021/22. 

## Analiza kriminala v Evropi

V projektni nalogi bom analizira kriminal v Evropi. Osredotočila se bom na obdobje od leta 2010 do leta 2020

Cilj projektne naloge je prikazati, kateri dejavniki bi lahko najbolj vplivali na količino kriminala v posamezni Evropski državi in kako se količina kriminala z leti spreminja. 

1. Tabela:  stopnja kriminala v posameznih Evropskih državah https://www.numbeo.com/crime/rankings_by_country.jsp?title=2020&region=150&displayColumn=1 (HTML)
    * Država
    * Indeks kriminala

2. Tabela: Stopnja izobrazbe v posameznih Evropskih državah https://ec.europa.eu/eurostat/databrowser/view/edat_lfs_9903/default/table?lang=en (CSV)
    * Država
    * Leto
    * Stopnja izobrazbe

3. Tabela: Stopnja brezposelnost v posameznih Evropskih državah https://ec.europa.eu/eurostat/databrowser/view/lfsq_urgan/default/table?lang=en (CSV)
    * Država
    * Leto
    * Odstotek brezposelnih

4. Tabela: Odstotek zadolženih ljudi v posameznih Evropskih državah https://ec.europa.eu/eurostat/databrowser/view/hlth_dm050/default/table?lang=en (CSV)
    * Država
    * Leto
    * Odstotek zadolženih ljudi

5. Tabela: Stopnja revščine v posameznih Evropskih državah https://ec.europa.eu/eurostat/databrowser/view/ilc_li02$DV_548/default/table?lang=en (CSV)
    * Država
    * Leto
    * Stopnja revščine



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
