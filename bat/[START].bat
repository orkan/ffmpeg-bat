@echo off
setlocal EnableDelayedExpansion
set DATESTART=%DATE% %TIME%
set PATHS=%1
if "%PATHS%" == "" (
	REM Set default (demo/test) file to load if none provided
	set "PATHS=%~dp0..\usr\tests.bat"
)

call _header.bat "%~nx0"
echo ******************************************************************
echo  Converter: [Video] -^> [ffmpeg] -^> [mp4]
echo  -----------------------------------------------------------------
echo  Paths: %PATHS%
echo  TIP: Remove all "^!" from filenames b/c of EnableDelayedExpansion
echo ******************************************************************
echo.
echo Queue:
call :config %PATHS% show
echo.
set /p HIBERNATE=Hibernate when done? (yes/[no]): 

call :config %PATHS% run || goto :end
goto :end

REM FUNCTION::config() ---------------------------------
:config
for /f "tokens=*" %%a in ( 'call "%1"' ) do ( 
	call :start %2 %%a
)
goto :eof

REM FUNCTION::start() ----------------------------------
:start
for %%f in (%3) do (

	set COMMAND=%2 "%%f" %4 %5 %6 %7

	if "%1" == "show" (
		echo call !COMMAND!
	) else (
		echo.
		call !COMMAND! || goto :end
	)
)
goto :eof

REM Finalize: ------------------------------------------
:end
echo.
echo Started  on: %DATESTART%
echo Finished on: %DATE% %TIME%

if "%HIBERNATE%" == "yes" (
	echo.
	echo Hibernating...
	if "%FFMPEG_DEBUG%" == "" (
		shutdown /h
	)
)

call _status.bat

if "%ERRORLEVEL%" NEQ "0" exit
