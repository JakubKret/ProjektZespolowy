# Dane testowe - branch `testing`

## Konto testowe (auto-login)

Aplikacja na tym branchu automatycznie tworzy i loguje konto testowe przy pierwszym uruchomieniu.
Nie trzeba nic wpisywac recznie.

| Pole           | Wartosc              |
|----------------|----------------------|
| Email          | `test@hdk.pl`        |
| Haslo          | `test123`            |
| Imie           | Jan                  |
| Nazwisko       | Kowalski             |
| Plec           | M (mezczyzna)        |
| Grupa krwi     | 0 Rh+                |
| Data urodzenia | 1995-03-15           |

## Dane donacji (pre-loaded)

Konto testowe ma 8 donacji krwi pelnej (450 ml kazda, lacznie 3.6 L):

| Data       | Objetosc | Placowka                  |
|------------|----------|---------------------------|
| 2024-01-10 | 450 ml   | RCKiK w Bialymstoku       |
| 2024-04-20 | 450 ml   | RCKiK w Bialymstoku       |
| 2024-08-05 | 450 ml   | RCKiK w Bydgoszczy        |
| 2024-11-15 | 450 ml   | RCKiK w Bialymstoku       |
| 2025-03-01 | 450 ml   | RCKiK w Gdansku           |
| 2025-06-20 | 450 ml   | RCKiK w Bialymstoku       |
| 2025-10-10 | 450 ml   | RCKiK w Bydgoszczy        |
| 2026-01-15 | 450 ml   | RCKiK w Bialymstoku       |

## Odznaki (automatycznie przyznane)

Przy 3.6 L oddanej krwi zadna odznaka ZHDK nie jest jeszcze zdobyta (prog ZHDK III to 6 L dla mezczyzn).

## Placowki

23 placowki RCKiK z calej Polski sa seedowane automatycznie (wszystkie z koordynatami GPS).

## Stany krwi na mapie

Dane o stanach krwi w placowkach sa generowane jako mock (deterministyczny seed).
Kolory oznaczaja:
- Czerwony: stan krytyczny (<5 j.)
- Pomaranczowy: niski (5-14 j.)
- Zolty: umiarkowany (15-29 j.)
- Zielony: dobry (30+ j.)

## Powiadomienie o niedoborze

Jesli w najblizszej placowce grupa 0 Rh+ ma status krytyczny lub niski, a uzytkownik moze oddac krew (brak karencji), wyswietla sie alert z informacja.

## Roznice wzgledem brancha `develop`

- `main.dart`: auto-login konta testowego (bez ekranu logowania)
- `lib/core/bootstrap/test_data_seed.dart`: seeder danych testowych
- `credentials.md`: ten plik
