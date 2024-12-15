@echo off
set TAILSCALE_PATH="C:\Program Files\Tailscale\tailscale.exe"

:: Optimasi jaringan
netsh interface tcp set global autotuninglevel=normal
netsh interface tcp set global rss=enabled
netsh interface tcp set global chimney=enabled
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent

net config server /srvcomment:"Windows Server 2022 by @HenRDP2024" > nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > nul 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat > nul 2>&1
net user administrator HenRDP2024 /add > nul 2>&1
net localgroup administrators administrator /add > nul 2>&1
net user administrator /active:yes > nul 2>&1
net user installer /delete > nul 2>&1
diskperf -Y > nul 2>&1
sc config Audiosrv start= auto > nul 2>&1
sc start audiosrv > nul 2>&1
ICACLS C:\Windows\Temp /grant administrator:F > nul 2>&1
ICACLS C:\Windows\installer /grant administrator:F > nul 2>&1

:: Menghapus shortcut dari desktop
del /f /q "%Public%\Desktop\R 4.4.2.lnk" > nul 2>&1
del /f /q "%Public%\Desktop\Unity Hub.lnk" > nul 2>&1
del /f /q "%Public%\Desktop\Firefox.lnk" > nul 2>&1
del /f /q "%Public%\Desktop\Microsoft Edge.lnk" > nul 2>&1

:: Menjadikan Google Chrome sebagai browser default
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /v ProgId /t REG_SZ /d ChromeHTML /f > nul 2>&1
    REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice" /v ProgId /t REG_SZ /d ChromeHTML /f > nul 2>&1
)

echo Successfully Installed, If the RDP is Dead, Please Rebuild Again!
echo IP (Tailscale): 
for /f "tokens=2 delims=:" %%i in ('%TAILSCALE_PATH% ip') do echo %%i
if errorlevel 1 (
    echo Tailscale not connected. Please check your connection.
)

echo Username: administrator
echo Password: HenRDP2024
echo Please log in to your RDP via Tailscale!
ping -n 10 127.0.0.1 > nul

if exist out.txt del /f out.txt > nul 2>&1
