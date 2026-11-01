$fidoScriptSavePath = Join-Path -Path $env:TEMP -ChildPath 'Fido.ps1'
if (Test-Path -Path $fidoScriptSavePath) { Remove-Item -Path $fidoScriptSavePath }
$fidoRawGithubLink = 'https://raw.githubusercontent.com/pbatard/Fido/refs/heads/master/Fido.ps1'
Invoke-WebRequest -Uri $fidoRawGithubLink -OutFile $fidoScriptSavePath
Unblock-File -Path $fidoScriptSavePath
& $fidoScriptSavePath