# Fuksipassi
 
## Tarkoitus
 
Webappi, jolla fuksit voivat ilmoittaa osallistuneensa tapahtumilla, ja saada siitä pisteitä. Näin voidaan kannustaa tapahtumiin osallistumista ja muutenkin aktiivisena olemista. 
 
## Käyttö 
 
### Rekisteröityminen
 
Käyttääkseen fuksipassia, täytyy olla kirjautunut. Tilin voi luoda kuka vain, sähköpostilla ja koko nimella. Haluttaessa voidaan vaatia sähköpostin varmistamista. 
 
### Käyttäjät 
 
Käyttäjätasoja on kolme. Admin, Fuksi ja Tutor. Fuksi näkee pelkästään etusivun, jolla on listaus tapahtumista, oman sivunsa, sekä omat asetuksensa. Tutor ja Admin voivat luoda tapahtumia, nähdä fuksit pistejärjestyksessä, sekä hyväksyä osallistumisia ja antaa bonusosallistumispisteitä. 
 
### Osallistuminen
 
Fuksipassissa on kolme eri osallistumistyyppiä. Ensimmäinen on tapahtuma, jolla on aika, sekä mahdollisesti kuvaus, ja linkki tapahtumasivulle. Tapahtumalla voi myös olla ylimääräisiä bonusosallistumisia, kuten “pyydä laulua - fuksisitsit”. 
 
Tutor voi luoda tapahtuman tapahtumasivulta, ja bonusosallistumisen itse tapahtuman omalta sivulta. 
 
Fuksi näkee tapahtuman osallistumiset joita hän ei ole vielä pyytänyt itse tapahtuman sivulta, dropdown-valikosta. 
 
Kolmas osallistumistyyppi on haaste. Se näkyy etusivulla tapahtumien ohella, mutta sillä ei ole päivämäärää. 
 
### Ylimääräiset pisteet
 
Tutor voi antaa fukseille ylimääräisiä pisteitä, viestin kera. Antaessaan pisteitä, tutor voi valita näkyykö pistemäärä fuksille, tai näkyykö pelkää viesti. 
 
### Sivut 
 
#### Etusivu
 
Käyttäjät: Kaikki
 
Etusivulla on kolme vierekkäistä kolumnia, puhelimella peräkkäistä. Ensimmäinen näyttää tapahtumat joihin käyttäjä ei ole vielä osallistunut. Toinen näyttää tulevat tapahtumat. Kolmas näyttää tapahtumat, joihin fuksi on osallistunut. 
 
#### Tapahtuman sivu 
 
Käyttäjät: kaikki
 
Tapahtuman sivulla näkyy osallistumisen pisteet, sekä dropdown-valikko, josta voi pyytää osallistumispisteitä. 
 
Tutor voi lisätä täältä tapahtumaan bonuspisteitä. 
 
#### Overview-sivu
 
Käyttäjät: tutor
 
Tällä sivulla tutor näkee 1) listan hyväksymättömistä osallistumisista, ja voi hyväksyä ne monta kerrallaan. 2) listan fukseista, pistejärjestyksessä
 
#### Käyttäjän sivu 
 
Käyttäjät: fuksi: oma sivu, tutor: kaikkien 
 
Käyttäjän sivulla näkee käyttäjän tiedot, sekä mahdollisen profiilikuvan. 
 
##### Käyttäjän osallistumispisteet
 
Confirmed points: näyttää hyväksytyt pisteet, jotka näkyvät fuksille. 
All points: näyttää kaikki pisteet, jotka näkyvät fuksille
Real points: näyttää kaikki pisteet, myös ne, jotka ovat vain tuutoreiden näkyvillä (vain tuutorin näkyvillä)
 
##### Tapahtumalistaus
 
Tapahtumalistauksessa näkyy fuksin osallistumat hommat, sekä ovatko ne hyväksyttyjä vai ei. 
 
##### Bonuspistelistaus
 
Bonuspistelistauksessa näkyy bonuspisteet, sekä niiden pisteet, jos ne on asetettu näkyviin. Tutor voi poistaa niitä painamalla roskakori-nappia. 
 
Tutor voi antaa bonuspisteitä käyttäjän sivun yläreunassa olevasta lomakkeesta. 
 
#### Käyttäjät sivu
 
Listaa kaikki käyttäjät, sekä heidän roolinsa. 
 
## Testausperiaate
 
On pyritty testaamaan ensisijaisesti niitä asioita, joilla fuksi voi rikkoa sivuston, halutessaan tai vahingossa. Tärkeimpiä ovat: fuksi ei voi hyväksyä tai lisätä tapahtumia. Fuksi ei voi pyytää enempää kuin kerran tapahtumapisteitä. JNE 
 
 
 
## Datamalli
 
![Datamalli](https://i.imgur.com/yDwXyxr.png)
 
#### Year
* Toistaiseiseksi käytttämätön laajannusmahdollisuus, jos haluttaisiin esimerkiksi säilyttää vanhoja tilastoja menneiltä vuosilta emmekä tyhjentäisi passia joka vuosi uusien fuksien tultua
#### User
* Käyttäjästä tallennetaan tarvittavat perustiedot. Nimi, sähköposti, ircnick. Lisäksi käyttäjälle voidaan tallentaa valokuva (carrierwave toimii uploaderina ja kuvat tallentuvat imaginary gemin pilveen) Käytimme Devise-gemiä, joka hallinnoi käyttäjän salasanan salausta, salasanan palautusta ja tarvittaessa sähköpostin varmistusta jne.
#### Role
* Rolify-gemin määrittämä luokka käyttäjäroolien hallintaan
#### Event
* Kuvaa fuksitapahtumia
#### Participation:
* Kuvaa fuksitapahtumiin liittyviä osasuorituksia. Esimerkiksi fuksisitseillä osasuorituksesta ‘osallistuminen’ voisi saada 5 pistettä ja osasuorituksesta ‘laulun pyytäminen’ 3 pistettä.
#### ParticipationRequest:
* Kun fuksi pyytää osallistumista jonkin tapahtuman (Event) osasuoritukseen (Participation) luodaan ParticipationRequest. Pyyntö tulee tuutorien nähtäväksi ja tuutorin hyväksyttyä pyynnön tallennetaan tuutori pyyntöön pyynnön hyväksyjäksi.
#### Note
* Luokka sekalaisille pistemerkinnöille mitä tuutorit voivat antaa fukseille lennosta.
 
