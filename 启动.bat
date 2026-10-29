@echo off
chcp 65001 >nul 2>&1
title BTC 一分钟涨跌预测 - 启动器
cd /d "%~dp0"
set "PORT=8765"
set "PYCMD="

rem ---- 找 Python ----
where py >nul 2>nul && set "PYCMD=py"
if not defined PYCMD (where python >nul 2>nul && set "PYCMD=python")

rem ---- 找 Chrome（用于无地址栏的应用窗口，观感更像独立软件）----
set "CHROME="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined CHROME if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "CHROME=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not defined CHROME if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "CHROME=%LocalAppData%\Google\Chrome\Application\chrome.exe"

rem ---- 没有 Python 就直接开本地文件 ----
if not defined PYCMD goto direct

echo.
echo   BTC 一分钟涨跌预测
echo   --------------------------------------------
echo   本地服务  http://127.0.0.1:%PORT%
echo   浏览器会自动打开，请稍候...
echo.
echo   [说明] 这个最小化的窗口就是服务进程，
echo          关闭它等于退出软件。
echo.

netstat -ano | findstr /c:":%PORT% " | findstr LISTENING >nul 2>nul
if %errorlevel%==0 goto openurl

start "BTC预测-本地服务" /min %PYCMD% -m http.server %PORT% --bind 127.0.0.1
timeout /t 2 >nul

:openurl
if defined CHROME (
  start "" "%CHROME%" --app="http://127.0.0.1:%PORT%/index.html" --window-size=1520,1000
) else (
  start "" "http://127.0.0.1:%PORT%/index.html"
)
exit /b

:direct
echo 未检测到 Python，直接用浏览器打开本地页面...
if defined CHROME (
  start "" "%CHROME%" --app="%~dp0index.html" --window-size=1520,1000
) else (
  start "" "%~dp0index.html"
)
exit /b
