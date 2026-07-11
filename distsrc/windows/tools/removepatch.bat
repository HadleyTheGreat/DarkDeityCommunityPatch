@echo off
setlocal enabledelayedexpansion

:: Get the directory where the script is located
set "BASE_DIR=%~dp0"

if exist "%BASE_DIR%data.win" (
    if exist "%BASE_DIR%data.win.old" (
        echo --- Removing data.win ---
        del "%BASE_DIR%data.win"
        echo --- Renaming data.win.old to data.win ---
        ren "%BASE_DIR%data.win.old" "data.win"
    ) else (
        echo There is no data.win.old file.
        echo The patch appears to have been uinstalled already.
    )
    echo --- Cleaning up the removal script ---
    del "%~f0"
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

