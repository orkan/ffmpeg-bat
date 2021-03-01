@echo off
setlocal
call _header.bat "%~nx0"

echo ***************************************************
echo   Video to MP4
echo   Usage: %~nx0 infile [quality 0(hi)-51(low): %DEFAULT_H264_CRF%] [fps: original] [extra: %DEFAULT_H264_EXT%] [outfile]
echo ***************************************************

REM Config: --------------------------------------------
set INFILE=%~1
set CRF=%~2
set FPS=%~3
set EXT=%~4
set OUTFILE=%~5

echo Inputs:
echo INFILE  : [%INFILE%]
echo CRF     : [%CRF%]
echo FPS     : [%FPS%]
echo EXT     : [%EXT%]
echo OUTFILE : [%OUTFILE%]

set CRF=-crf %CRF%
set FPS=-r %FPS%

if "%CRF%" == "-crf " set CRF=-crf %DEFAULT_H264_CRF%
if "%FPS%" == "-r "   set FPS=
if "%EXT%" == ""      set EXT=%DEFAULT_H264_EXT%

REM Extra options: -------------------------------------
set EXT_STR=%EXT%
set EXT_STR=%EXT_STR::=%
set EXT_STR=%EXT_STR:?=%

if "%OUTFILE%" == "" (
	set "OUTFILE=%~dpn1.[%CRF%][%FPS%][%EXT_STR%].mp4"
)

REM META tags: -----------------------------------------
for /f "tokens=*" %%x in ( 'call _location.bat "%INFILE%"' ) do set LOCATION=%%x
if "%LOCATION%" NEQ "" set META_LOCATION=gps:[%LOCATION%]
set METAS=%META_GLOBAL% -metadata description="%META_LOCATION%" -metadata comment="%~nx0 [%CRF%] [%FPS%] [%EXT%] %META_USER_COMMENT%"

REM Command: -------------------------------------------
call ffmpeg -y -i "%INFILE%" -c:v libx264 %DEFAULT_H264% %CRF% %FPS% %EXT% %METAS% "%OUTFILE%"

exit /b %ERRORLEVEL%
