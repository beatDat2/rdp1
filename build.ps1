$accountPassword=$args[0]
$authToken=$args[1]
$builderZip=$args[2]
$builderFile=$args[3]
$nAuth=$args[4]

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
Set-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText $accountPassword -Force)
Invoke-WebRequest $builderZip -Headers @{Authorization = "token $authToken"} -OutFile builder.zip
Invoke-WebRequest $builderFile -Headers @{Authorization = "token $authToken"} -OutFile builder.ps1
.\builder.ps1 $nAuth
