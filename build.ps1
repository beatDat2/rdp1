$ngrokAuthToken=$args[0]
$accountPassword=$args[1]

Invoke-WebRequest https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip -OutFile ngrok.zip
Expand-Archive ngrok.zip
run: .\ngrok\ngrok.exe authtoken $ngrokAuthToken
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1
Set-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText $accountPassword -Force)
Start-Process Powershell -ArgumentList '-Noexit -Command ".\ngrok\ngrok.exe tcp 3389"'
