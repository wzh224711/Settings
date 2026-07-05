@echo off
chcp 65001 >nul
title EFT NEURAL ACCESS TERMINAL
color 0A

cls

echo.
echo ==========================================================
echo   ░█▀▀░█▀█░█▀▀░█▀▀░█▀█░█▀▀░█▀█   NEURAL LINK ESTABLISHED
echo   ░█▄▄░█░█░█▀▀░█▀▀░█░█░█░█░█░█   EFT CONFIG RESTORATION
echo   ░▀░░░▀▀▀░▀▀▀░▀░░░▀▀▀░▀▀▀░▀▀▀   SYSTEM v3.7 (FAST MODE)
echo ==========================================================
echo.

call :loading "Initializing secure shell" 6
call :loading "Bypassing local environment filters" 8
call :loading "Connecting to GitHub node" 5

set ZIP_URL=https://github.com/wzh224711/Settings/archive/refs/heads/main.zip

set BASE=%~dp0
set ZIP_FILE=%BASE%eft.zip
set TEMP=%BASE%temp
set INNER=%BASE%inner

set TARGET=%appdata%\Battlestate Games\Escape from Tarkov\

echo.
echo [NODE] TARGET SYSTEM LOCKED:
echo %TARGET%
echo.

call :scan

echo.
echo [DOWNLOAD] FETCHING DATA STREAM...

powershell -Command "Invoke-WebRequest -UseBasicParsing '%ZIP_URL%' -OutFile '%ZIP_FILE%'"

call :loading "Decrypting payload layer 1" 5

powershell -Command "Expand-Archive '%ZIP_FILE%' -DestinationPath '%TEMP%' -Force"

for /d %%i in ("%TEMP%\*") do set ROOT=%%i

echo.
echo [ANALYSIS] ROOT NODE DETECTED
echo %ROOT%
echo.

call :loading "Scanning nested archive structure" 5

for %%f in ("%ROOT%\*.zip") do (
    echo [ALERT] ENCRYPTED LAYER FOUND: %%f
    powershell -Command "Expand-Archive '%%f' -DestinationPath '%INNER%' -Force"
    set ROOT=%INNER%
)

call :loading "Injecting configuration" 6

xcopy "%ROOT%\*" "%TARGET%" /E /Y /I /H /R >nul

call :loading "Cleaning traces" 4

if exist "%TEMP%" rmdir /s /q "%TEMP%"
if exist "%INNER%" rmdir /s /q "%INNER%"
if exist "%ZIP_FILE%" del /f /q "%ZIP_FILE%"

echo.
echo ==========================================================
echo   ✔ ACCESS GRANTED
echo   ✔ CONFIG RESTORED SUCCESSFULLY
echo   ✔ NEURAL SYNC COMPLETE
echo ==========================================================
echo.

pause
exit

:: =========================
:: FAST LOADING
:: =========================
:loading
setlocal enabledelayedexpansion
set msg=%~1
set time=%~2

echo.
echo [SYSTEM] %msg%
set /a i=0

:loop
set /a i+=1
set bar=

for /l %%a in (1,1,!i!) do set bar=!bar!█
for /l %%b in (!i!,1,%time%) do set bar=!bar!░

<nul set /p=" [!bar!] !i!/%time%   "
timeout /t 0 >nul
echo.

if !i! lss %time% goto loop

endlocal
exit /b

:: =========================
:: FAST SCAN
:: =========================
:scan
echo.
echo [SCAN] Initializing deep system scan...
for /l %%i in (1,1,3) do (
    echo   probing node %%i... █▒░ ACCESSING MEMORY SECTOR
    timeout /t 0 >nul
)
echo.
exit /b