@echo off
REM This is the default file for bat\[START].bat - don't change it!
REM You can create your own and call [START].bat "my\paths.bat"
REM Use absolute paths b/c all paths here are relative to /bat dir
REM IMPORTANT: All paths must be wilcards! Use * and/or ?

REM Convert to mp4
echo ffmpeg_mp4.bat "%~dp0..\tests\videos\ac3\*.ts" 28
echo ffmpeg_mp4.bat "%~dp0..\tests\videos\dir-3\video-xyz.mo?" 25 24.99 "-map v:0 -map a:0 -map a:1? -c:a copy"

REM Convert to mp3
echo ffmpeg_mp3.bat "%~dp0..\tests\videos\dir-1\*.mp4"
