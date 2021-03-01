@echo off
setlocal
REM Tip: Status codes https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400

REM Import: -------------------------------------------------
set INPUT=%~1
set EXTRA=%2

if "%INPUT%" == "" (
	echo Empty input
	exit /b 400
)
if not exist "%INPUT%" (
	echo File not found: "%INPUT%"
	exit /b 404
)
if "%EXTRA%" == "silent" (
	exit /b
)

echo File: %INPUT%
