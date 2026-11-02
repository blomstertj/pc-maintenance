Set-MpPreference -DeploymentChannel ReleaseBroad
Set-MpPreference -EngineUpdatesChannel Broad
Set-MpPreference -SignatureUpdatesChannel Broad
Set-MpPreference -PlatformUpdatesChannel Broad
Set-MpPreference -EnableLowCpuPriority $true