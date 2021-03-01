![ffmpeg-logo](https://user-images.githubusercontent.com/129182/109426425-fdf78800-79ed-11eb-934b-6aac6bc56d18.jpg)

# ffmpeg (W)indows (C)ontext (T)ools
Edit your media files quickly with: Right click > "Send to" menu.
---
The main idea behind this project is to limit the command line switches that need to be passed to ffmpeg.exe while keeping full control of the convertion process.

## Installation

### General:
Set environment variable `FFMPEG_HOME` pointing to ffmpeg installation dir or set it locally by creating autoloaded `usr\config.bat` file with:
```batch
@echo off
set FFMPEG_HOME=path\to\ffmpeg-dir
```

### Send To:
1. Create shortcuts to any of `bat\tool_***.bat` in `%USERPROFILE%\AppData\Roaming\Microsoft\Windows\SendTo`
1. Rename shortcuts as needed, eg. "*Shortcut to tool_video_cut_time.bat*" > "_Clip movie_"
1. Right click on your media file, choose: Send To > Clip movie

### Batch proccessing:
To convert many media files at once, run: `bat\[START].bat usr\files.bat`

Create `usr\files.bat` as follows: 
```batch
@echo off

REM Convert all *.ts to *.mp4 in X:\media\videos
echo ffmpeg_mp4.bat "X:\media\videos\*.ts" 28 24.97

REM Convert all *.avi to *.mp3 in D:\clips
echo ffmpeg_mp3.bat "D:\clips\*.avi" 128k 44100
```
Note: all paths must be wilcards. Use * or ? as needed

## Configuration
All ffmpeg configuration is stored in `bat\_config.bat` file. You can create your own by copying this file to `usr\config.bat` and edit it there. Your changes will be automatically loaded and will overwrite any corresponding values from `_config.bat`

## About
### Requirements
* [ffmpeg](https://ffmpeg.org/)

### Author
Orkan <Orkans@gmail.com> - https://github.com/orkan

### License
GNU General Public License v3.0
