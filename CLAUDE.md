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

- `index.html` — cała strona (UTF-8), przeglądarka w formie książki: każdy skan `foto-NNN.jpg` to rozkładówka (dwie strony), poza okładką (`foto-001`, pojedyncza strona). Skan jest cięty na lewą/prawą połowę przez `background-size:200%`; zmiana strony to element `.leaf` obracany w CSS 3D wokół grzbietu (`go()`), a `shift()` centruje zamkniętą książkę. Lista numerów w skrypcie ma lukę (brak `010`) — odpowiada plikom na dysku. Stan strony trzymany w `#hash`.
- `foto-NNN.jpg` — jedyne używane obrazy. `lucznik466.zip` — komplet oryginałów do pobrania.
- `Dockerfile` — `nginxinc/nginx-unprivileged` (rootless, port 8080, user 101) z kopią całego katalogu do `/usr/share/nginx/html`; `.dockerignore` wyklucza pliki repo (`.git`, `Dockerfile`, `CLAUDE.md`).

## Uwagi

- Strona była pierwotnie wygenerowana przez igal 1.4 (ISO-8859-2, osobne `N.html` na slajd); stare adresy `N.html` już nie istnieją.
- Dodanie skanu: wrzuć `foto-NNN.jpg` i dostosuj listę `nums` w `index.html`; zaktualizuj też `lucznik466.zip`. Strony okładki/pojedyncze wymagałyby osobnej obsługi (teraz tylko indeks 0).

## CI

`.github/workflows/docker.yml` buduje obraz na każdy push/PR, a poza PR-ami wypycha go do `ghcr.io/mslomnicki/lucznik-service-manual` (tagi: `latest` z domyślnej gałęzi, `sha-…`, oraz semver dla tagów `v*`). Autoryzacja przez `GITHUB_TOKEN`.
