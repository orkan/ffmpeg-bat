@echo off
call _config.bat

if "%FFMPEG_DEBUG%" NEQ "" set INFO_DEBUG=Debug mode: ON
if "%FFMPEG_ERROR%" NEQ "" set INFO_DEBUG=%INFO_DEBUG%, ERRORLEVEL: %FFMPEG_ERROR%
if "%INFO_DEBUG%"   NEQ "" set INFO_DEBUG=(%INFO_DEBUG%)

if "%FFMPEG_DEBUG%" == "" exit /b

echo.
echo [%~1] %INFO_DEBUG%
