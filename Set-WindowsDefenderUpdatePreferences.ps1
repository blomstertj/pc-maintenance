Set-MpPreference -EngineUpdatesChannel Broad -Verbose
Set-MpPreference -SignatureUpdatesChannel Broad -Verbose
Set-MpPreference -PlatformUpdatesChannel Broad -Verbose
Set-MpPreference -EnableLowCpuPriority $true -Verbose
Update-MpSignature -Verbose