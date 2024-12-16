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

echo [INFO] Dependence ffmpeg %extracted_text%
echo [INFO] You can download or update ffmpeg version from ffmpeg.org/download.html
echo [INFO] You also can just delete ffmpeg.exe and run this script again to try to download latest version
echo.
echo [NOTICE] Data no price, caution proceed
echo.
echo [*] Press any key to continue
echo.
pause >nul

if not exist ffmpeg.exe (
    echo [INFO] Dependence ffmpeg.exe not found
    echo  start download
    echo.
    pause >nul
    mkdir !temp_folder! >nul 2>nul
    title Downloading ffmpeg.exe ^| Audio and Video Merger  
    echo [INFO] Downloading ffmpeg.exe
    curl -L https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip -o !temp_folder!\ffmpeg.zip
    echo [INFO] Finished downloading ffmpeg.exe
    if exist !temp_folder!\ffmpeg.zip (
        title Extracting ffmpeg.exe ^| Audio and Video Merger 
        echo [INFO] Extracting ffmpeg.exe
    ) else (
        echo [ERROR] Download failed, please check your network connection
        echo [ERROR] Download failed, please check your network connection >> error.log
        exit
    )
    mkdir !temp_folder!\unzip >nul 2>nul
    tar -xf !temp_folder!\ffmpeg.zip -C !temp_folder!\unzip >nul 2>nul
    for /d %%i in (!temp_folder!\unzip\*) do set SUB_FOLDER=%%i
    if exist "!SUB_FOLDER!\bin\ffmpeg.exe" (
        move "!SUB_FOLDER!\bin\ffmpeg.exe" ".\ffmpeg.exe" >nul 2>nul
    ) else (
        echo [ERROR] ffmpeg.exe not found.
        echo [ERROR] ffmpeg.exe not found. >> error.log
        exit
    )
    rmdir !temp_folder! /s /q >nul 2>nul
    for /f "delims=" %%i in ('ffmpeg -version 2^>^&1') do (
        set "ffmpeg_version=%%i"
        goto :ddone
    )
    :ddone
    for /f "tokens=2,3" %%a in ("!ffmpeg_version!") do (
        set "extracted_text=%%a %%b"
    )
    echo [INFO] ffmpeg.exe extracted successfully
    echo [INFO] ffmpeg.exe extracted successfully >> log.log
    echo [INFO] Dependence ffmpeg %extracted_text%
    echo [INFO] Dependence ffmpeg %extracted_text% >> log.log
    echo.
)
