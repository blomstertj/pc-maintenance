@echo off & title "Update Apps - WinGet"
:: Update all installed applications using WinGet silently without user interaction and accept all agreements
winget upgrade --silent --accept-package-agreements --accept-source-agreements --disable-interactivity --all
pause