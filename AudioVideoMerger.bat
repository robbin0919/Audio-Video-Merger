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
del log.log >nul 2>nul
del error.log >nul 2>nul
set num=0
set snum=0
mkdir %temp_folder% >nul 2>nul
mkdir %output_folder% >nul 2>nul

for %%i in ("%input_folder%\*.mp4") do (
    set "file_name=%%~ni"
    set /a "num+=1"
    
    if exist "%input_folder%\!file_name!.m4a" (
         if not exist "%output_folder%\!file_name!.mp4" (
              for %%a in ("%%i") do (
                set "mp4_size=%%~za"
            )
            for %%b in ("%input_folder%\!file_name!.m4a") do (
                set "m4a_size=%%~zb"
            )

            set /a "total_size=!mp4_size!+!m4a_size!"

            title Processing: !file_name! Size: !total_size! bytes ^| Audio and Video Merger
            echo.
            echo [INFO] Processing: !file_name! Size: !total_size! bytes
            echo [INFO] Processing: !file_name! Size: !total_size! bytes >> log.log
            ffmpeg -i "%%i" -i "%input_folder%\!file_name!.m4a" -c:v copy -c:a aac -strict experimental "%output_folder%\Merger_!file_name!.mp4" >nul 2>nul
            
            for %%o in ("%output_folder%\!file_name!.mp4") do (
                set "output_size=%%~zo"
            )
            echo [INFO] !file_name! merge completed
            echo [INFO] Output filename: Merger_!file_name!.mp4, Size: !total_size!^-^>!output_size! bytes
            echo [INFO] MP4 Size: !mp4_size! bytes, M4A Size: !m4a_size! bytes, Output filename: Merger_!file_name!.mp4, Size: !total_size!^-^>!output_size! bytes 
            echo [INFO] MP4 Size: !mp4_size! bytes, M4A Size: !m4a_size! bytes, Output filename: Merger_!file_name!.mp4, Size: !total_size!^-^>!output_size! bytes >> log.log
            echo.
            
            set /a "snum+=1"
        ) else (
            echo [ERROR] The file !file_name!.mp4 already exists in output folder, please check the file name
            echo [ERROR] The file !file_name!.mp4 already exists in output folder, please check the file name >> error.log

         )
           ) else (
        echo [ERROR] No m4a file matching %%i was found, please check the file name
        echo [ERROR] No m4a file matching %%i was found, please check the file name >> error.log
    )
)

title Task completed ^| Audio and Video Merger 
echo.
echo [INFO] All files have been processed, total: !num! files, Succeeded: !snum! files
powershell -Command "& { [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null; $template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02); $xml = New-Object Windows.Data.Xml.Dom.XmlDocument; $xml.LoadXml($template.GetXml()); $toastElements = $xml.GetElementsByTagName('text'); if ($toastElements.Count -ge 2) { $titleNode = $xml.CreateTextNode('All files have been processed'); $toastElements.Item(0).AppendChild($titleNode) > $null; $contentNode = $xml.CreateTextNode('Total: !num! files, Succeeded: !snum! files'); $toastElements.Item(1).AppendChild($contentNode) > $null; $toast = [Windows.UI.Notifications.ToastNotification]::new($xml); $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Audio and Video Merger by @RobbinLee'); $notifier.Show($toast); } else { Write-Host 'Unable to create toast notification.' } }"  >nul 2>nul
echo [INFO] press any key to exit
pause >nul

endlocal

 