@echo off & title Update Apps - WinGet
winget upgrade --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --all
pause