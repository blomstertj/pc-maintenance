@echo off & title "PowerShell 7 (msi/wix) Install - WinGet"
:: Install PowerShell 7 MSI package
winget install --id Microsoft.PowerShell --exact --source winget --installer-type wix
pause