 gci -Filter "*.ini" -Recurse -Path .
 Get-ChildItem -Filter *.xls* | ForEach-Object { Invoke-Item $_.FullName }
Get-ChildItem -Path "." -Recurse -Filter *.ini | Select-String -Pattern "SimulationDataStore" 

$path = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$path;C:\Users\ALICIA\Desktop\STORE3A\OPENSIM_NEW\SERVERS\opensim-0.9.1.1\bin"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")

$path = [Environment]::GetEnvironmentVariable("Path", "Machine")
$newPath = "$path;C:\Users\ALICIA\Desktop\STORE3A\OPENSIM_NEW\SERVERS\opensim-0.9.1.1\bin\"
[Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")