## Rozwiązanie
- Założenia itp

## Zadanie
Proszę wykonać prosta aplikację o następującym logicFlow (figma link) z wykorzystaniem dostarczonych assetow (plik zip).

Ekrany mogą zostać zbudowane w dowolny sposów (xib, kod, storyboars).
Aplikacja powinna byc napisana w Swit z uzyciem MVVM oraz z zasotsowaniem praktyk SOLID.
Kod prosze umieścić w publicznym repozytorium o nazwie - zadanie Atos i przesłać do mnie link.

Informacja: Projekt powinien zostać wykonany bez dodatkowych zew. bibliotek.
Jeśli takowe zostaną zastosowane będzie to miało wpływ na końcową weryfikację kodu i opinię.

Zadanie będzie oceniane pod kątem:

- działania aplikacji
- architektury MVVM + Corrdinator
- czytelności kodu
- organizacji projektu

### API:
GET [https://newsapi.org/v2/top-headlines?country=us&apiKey=8906011f7dc14fddbbdf5bbc47b93e3a](https://newsapi.org/v2/top-headlines?country=us&apiKey=8906011f7dc14fddbbdf5bbc47b93e3a)

### FigmaLink:
[https://www.figma.com/proto/jen2MgGOdvMLNRAoQg1Tn7/Atos-App?node-id=0%3A68&scaling=scale-down&page-id=0%3A1&starting-point-node-id=0%3A68](https://www.figma.com/proto/jen2MgGOdvMLNRAoQg1Tn7/Atos-App?node-id=0%3A68&scaling=scale-down&page-id=0%3A1&starting-point-node-id=0%3A68)

### Assets:
Fonts: dowolny

### Colors:
kolor tla: 50555C HEX
kolor back button: 0ACF83 HEX

### Ekran logowania:
Opis funkcjonalny:
Ekran logowania nie bedzie posiadal prawdziwej autentykacji - zostanie ona za mockowana.
Mechanizm logowania bedzie opieral sie na prostym warunku logicznym

**Happy path**:
Po wprowadzeni loginu i hasla a nastepnie po kliknieciu w przycisk login - aplikacja powinna przekierowac uzytkownika na ekran glowny.

**Dane do logowania**:
login: Admin
password: Admin1234

login: Kasia
password: Kasia1234

**Unhappy path**:
Jesli, wystapi ktorys z ponizszych warunkow - to proba logowania powinna zakonczyc sie komunikatem:

**Komunikat bledu**:
Title: Error
Message: Logowanie sie nie powiodlo.

**Przypadki**:

- pola nie moga byc puste
- podanie innych danych niz wskazane w punkcie happypath

### Ekran Glowny:

W Naglowku ma pojawic sie name osoby zalogowanej:
News's for Kasia lub News's for Admin - w zaleznosci kto sie zalogowal.

Ponizej ma sie pojawic lista artykulow dostepna w przygotowanym API.
Pelna dokumetacja do api jest tutaj [https://newsapi.org/docs/endpoints/top-headlines](https://newsapi.org/docs/endpoints/top-headlines)

Komorka powinna zawierac informacje takie jak:

- author
- title

### Ekran Details:

Zawiera on rozszerzone informacje o artykule.
W naglowku tego ekranu powinien znalezc sie Autor tekstu.
Na tym widoku powinny pojawic sie nastepujace informacje:

- author
- title
- descripton
- published at
- urlToImage

### Ekran Account:

Powinien wyswietlac:

- Obrazek dedykowany obrazek:

Dla admina - pilka nozna
Dla Kasi - piesek

- Name: imie zalogowanej osoby
- Last login: tutaj powinna sie wyswietlac biezaca data
