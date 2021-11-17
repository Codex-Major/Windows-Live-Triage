@echo off
if not exist "./logs" (
    echo [*] Made the ./logs dir...
    mkdir "./logs"
)
::assigning hostname output to %my-host% variable
%{{% hostname %--%host%}}%
if not exist "./logs/%host%" (
    echo [*] Made the ./logs/%host% dir...
    mkdir "./logs/%host%"
)
echo [+] Collecting sys-info...
set log=./logs/%host%/sys-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
systeminfo >> %log%
wmic csproduct get name >> %log%
wmic bios get serialnumber >> %log%
wmic computersystem list brief >> %log%
wmic product get name,version >> %log%
echo %PATH% >> %log%

echo [+] Collecting user-info...
set log=./logs/%host%/user-info.log
echo %TIME%-%DATE% && echo %TIME%:-%DATE% > %log%
echo [*] Info to the RIGHT! >> %log%
whoami >> %log%
net users >> %log%
net localgroup administrators >> %log%
net group administrators >> %log%
wmic rdtoggle list >> %log%
wmic useraccount list >> %log%
wmic group list >> %log%
wmic netlogin get name,lastlogon,badpasswordcount >> %log%
wmic netclient list brief >> %log%
doskey /HISTORY > ./logs/%host%/command_history.log

echo [+] Collecting net-info...
set log=./logs/%host%/net-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
netstat -e >> %log%
netstat -naob >> %log%
netstat -nr >> %log%
netstat -vb >> %log%
nbtstat -s >> %log%
route PRINT >> %log%
arp -a >> %log%
ipconfig >> %log%
ipconfig /displaydns >> %log%
netsh winhttp show proxy >> %log%
ipconfig /allcompartments /all >> %log%
netsh wlan show interfaces >> %log%
netsh wlan show all >> %log%
type %SYSTEMROOT%\system32\drivers\etc\hosts >> %log%
wmic netuse get >> %log%

echo [+] Collecting service-info...
set log=./logs/%host%/service-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
at >> %log%
tasklist >> %log%
tasklist /svc >> %log%
tasklist /svc /fi "imagename eq svchost.exe" >> %log%
tasklist /svc /fi "pid eq 0" >> %log%
tasklist /svc /fi "pid eq 4" >> %log%
schtasks >> %log%
net start >> %log%
sc query >> %log%
wmic service list brief | findstr "Running" >> %log%
wmic service list config >> %log%
wmic process list brief >> %log%
wmic process list status >> %log%
wmic process list memory >> %log%
wmic job list brief >> %log%

echo [+] Collecting settings-info...
set log=./logs/%host%/settings-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
set >> %log%
gpresult /r >> %log%
gpresult /z >> %log%
wmic qfe >> %log%

echo [+] Collecting autoload-info...
set log=./logs/%host%/autoload-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
wmic startup list full >> %log%
wmic ntdomain list brief >> %log%
dir "%SystemDrive%\ProgramData\Microsoft\Windows\SystemData" >> %log%
dir "%SystemDrive%\Documents and Settings\All Users\Start Menu\Programs\Startup" >> %log%
dir "%userprofile%\Start Menu\Programs\Startup" >> %log%
dir "%ProgramFiles%\Startup" >> %log%
dir "C:\Windows\Start Menu\Programs\startup" >> %log%
dir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup" >> %log%
dir "%ALLUSERPROFILE%\Microsoft\Windows\Start Menu\Programs\Startup" >> %log%
dir "%ALLUSERPROFILE%\Start Menu\Programs\Startup" >> %log%
type C:\Windows\winstart.bat >> %log%
type %windir%\wininit.ini >> %log%
type %windir%\win.ini >> %log%

echo [+] Collecting logs-info...
set log=./logs/%host%/logs-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
echo [*] Saving 'wevtutil epl Security to: ./logs/%host%/Security.evxt' >> %log% 
wevtutil epl Security ./logs/%host%/Security.evxt
echo [*] Saving 'wevtutil epl System to: ./logs/%host%/System.evxt' >> %log% 
wevtutil epl System ./logs/%host%/System.evxt
echo [*] Saving 'wevtutil epl Application to: ./logs/%host%/Application.evxt' >> %log% 
wevtutil epl Application ./logs/%host%/Application.evxt
wmic nteventlog get path,filename,writeable >> %log%

echo [+] Collecting drives-info...
set log=./logs/%host%/drives-info.log
echo %TIME%-%DATE% && echo %TIME%-%DATE% > %log%
net share >> %log%
net session >> %log%
wmic volume list brief >> %log%
wmic logicaldisk get description,filesystem,name,size >> %log%
wmic share get name,path >> %log%
wmic diskdrive get interfacetype,mediatype,model >> %log%

echo '[!] ALL DONE!'