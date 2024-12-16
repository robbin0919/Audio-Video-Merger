@ECHO OFF
setlocal enabledelayedexpansion

title Audio and Video Merger by @robbin019

set "input_folder=.\input"
set "temp_folder=temp"
set "output_folder=output"
rmdir %temp_folder% /s /q >nul 2>nul
echo.
echo [INFO] Welcome to use the batch script to merge mp4 and m4a files
echo [INFO] Author: @robbin019
echo [INFO] Script version: 0.1
echo.
if not exist ffmpeg.exe (
    set extracted_text=Not Available
) else (
    for /f "delims=" %%i in ('ffmpeg -version 2^>^&1') do (
        set "ffmpeg_version=%%i"
        goto :done
       )
    :done
    for /f "tokens=2,3" %%a in ("!ffmpeg_version!") do (
        set "extracted_text=%%a %%b"
      )
       )
echo !extracted_text!
