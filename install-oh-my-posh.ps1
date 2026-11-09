winget install JanDeDobbeleer.OhMyPosh --source winget
oh-my-posh font install meslo

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
    $wtsProfiles = @{}
    $winTermSettings | Add-Member -NotePropertyName profiles -NotePropertyValue $wtsProfiles
}
#endregion

#region: Windows Terminal Profile Defaults Font Settings
$wtsProfilesDefaults = $null
$wtsProfilesDefaults = $wtsProfiles | Select-Object -ExpandProperty defaults -ErrorAction SilentlyContinue
if ($null -eq $wtsProfilesDefaults) {
    $wtsProfilesDefaults = @{}
    $wtsProfiles | Add-Member -NotePropertyName defaults -NotePropertyValue $wtsProfilesDefaults
    $wtsProfilesDefaults = $wtsProfiles | Select-Object -ExpandProperty defaults
}
#endregion

#region: Windows Terminal Profile Defaults Font Settings
$wtsProfilesDefaultsFont = $null
$wtsProfilesDefaultsFont = $wtsProfilesDefaults | Select-Object -ExpandProperty font -ErrorAction SilentlyContinue
if ($null -eq $wtsProfilesDefaultsFont) {
    $wtsProfilesDefaultsFont = @{}
    $wtsProfilesDefaults | Add-Member -NotePropertyName font -NotePropertyValue $wtsProfilesDefaultsFont
}
#endregion


#region: Windows Terminal Profile Defaults Font Face Settings
$wtsProfilesDefaultsFontFace = $null
$wtsProfilesDefaultsFontFace = $wtsProfilesDefaultsFont | Select-Object -ExpandProperty face -ErrorAction SilentlyContinue
if ($null -eq $wtsProfilesDefaultsFontFace) {
    $wtsProfilesDefaultsFontFace = 'MesloLGM Nerd Font'
    $wtsProfilesDefaultsFont.face = $wtsProfilesDefaultsFontFace
}
#endregion

#region: Windows Terminal Settings Update
$winTermSettings.profiles = $wtsProfiles
$winTermSettings.profiles.defaults = $wtsProfilesDefaults
$winTermSettings.profiles.defaults.font = $wtsProfilesDefaultsFont
$winTermSettings.profiles.defaults.font.face = $wtsProfilesDefaultsFontFace

$winTermSettings | ConvertTo-Json -Depth 100 | Out-File -FilePath $winTermSettingsJsonPath -Encoding utf8 -Force
#endregion