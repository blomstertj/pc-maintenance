winget install JanDeDobbeleer.OhMyPosh --source winget
oh-my-posh font install meslo

#region: Set Default Windows Terminal Font
#region: Windows Terminal Settings File Path
$winTermSettingsJsonPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
$winTermSettings = Get-Content -Path $winTermSettingsJsonPath -Raw | ConvertFrom-Json
#endregion

#region: Windows Terminal Profile Settings
$wtsProfiles = $null
$wtsProfiles = $winTermSettings | Select-Object -ExpandProperty profiles -ErrorAction SilentlyContinue
#endregion

#region: Windows Terminal Profile Defaults Settings
if ($null -eq $wtsProfiles) {
    $winTermSettings | Add-Member -NotePropertyName profiles -NotePropertyValue @{}
    $wtsProfiles = $winTermSettings | Select-Object -ExpandProperty profiles
}
#endregion

#region: Windows Terminal Profile Defaults Font Settings
$wtsProfilesDefaults = $null
$wtsProfilesDefaults = $wtsProfiles | Select-Object -ExpandProperty defaults -ErrorAction SilentlyContinue
if ($null -eq $wtsProfilesDefaults) {
    $wtsProfiles | Add-Member -NotePropertyName defaults -NotePropertyValue @{}
    $wtsProfilesDefaults = $wtsProfiles | Select-Object -ExpandProperty defaults
}
#endregion

#region: Windows Terminal Profile Defaults Font Settings
$wtsProfilesDefaultsFont = $null
$wtsProfilesDefaultsFont = $wtsProfilesDefaults | Select-Object -ExpandProperty font -ErrorAction SilentlyContinue
if ($null -eq $wtsProfilesDefaultsFont) {
    $wtsProfilesDefaults | Add-Member -NotePropertyName font -NotePropertyValue @{}
}
#endregion

#region: Windows Terminal Settings Update
$winTermSettings.profiles = $wtsProfiles
$winTermSettings.profiles.defaults = $wtsProfilesDefaults
$winTermSettings.profiles.defaults.font = $wtsProfilesDefaultsFont
$winTermSettings.profiles.defaults.font.face = 'MesloLGM Nerd Font'
#endregion

$winTermSettings | ConvertTo-Json -Depth 100 | Out-File -FilePath $winTermSettingsJsonPath -Encoding utf8 -Force
#endregion

#region: PowerShell Profile Update
$newProfileSourcePath = Join-Path -Path $PSScriptRoot -ChildPath 'Microsoft.PowerShell_profile.ps1'
if (Test-Path -Path $newProfileSourcePath) {
    $currentProfileContent = Get-Content -Path $PROFILE -Raw -ErrorAction SilentlyContinue
    $newProfileContent = Get-Content -Path $newProfileSourcePath -Raw
    if ($currentProfileContent -ne $newProfileContent) {
        $updatedProfileContent = $currentProfileContent
        $updatedProfileContent += [Environment]::NewLine * 2
        $updatedProfileContent += $newProfileContent
        $updatedProfileContent | Out-File -FilePath $PROFILE -Encoding utf8 -Force
    }
}
#endregion