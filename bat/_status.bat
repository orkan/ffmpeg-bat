@echo off
set EXTRA=%1

echo.
if "%ERRORLEVEL%" == "0" (
	echo BUILD SUCCESSFUL

	if "%EXTRA%" == "quit_on_success" (
		goto :eof
	)

) else (
	REM Tip: Status codes https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400
	echo BUILD FAILED [Error: %ERRORLEVEL%]
)

echo.
pause
