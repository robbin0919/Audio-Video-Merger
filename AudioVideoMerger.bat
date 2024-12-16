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
