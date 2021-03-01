@echo off
setlocal
call _header.bat "%~nx0"

echo ***************************************************
echo   Cut video by start/end timestamps
echo.
echo   Usage  : %~nx0 infile [start] [end] [outfile]
echo   Note   : [start] and [end] are optional, use "" if empty
echo   Example: %~nx0 "infile.mp4" 10:08 1:25:18
echo ***************************************************

REM Import: --------------------------------------------
set INFILE=%~1
set SS=%~2
set TO=%~3
set OUTFILE=%~4

REM Display: -------------------------------------------
echo Inputs:
echo INFILE  : [%INFILE%]
echo SS      : [%SS%]
echo TO      : [%TO%]
echo OUTFILE : [%OUTFILE%]

REM Config: --------------------------------------------
set SS=-ss %SS%
set TO=-to %TO%
if "%SS%" == "-ss " set SS=-ss 0
if "%TO%" == "-to " set TO=

REM Strings: -------------------------------------------
set SS_STR=%SS::=,%
if "%TO%" NEQ "" (
	set TO_STR=%TO::=,%
)

REM Outfile: -------------------------------------------
if "%OUTFILE%" == "" (
	REM Use quoted set "FILE=name with ().ext" in case of parenthesized file names!
	set "PATH1=%~dpn1"
	set "PATH2=%~x1"
) else (
	set "PATH1=%~dpn4"
	set "PATH2=%~x4"
)
set OUTFILE=%PATH1%.[%SS_STR%][%TO_STR%]%PATH2%

REM META tags: -----------------------------------------
set META=%META_GLOBAL% -metadata comment="%~nx0 [%SS%] [%TO%]"

REM Wait: -------------------------------------------
REM Don't run multiple threads on the same time b/c of disk usage overhead
:wait
set WAIT_FILE=%~dpn0.tmp
if not exist "%WAIT_FILE%" (
	echo %OUTFILE% > "%WAIT_FILE%"
	goto :command
)
call :waitSleep 4
goto :wait

REM Command: -------------------------------------------
:command
REM https://wjwoodrow.wordpress.com/2013/02/04/correcting-for-audiovideo-sync-issues-with-the-ffmpeg-programs-itsoffset-switch/
REM https://superuser.com/questions/138331/using-ffmpeg-to-cut-up-video
set COMMAND=ffmpeg -y -i "%INFILE%" %SS% %TO% -map 0:v -map 0:a:0 -map 0:a:1? -c copy %META% "%OUTFILE%"

REM Run: -----------------------------------------------
pushd %~dp0
echo.
call %COMMAND%
popd

del "%WAIT_FILE%"
exit /b %ERRORLEVEL%

REM Functions: -----------------------------------------
:waitSleep
if "%WAIT_SHOW%" == "" (
	echo.
	echo Waiting for previous thread to finish...
	set WAIT_SHOW=1
)
REM Pause for X sec
ping 127.0.0.1 -n %1 > nul
goto :eof
