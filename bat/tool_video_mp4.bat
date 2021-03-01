@echo off
setlocal EnableDelayedExpansion
call _header.bat "%~nx0"

echo ***************************************************
echo   Tool: Video to MP4
echo ***************************************************

REM Input: ---------------------------------------------
call _inputfile.bat %1 || goto :end

REM User: ----------------------------------------------
echo.
set /p CRF=CRF value [quality 0(hi)-51(low): 23]: 
set /p FPS=FPS [keep]: 
echo Extra options:
echo - video size: -s hd720 (1280x720), -s pal (720x576)
echo - audio AC3 to AAC: -map v:0 -map a:0 -c:a aac -ac 2 -ar 44100 -ab 192k -c:v copy
set /p EXTRA=EXTRA [-c:a copy]: 

REM Command: -------------------------------------------
echo.
call ffmpeg_mp4.bat "%~1" "!CRF!" "!FPS!" "!EXTRA!" || goto :end

REM Finalize: ------------------------------------------
:end
call _status.bat