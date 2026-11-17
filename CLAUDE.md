# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Czym jest to repo

Strona `lucznik.slomnicki.net`: galeria skanów instrukcji obsługi maszyny do szycia Łucznik 466 (udostępnionej przez Mirellę). Brak build systemu, testów i lintera — czysty HTML/CSS/JS w jednym pliku, serwowany z kontenera nginx.

## Komendy

```
docker build -t lucznik .
docker run --rm -p 8080:8080 lucznik   # podgląd: http://localhost:8080
```

Do szybkiej edycji wystarczy otworzyć `index.html` w przeglądarce.

## Architektura

- `index.html` — cała strona (UTF-8): siatka miniatur generowana w JS z listy numerów + lightbox (klawiatura ←/→/Esc). Lista numerów w skrypcie ma lukę (brak `010`) — odpowiada plikom na dysku.
- `foto NNN.jpg` — oryginały (lightbox), `.thumb_foto NNN.jpg` — miniatury (siatka), `.slide_foto NNN.jpg` — pozostałość po igalu, nieużywana przez obecną stronę. `lucznik466.zip` — komplet oryginałów do pobrania.
- `Dockerfile` — `nginxinc/nginx-unprivileged` (rootless, port 8080, user 101) z kopią całego katalogu do `/usr/share/nginx/html`; `.dockerignore` wyklucza pliki repo (`.git`, `Dockerfile`, `CLAUDE.md`).

## Uwagi

- Strona była pierwotnie wygenerowana przez igal 1.4 (ISO-8859-2, osobne `N.html` na slajd); stare adresy `N.html` już nie istnieją.
- Dodanie zdjęcia: wrzuć `foto NNN.jpg` i `.thumb_foto NNN.jpg` (120 px wysokości) i dopisz numer do listy w `index.html`; zaktualizuj też `lucznik466.zip`.
