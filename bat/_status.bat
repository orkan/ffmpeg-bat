@echo off
set EXTRA=%1

echo.
if %ERRORLEVEL% == 0 (
	echo BUILD SUCCESSFUL
	if "%EXTRA%" == "quit_on_success" goto :eof
) else (
	echo BUILD FAILED [Error: %ERRORLEVEL%]
)

echo.
pause
