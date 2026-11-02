$scheduledTasks = Get-ScheduledTask -TaskPath '\'
$scheduledTasks | Where-Object -Property TaskName -match '^MicrosoftEdgeUpdate' | Disable-ScheduledTask
$scheduledTasks | Where-Object -Property TaskName -match '^NvDriverUpdateCheckDaily' | Disable-ScheduledTask
$scheduledTasks | Where-Object -Property TaskName -match '^NVIDIA App SelfUpdate' | Disable-ScheduledTask
Get-ScheduledTask -TaskPath '\Ubisoft\' | Disable-ScheduledTask


$serviceNames = @(
    'edgeupdate',
    'edgeupdatem',
    'FoxitReaderUpdateService'
)

foreach ($serviceName in $serviceNames) {
    $service = $null
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($service) {
        Stop-Service -Name $serviceName -Force
        Set-Service -Name $serviceName -StartupType Disabled
    }
}