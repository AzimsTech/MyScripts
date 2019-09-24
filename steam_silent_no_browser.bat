@echo off &color 4f &mode 80,4 &title Steam fast restart with SkipGameUpdate and no crash/repair
:: [2018.12.12]: switch old friends ui on and fix silent mode so it goes straight to systray icon
set "STEAMPATH=D:\Steam" &rem AveYo:" Override detection here if needed "
:: detect steam
if not exist "%STEAMPATH%\Steam.exe" call :reg_query STEAMPATH "HKCU\SOFTWARE\Valve\Steam" "SteamPath"
if defined STEAMPATH for %%# in ("%STEAMPATH%") do set "STEAMPATH=%%~dpnx#"
if not exist "%STEAMPATH%\Steam.exe" echo Cannot find SteamPath in registry! & timeout /t 3 & exit
:: kill and restart steam
taskkill /im Steam.exe /t /f >nul 2>nul & timeout /t 1 >nul & del /f /q "%STEAMPATH%\.crash" >nul 2>nul & timeout /t 1 >nul
set l1=-silent -console -forceservice -single_core -windowed -manuallyclearframes 0 -nodircheck -norepairfiles -noverifyfiles
set l2=-nocrashmonitor -nocrashdialog -vrdisable -nofriendsui -no-browser -tcp -skipstreamingdrivers +"@AllowSkipGameUpdate 1 -
start "Steam" "%STEAMPATH%\Steam.exe" %l1% %l2%
exit
:: utility
:reg_query [USAGE] call :reg_query ResultVar "HKCU\KeyName" "ValueName"
(for /f "skip=2 delims=" %%s in ('reg query "%~2" /v "%~3" /z 2^>nul') do set ".=%%s" & call set "%~1=%%.:*)    =%%") & exit/b