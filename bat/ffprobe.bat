@echo off
setlocal
call _config.bat

set FFPROBE_EXE=%~n0.exe

if not exist "%FFMPEG_HOME%" (
	set FFMPEG_HOME=%FFMPEG_HOME_DEF%
)

set EXE_LOC=%FFMPEG_HOME_DEF%\%FFPROBE_EXE%

REM Get fully qualified path name
REM https://stackoverflow.com/questions/1645843/resolve-absolute-path-from-relative-path-and-or-file-name
pushd %FFMPEG_HOME%
set EXE_ABS=%CD%\%FFPROBE_EXE%
popd

set COMMAND=%EXE_ABS% %*

REM No echo please!!!
if "%FFMPEG_DEBUG%" == "" (
	%COMMAND%
)

if "%FFMPEG_DEBUG_ERROR%" NEQ "" (
	set ERRORLEVEL=%FFMPEG_DEBUG_ERROR%
)

exit /b %ERRORLEVEL%
