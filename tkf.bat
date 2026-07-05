@echo off
chcp 65001 >nul
title EFT Clean Restore

echo ==============================
echo   EFT 设置恢复（干净版）
echo ==============================

set ZIP_URL=https://github.com/wzh224711/Settings/archive/refs/heads/main.zip

set BASE=%~dp0
set ZIP_FILE=%BASE%eft.zip
set TEMP=%BASE%temp
set INNER=%BASE%inner

set TARGET=%appdata%\Battlestate Games\Escape from Tarkov\

echo.
echo [1/6] 清理旧文件...

if exist "%TEMP%" rmdir /s /q "%TEMP%"
if exist "%INNER%" rmdir /s /q "%INNER%"
if exist "%ZIP_FILE%" del /f /q "%ZIP_FILE%"

mkdir "%TEMP%"
mkdir "%INNER%"

echo [2/6] 下载GitHub文件...

powershell -Command "Invoke-WebRequest '%ZIP_URL%' -OutFile '%ZIP_FILE%'"

echo [3/6] 解压主ZIP...

powershell -Command "Expand-Archive '%ZIP_FILE%' -DestinationPath '%TEMP%' -Force"

for /d %%i in ("%TEMP%\*") do set ROOT=%%i

echo ROOT=%ROOT%

echo [4/6] 检查二次ZIP...

for %%f in ("%ROOT%\*.zip") do (
    echo 解压二次ZIP：%%f
    powershell -Command "Expand-Archive '%%f' -DestinationPath '%INNER%' -Force"
    set ROOT=%INNER%
)

echo [5/6] 复制文件...

xcopy "%ROOT%\*" "%TARGET%" /E /Y /I /H /R

echo [6/6] 清理临时文件...

if exist "%TEMP%" rmdir /s /q "%TEMP%"
if exist "%INNER%" rmdir /s /q "%INNER%"
if exist "%ZIP_FILE%" del /f /q "%ZIP_FILE%"

echo.
echo ==============================
echo ✅ 完成！已恢复 Tarkov 设置
echo 目标路径：
echo %TARGET%
echo ==============================

pause