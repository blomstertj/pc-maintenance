$profileRootPath = $PROFILE | Split-Path -Parent
$themeName = 'tokyo'
$themePath = Join-Path -Path $profileRootPath -ChildPath ('{0}.omp.json' -f $themeName)
if (Test-Path -Path $themePath) {
    $lastWriteTime = (Get-Item -Path $themePath).LastWriteTime
    if (((Get-Date) - $lastWriteTime).TotalDays -gt 7) {
        Remove-Item -Path $themePath -Force | Out-Null
	$themeUrl = 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/{0}.omp.json' -f $themeName
        Invoke-WebRequest -Uri $themeUrl -OutFile $themePath
	Unblock-File -Path $themePath
    }
}
oh-my-posh init pwsh --config $themePath | Invoke-Expression
