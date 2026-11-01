$scheduledTasks = Get-ScheduledTask -TaskPath '\'
$scheduledTasks | Where-Object -Property TaskName -match '^MicrosoftEdgeUpdate' | Disable-ScheduledTask
$scheduledTasks | Where-Object -Property TaskName -match '^NvDriverUpdateCheckDaily' | Disable-ScheduledTask
$scheduledTasks | Where-Object -Property TaskName -match '^NVIDIA App SelfUpdate' | Disable-ScheduledTask
Get-ScheduledTask -TaskPath '\Ubisoft\' | Disable-ScheduledTask