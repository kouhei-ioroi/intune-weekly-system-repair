$TaskName = "Weekly-System-Repair"

if (Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue) {
    Write-Output "タスク '$TaskName' は登録されています。"
    exit 0
}else {
    Write-Output "タスク '$TaskName' は登録されていません。"
    exit 1
}