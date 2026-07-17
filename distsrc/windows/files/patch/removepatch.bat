@echo off
setlocal enabledelayedexpansion

:: Get the directory where the script is located
set "BASE_DIR=%~dp0"

if exist "%BASE_DIR%data.win" (
    if exist "%BASE_DIR%patch\backup\data.win" (
        echo --- Removing data.win ---
        del "%BASE_DIR%data.win"
        echo --- Renaming data.win.old to data.win ---
        move "%BASE_DIR%\patch\backup\data.win" "data.win"
    )

    echo --- Resstoring previous version files from backup ---
    xcopy /e /y "%BASE_DIR%\patch\backup" "%BASE_DIR%"
    
    echo --- Deleting new files created by the patch ---
    if exist "%BASE_DIR%patch\addedfiles.txt" (    
        for /f "delims=" %%a in ("%BASE_DIR%patch\addedfiles.txt") do (
            if exist "%%a" (
                del /q "%%a"
                echo Deleted: %%a
            ) else (
                echo Not found: %%a
            )
        )
    )
    
    rmdir /s /q "%BASE_DIR\patch"
            
    :: ANSI escape sequences for green text work natively in Windows 10/11 CMD
    echo [32mPatch has been successfully removed.[0m
    pause
    exit
)

echo This batch file is an uninstaller for the Dark Deity community patch.
echo It is meant to be copied into the Dark Deity folder automatically
echo when installing the patch with the patchtool, then run from inside
echo that folder to uninstall.  Its not intended to run from here.
pause

