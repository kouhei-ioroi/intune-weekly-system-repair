$TaskName = "Weekly-System-Repair"

# 実行アクション
$Action = @(
    (New-ScheduledTaskAction `
    -Execute "cmd.exe" `
    -Argument "/c dism.exe /Online /Cleanup-Image /RestoreHealth"),
    (New-ScheduledTaskAction `
    -Execute "cmd.exe" `
    -Argument "/c sfc.exe /scannow")
)

# 毎週日曜日0:00に実行
$Trigger = New-ScheduledTaskTrigger `
    -At 0:00 `
    -Weekly `
    -DaysOfWeek Sunday
    

# SYSTEMで実行（最高権限）
$Principal = New-ScheduledTaskPrincipal `
    -UserId "NT AUTHORITY\SYSTEM" `
    -LogonType ServiceAccount `
    -RunLevel Highest

# 設定
$Settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -RestartCount 3 `
    -RestartInterval (New-TimeSpan -Minutes 1) `
    -RunOnlyIfNetworkAvailable `
    -StartWhenAvailable

# 登録
Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $Trigger `
    -Principal $Principal `
    -Settings $Settings `
    -Force
