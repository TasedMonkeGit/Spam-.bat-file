@echo off
set "runtime=5"

:: Create the popup script with error icon
>popup.vbs echo Set s=CreateObject("WScript.Shell")
>>popup.vbs echo s.Popup "YOU ARE A DIRTY BITCH", 0, "Critical Error", 16

:: Calculate stop time
for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    set /a stoptime=%%a*3600+%%b*60+%%c+%runtime%
)

:spam
start "" popup.vbs

:: ~100 millisecond delay using ping
ping 127.0.0.1 -n 1 -w 100 >nul

for /f "tokens=1-4 delims=:. " %%a in ("%time%") do (
    set /a now=%%a*3600+%%b*60+%%c
)

if %now% lss %stoptime% goto spam

:: Close all popups at the end
taskkill /im wscript.exe /f >nul 2>&1
del popup.vbs
exit
