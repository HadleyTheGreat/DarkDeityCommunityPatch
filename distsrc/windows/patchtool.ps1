<#
.SYNOPSIS
    Dark Deity Community Patch installation and removal tool for Windows.
#>

# Enforce strict error handling (equivalent to set -euo pipefail)
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

# Script global variables
$SCRIPT_NAME = $MyInvocation.MyCommand.Name
$VERSION = "3.0.0"
$VERBOSE_OUTPUT = $false
$APPID = "1374840"
$GAME_DIR = ""
$BACKUP_DIR = ""
$ACTION = ""
$OVERRIDE = $false
$PROMPT = $false

# Get the directory where the script is located
$BASE_DIR = $PSScriptRoot
$SCRIPTS_DIR = Join-Path $BASE_DIR "scripts"

# Default install locations for Steam on Windows (Registry + fallback)
$STEAM_ROOTS = @()
if (Test-Path "HKCU:\Software\Valve\Steam") {
    $RegPath = (Get-ItemProperty -Path "HKCU:\Software\Valve\Steam" -ErrorAction SilentlyContinue).SteamPath
    if ($RegPath) { $STEAM_ROOTS += $RegPath }
}
$STEAM_ROOTS += "C:\Program Files (x86)\Steam"
$STEAM_ROOTS += "C:\Program Files\Steam"

# Global hash placeholders
$prePatchHash = ""
$postPatchHash = ""

function Show-Usage {
    @"
Dark Deity Community Patch installation and removal tool for Windows

This patch is for Dark Deity version 1.58 on x86-based Windows or Linux platforms.

Usage: 
  .\$SCRIPT_NAME COMMAND [flags] [directory]
COMMAND can be one of
  -h, -?, --help  Show this help    
  -i, --install   Install the patch
  -u, --uninstall Uninstall the patch
  -a, --auto      Install the patch or prompt the user to remove it
  -c, --hash      Calculate the hash of data.win and data.win.old if it exists
Optional flags can be
  -o, --override  Ignore version mismatch and attempt to patch anyway
  -p, --prompt    Show a GUI prompt to select the Dark Deity directory.    
If directory is omitted, the Steam version of the game will be located automatically
For non-Steam versions, use the -p flag or specify the directory on the command-line. 

Examples:
  .\$SCRIPT_NAME -i
  .\$SCRIPT_NAME -i -p
  .\$SCRIPT_NAME -i "C:\Program Files\Epic Games\Dark Deity"
  .\$SCRIPT_NAME -u "C:\Program Files (x86)\GOG Galaxy\Games\Dark Deity Complete Edition"
  .\$SCRIPT_NAME --hash "D:\SteamLibrary\steamapps\common\Dark Deity"
"@
}

function Find-LibraryFoldersVdf {
    foreach ($root in $STEAM_ROOTS) {
        $vdfPath = Join-Path $root "steamapps" | Join-Path -ChildPath "libraryfolders.vdf"
        if (Test-Path -Path $vdfPath -PathType Leaf) {
            return $vdfPath
        }
    }
    return $null
}

function Get-LibraryPaths {
    param([string]$vdf)
    
    # Extract "path" lines and clean up the string values
    Select-String -Path $vdf -Pattern '^[ \t]*"path"' | ForEach-Object {
        if ($_.Line -match '"path"[ \t]*"([^"]+)"') {
            $Matches[1] -replace '\\\\', '\'
        }
    }
}

function Find-GameDir {
    param([string]$appid)

    $vdf = Find-LibraryFoldersVdf
    if (-not $vdf) {
        return $null
    }

    $libraries = Get-LibraryPaths -vdf $vdf
    foreach ($library in $libraries) {
        $steamapps = Join-Path $library "steamapps"
        $manifest = Join-Path $steamapps "appmanifest_$($appid).acf"

        if (Test-Path -Path $manifest -PathType Leaf) {
            $installDirLine = Select-String -Path $manifest -Pattern '"installdir"' | Select-Object -First 1
            if ($installDirLine -and ($installDirLine.Line -match '"installdir"[ \t]*"([^"]+)"')) {
                return Join-Path $steamapps "common" | Join-Path -ChildPath "$($Matches[1])"
            }
        }
    }
    return $null
}

function Install-FilesWithBackup {
    $SourcePath = Join-Path $BASE_DIR files
    $TargetDir = $GAME_DIR
    $BackupDir = Join-Path $GAME_DIR "PatchBackup"

    # Resolve paths to absolute paths so the script is highly reliable
    #$SourcePath = Resolve-Path -Path $SourceDir -ErrorAction SilentlyContinue
    #if (-not $SourcePath) {
    #    Write-Error "Source directory '$SourceDir' does not exist."
    #    return
    #}

    # Create Backup directory if it doesn't exist
    if (-not (Test-Path -Path $BackupDir)) {
        New-Item -ItemType Directory -Path $BackupDir -Force | Out-Null
    }

    # Get all files from the source directory
    $files = Get-ChildItem -Path $SourcePath -File

    if (-not $files) {
        Write-Host "No files found in source directory." -ForegroundColor Yellow
        return
    }

    $addedFiles = Join-Path $BackupDir "addedfiles.txt"
    Write-Host "ADDED_FILES = $addedFiles"
    foreach ($file in $files) {
        $destinationPath = Join-Path -Path $TargetDir -ChildPath $file.Name
        $backupPath = Join-Path -Path $BackupDir -ChildPath $file.Name

        if (Test-Path -Path $destinationPath) {
            # Is there already an earlier backup version of this file?
            if (-not (Test-Path -Path $backupPath)) {
                # No earlier backup, so store this file as a backup
                Move-Item -Path $destinationPath -Destination $backupPath
            }
        } else {
            # Keep a list of files that have been added that didn't overwrite an existing file
            # This will be used to delete them later on an uninstall
            Add-Content -Path $addedFiles -Value $file.Name
        }

        # Step 2: Copy the source file to the target directory
        Write-Host "Installing file '$($file.Name)'" -ForegroundColor Green
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force
    }
}

function Uninstall-FilesFromBackup {
    param (
        [Parameter(Mandatory = $false)]
        [string]$BackupDir,

        [Parameter(Mandatory = $false)]
        [string]$TargetDir,

        [Parameter(Mandatory = $false)]
        [string]$FileListPath
    )

    if (-not $GAME_DIR) {
        Write-Error "Game directory was unset"
        exit 1
    }

    $BackupDir = Join-Path $GAME_DIR "PatchBackup"
    $TargetDir = $GAME_DIR
    $FileListPath = Join-Path $BackupDir "addedfiles.txt"

    # --- Part 1: Copy files from Backups to Target ---
    if (Test-Path -Path $BackupDir -PathType Container) {
        Write-Verbose "Copying contents from '$BackupDir' to '$TargetDir'..."
        $files2 = Get-ChildItem -Path $BackupDir -File | Where-Object Name -NotIn "addedfiles.txt"
        $files2 | Get-ChildItem | Write-Host -ForegroundColor Cyan
        $files2 |
            Move-Item -Destination $TargetDir -Force
        Write-Verbose "Copy operation completed."
    } else {
        Write-Warning "Backups directory '$BackupDir' does not exist. Skipping copy."
    }

    # --- Part 2: Read 'addedfiles.txt' and Delete specified files ---
    if (Test-Path $FileListPath) {
        Write-Verbose "Reading file deletion list from '$FileListPath'..."
            
        # Read lines, filtering out empty lines or spaces
        $filesToDelete = Get-Content -Path $FileListPath | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }

        foreach ($file in $filesToDelete) {
            # Make path relative to target directory if it is not already an absolute path
            if (-not [System.IO.Path]::IsPathRooted($file)) {
                $file = Join-Path $TargetDir $file
            }

            if (Test-Path $file) {
                Remove-Item -Path $file -Force
                Write-Verbose "Deleted: $file"
            } else {
                Write-Verbose "Skipped (File not found): $file"
            }
        }
    } else {
        Write-Warning "File list '$FileListPath' not found. Skipping deletions."
    }

    if (Test-Path -Path $BackupDir -PathType Container) {
        Remove-Item -Path "$BackupDir" -Recurse -Force
    }
}

function Do-Uninstall {
    $oldFile = Join-Path $GAME_DIR "data.win.old"
    $currentFile = Join-Path $GAME_DIR "data.win"
    $removeScript = Join-Path $GAME_DIR "removepatch.bat" # Changed extension for Windows

    if (Test-Path -Path $oldFile -PathType Leaf) {
        Write-Output "--- Uninstalling existing patch ---"
        if (Test-Path -Path $currentFile) { Remove-Item -Path $currentFile -Force }
        Move-Item -Path $oldFile -Destination $currentFile -Force
    }

    Uninstall-FilesFromBackup
}

function Do-Install {
    $currentFile = Join-Path $GAME_DIR "data.win"
    $patchedFile = Join-Path $GAME_DIR "patched.win"
    $oldFile = Join-Path $GAME_DIR "data.win.old"
    $removePatch = Join-Path $GAME_DIR "removepatch.bat"
    
    Write-Output "--- Building patched.win ---"
    if (Test-Path -Path $patchedFile) { Remove-Item -Path $patchedFile -Force }
    
    $cliExe = Join-Path $BASE_DIR "utmt_cli" | Join-Path -ChildPath "UndertaleModCli.exe"
    $script1 = Join-Path $BASE_DIR "scripts" | Join-Path -ChildPath "nongmlmods.csx"
    $script2 = Join-Path $BASE_DIR "tools" | Join-Path -ChildPath "scriptupdater.csx"
    
    # Execute UndertaleModCli
    & $cliExe load "$currentFile" -s "$script1" -s "$script2" -o "$patchedFile"
    
    Write-Output "--- Renaming data.win to data.win.old to save as a backup ---"
    if (Test-Path -Path $oldFile) { Remove-Item -Path $oldFile -Force }
    Move-Item -Path $currentFile -Destination $oldFile -Force
    
    Write-Output "--- Renaming patched.win to data.win ---"
    Move-Item -Path $patchedFile -Destination $currentFile -Force
    
    Write-Output "--- Installing other files ---"
    # Make sure removepatch.bat isn't left over from a previous install
    if (Test-Path -Path $removePatch -PathType Leaf) {
        Remove-Item $removePatch
    }
    Install-FilesWithBackup
}

function Do-Version {
    Write-Output $VERSION
}

function Do-Hash {
    $currentFile = Join-Path $GAME_DIR "data.win"
    $oldFile = Join-Path $GAME_DIR "data.win.old"

    if (-not (Test-Path -Path $currentFile -PathType Leaf)) {
        Write-Error "Error: Couldn't find file `"$currentFile`""
        exit 1
    }
    
    $currentHash = Get-Sha256Hash $currentFile
    Write-Output "data.win: $currentHash"
    
    if (Test-Path -Path $oldFile -PathType Leaf) {        
        $backupHash = Get-Sha256Hash $oldFile
        Write-Output "data.win.old: $backupHash"
    }
}

function PromptFor-GameDir {
    Add-Type -AssemblyName System.Windows.Forms

    $fileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        InitialDirectory = [Environment]::GetFolderPath('Desktop')
        Filter         = 'Exe Files (*.exe)|*.exe|All Files (*.*)|*.*'
        Title          = 'Please locate the Dark Deity executable'
    }

    # Display the dialog and suppress the return value
    $result = $fileBrowser.ShowDialog()
    if (($result -eq [System.Windows.Forms.DialogResult]::OK) -and ($fileBrowser.FileName -ne "")) { 
        # Retrieve the selected file path
        $filePath = $FileBrowser.FileName
        if ([string]::IsNullOrEmpty($filePath)) { 
            return $null 
        }
        $dirPath = Split-Path -Path $filePath
        return $dirPath
    } 

    return $null
}

function Resolve-GameDir {
    if ($script:PROMPT) {
        $script:GAME_DIR = PromptFor-GameDir
        if ([string]::IsNullOrEmpty($script:GAME_DIR)) {
            Write-Host "Prompt for game directory was cancelled.  Operation aborted." -ForegroundColor Yellow
            exit 1
        }
    } elseif ([string]::IsNullOrEmpty($script:GAME_DIR)) {
        $script:GAME_DIR = Find-GameDir $APPID
        if (-not $script:GAME_DIR) {
            Write-Host "Error: Failed to automatically locate the Dark Deity install folder." -ForegroundColor Red
            Write-Host "Please specify the install folder on the command-line.`nExamples:`n    .\$SCRIPT_NAME -i `"C:\Program Files (x86)\GOG Galaxy\Games\Dark Deity Complete Edition`"`n    .\$SCRIPT_NAME -i `"C:\Program Files\Epic Games\Dark Deity`""
            exit 1
        }    
    }
    
    $currentFile = Join-Path $script:GAME_DIR "data.win"
    if (-not (Test-Path -Path $currentFile -PathType Leaf)) {
        Write-Error "Error: file not found `"$currentFile`""
        exit 1
    }
    
    Write-Output "GAME_DIR = $script:GAME_DIR"
}

function Validate-PostHash {
    if ([string]::IsNullOrEmpty($postPatchHash) -or $OVERRIDE) {
	    return
    }
        
    $currentFile = Join-Path $GAME_DIR "data.win"
    $currentHash = Get-Sha256Hash $currentFile
    if ($currentHash -eq $postPatchHash) {
        Write-Output "Post-patch hash validation passed."
        return
    } else {    
        Write-Output "Expected hash: $postPatchHash"
        Write-Output "Actual hash: $currentHash"
        Write-Host "Post-patch hash validation failed." -ForegroundColor Red
        exit 1
    }
}

function Get-InstallState {
    if (-not (Test-Path -Path "$SCRIPTS_DIR" -PathType Container)) {
        Write-Error "Error: Scripts directory missing at`"$SCRIPTS_DIR`""
        exit 1
    }

    $hash_file = Join-Path $SCRIPTS_DIR "versions.csv"
    if (-not (Test-Path -Path "$hash_file" -PathType Leaf)) {
        Write-Error "Error: Versions file is missing at `"$hash_file`""
        exit 1
    }

    $inputFile = Join-Path $GAME_DIR "data.win"
    $currentHash = Get-Sha256Hash $inputFile
    $match = Import-Csv -Path $hash_file | Where-Object { $_.AfterHash -eq $currentHash } | 
                Select-Object -First 1
    if ($null -ne $match) {
        # Return 1: Already Installed
        return 1
    }

    $match = Import-Csv -Path $hash_file | Where-Object { $_.BeforeHash -eq $currentHash } | 
                Select-Object -First 1
    if ($null -ne $match) {
        $script:postPatchHash = $match.AfterHash
        # The patch is not installed, but data.win is the right version to install on
        # Return 2: Do-Install OK
        return 2
    } else {
        # if the hash of data.win didn't match, see if there's a backup in data.win.old
        $inputFile = Join-Path $GAME_DIR "data.win.old"
        if (Test-Path -Path "$inputFile") {
            # data.win.old exists so check its hash
            $currentHash = Get-Sha256Hash $inputFile
            $match = Import-Csv -Path "$hash_file" | Where-Object { $_.BeforeHash -eq $currentHash } |
                        Select-Object -First 1
            if ($null -ne $match) {
                # The patch is not installed, but data.win.old is the right version to install on
                # Return 3: Do-Install OK only after Do-Uninstall
                $script:postPatchHash = $match.AfterHash
                return 3
            }
        }
    }

    # Neither data.win or data.win.old has the right pre-patch hash
    # Return 0: Dark Deity version mismatch 
    return 0
}

function Validate-GameVersion {
    # This function will only return if $GAME_DIR\data.win is a patchable version
    # If the current version is already patched, it'll let the user know and exit the application.
    # if the current version cannot be patched, it'll signal an error and exit the application
    if (-not (Test-Path -Path "$SCRIPTS_DIR" -PathType Container)) {
        Write-Error "Error: Scripts directory missing at`"$SCRIPTS_DIR`""
        exit 1
    }
    
    $hash_file = Join-Path $SCRIPTS_DIR "versions.csv"
    if (-not (Test-Path -Path "$hash_file" -PathType Leaf)) {
        Write-Error "Error: Versions file is missing at `"$hash_file`""
        exit 1
    }  
    
    $inputFile = Join-Path $GAME_DIR "data.win"
    $currentHash = Get-Sha256Hash $inputFile
    $match = Import-Csv -Path $hash_file | Where-Object { $_.AfterHash -eq $currentHash } | 
                Select-Object -First 1
    if ($null -ne $match) {
        Write-Host "Patch is already installed. Nothing to do." -ForegroundColor Yellow
        exit 0
    }

    $match = Import-Csv -Path $hash_file | Where-Object { $_.BeforeHash -eq $currentHash } | 
                Select-Object -First 1
    if ($null -ne $match) {
        # if it found a hash matching one in the versions list then data.win can be patched
        # Return value of 1 indicates data.win can be patched
        $script:postPatchHash = $match.AfterHash
        return
    } else {
        # if the hash of data.win didn't match, see if there's a backup in data.win.old
        $inputFile = Join-Path $GAME_DIR "data.win.old"
        if (Test-Path -Path "$inputFile") {
            # data.win.old exists so check its hash
            $currentHash = Get-Sha256Hash $inputFile
            $match = Import-Csv -Path "$hash_file" | Where-Object { $_.BeforeHash -eq $currentHash } |
                        Select-Object -First 1
            if ($null -ne $match) {
                # if the hash matched, then the validation has passed so we won't exit with an error
                # Return value of 0 indicates data.win.old can be patched
                # On a return value of 0, Do-Uninstall needs to be called to remove the previous Patch
                # before Do-Install is called
                $script:postPatchHash = $match.AfterHash
                Do-Uninstall
                return
            }
        }
    }

    if ($OVERRIDE -ne $true) {
        Write-Error @"
Error: Dark Deity version mismatch.
This patch is only intended for version 1.58 of Dark Deity.
You can use the --override command-line switch to override and install anyway.
"@  
        exit 1
    }
}

function Get-Sha256Hash {
    param([string]$path)
    # Returns lowercase hex string to mimic sha256sum behavior
    (Get-FileHash -Path $path -Algorithm SHA256).Hash.ToLower()
}

function Set-Action {
    param([string]$actionName)
    if (-not [string]::IsNullOrEmpty($script:ACTION)) { 
        Write-Error "Error: More than one command specified in arguments."
        exit 1
    }
    $script:ACTION = $actionName
}
        
function PromptFor-Uninstall {
    Write-Host "This patch is already installed." -ForegroundColor Yellow

    $title = ""
    $message = "Do you want to uninstall the patch?"

    # Define the choices. The ampersand (&) marks the shortcut key.
    $choices = @(
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Uninstall the patch")
        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel the operation.")
    )
    # default choice: 0 = yes, 1 = no
    $default = 1

    $choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)
    if ($choice -eq 0) {
        Write-Host "Restoring the original DATA.WIN from the backup file"
        Do-Uninstall
        Write-Host "The patch was successfully uninstalled." -ForegroundColor Green
    } else {
        Write-Host "You chose No. No changes have been made." -ForegroundColor Yellow
    }
    exit 0
}

function PromptFor-Reinstall {
    Write-Host "Another version of the community patch is currently installed." -ForegroundColor Yellow
    $title = ""
    $message = "Do you want to replace it with this version?"

    # Define the choices. The ampersand (&) marks the shortcut key.
    $choices = @(
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Install the patch")
        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel the operation.")
    )
    # default choice: 0 = yes, 1 = no
    $default = 1

    $choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)
    if ($choice -eq 0) {
        Do-Uninstall
        Do-Install
        Validate-PostHash
        Write-Host "The patch installation was successful." -ForegroundColor Green
    } else {
        Write-Host "You chose No. No changes have been made." -ForegroundColor Yellow
    }
    exit 0
}

function PromptFor-Install {
    Write-Host "The patch is not installed, but can be installed to this version of Dark Deity." -ForegroundColor Yellow

    $title = ""
    $message = "Do you want to install the patch?"

    # Define the choices. The ampersand (&) marks the shortcut key.
    $choices = @(
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Install the patch")
        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel the operation.")
    )
    # default choice: 0 = yes, 1 = no
    $default = 1

    $choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)
    if ($choice -eq 0) {
        Do-Install
        Validate-PostHash
        Write-Host "The patch installation was successful." -ForegroundColor Green
    } else {
        Write-Host "You chose No. No changes have been made." -ForegroundColor Yellow
    }
    exit 0
}

function PromptFor-OverrideInstall {    
    Write-Host "The patch is not installed, but it was not intended for this version of Dark Deity." -ForegroundColor Yellow
    $title = ""
    $message = "Do you want to override and install the patch anyway?"

    # Define the choices. The ampersand (&) marks the shortcut key.
    $choices = @(
        [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Install the patch")
        [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel the operation.")
    )
    # default choice: 0 = yes, 1 = no
    $default = 1

    $choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)
    if ($choice -eq 0) {
        Do-Install
        Write-Host "The patch installation was successful." -ForegroundColor Green
    } else {
        Write-Host "You chose No. No changes have been made." -ForegroundColor Yellow
    }
    exit 0
}


function Main-Process {
    switch ($ACTION) {
        "auto" {
            Resolve-GameDir
            $state = Get-InstallState
            switch ($state)
            {
                # State 0: The game patch is not the right version, but the user can override install.
                0 { PromptFor-OverrideInstall }                        
                # State 1: The game patch is installed already.
                1 { PromptFor-Uninstall }
                # State 2: The game patch can be installed now.
                2 { PromptFor-Install }
                # State 3: The game patch can only be installed after the previous is uninstalled.
                3 { PromptFor-Reinstall }
            }
            exit 0
        }
        "install" {
            Resolve-GameDir
            $state = Get-InstallState
            if ($state -eq 1) {
                Write-Host "The patch is already installed.  Nothing to do." -ForegroundColor Yellow
                exit 0
            }
            if (($state -eq 0) -and ($OVERRIDE -eq $false)) {
                Write-Host "Dark Deity version mismatch.  Operation aborted." -ForegroundColor Red
                exit 1
            }
            if ($state -eq 3) {
                Do-Uninstall
            }
            Do-Install
            Validate-PostHash
            Write-Host "The patch installation was successful." -ForegroundColor Green
            exit 0
        }
        "uninstall" {
            Resolve-GameDir
            $oldFile = Join-Path $GAME_DIR "data.win.old"
            if (-not (Test-Path -Path $oldFile -PathType Leaf)) {
                Write-Output "Backup file `"data.win.old`" does not exist."
                Write-Host "The patch is not installed.  Nothing to do." -ForegroundColor Yellow
                exit 1
            }
            Do-Uninstall
            Write-Host "The patch was successfully uninstalled." -ForegroundColor Green
            exit 0
        }
        "test" {
            Resolve-GameDir
            $state = Get-InstallState
            switch ($state) {
                0 {
                    Write-Host "The patch is not installed and this is not the correct version to intall on."
                    exit 0
                }
                3 {
                    Write-Host "The patch is not installed, but can be installed after the old version is uninstalled."
                    exit 0
                }
                2 {
                    Write-Host "The patch is not installed, but this is the correct version to install on."
                    exit 0
                }
                1 {
                    Write-Host "The patch is already installed."
                    exit 0
                }
            }
            exit 0
        }
        "help" {
            Show-Usage
        }
        "hash" {
            Resolve-GameDir
            Do-Hash
        }
        "version" {
            Do-Version
        }
        Default {
            Write-Error "Internal error: No handler for command `"$ACTION`""
            exit 1
        }
    }
}

function Parse-Params {
    param([string[]]$argsList)
    
    $i = 0
    while ($i -lt $argsList.Count) {
        $arg = $argsList[$i]
        switch -Regex ($arg) {
            '^(-h|-\?|--help)$' {
                Set-Action "help"
                break
            }
            '^(-a|--auto)$' {
                Set-Action "auto"
                break
            }

            '^(-i|--install)$' {
                Set-Action "install"
                break
            }
            '^(-u|--uninstall)$' {
                Set-Action "uninstall"
                break
            }
            '^(-c|--hash)$' {
                Set-Action "hash"
                break
            }
            '^--version$' {
                Set-Action "version"
                break
            }
            '^(-t|--test)$' {
                Set-Action "test"
                break
            }
            '^(-v|--verbose)$' {
                $script:VERBOSE_OUTPUT = $true
                break
            }
            '^(-o|--override)$' {
                $scrpit:OVERRIDE = $true
                break
            }
            '^(-p|--prompt)$' {
                $script:PROMPT = $true
                break
            }
            '^-' {
                Write-Error "Error: Unrecognized argument `"$arg`"."
                exit 1
            }
            Default {    
                if ([string]::IsNullOrEmpty($ACTION)) {
                    Write-Error "Error: Command switch missing."
                    exit 1
                }
                
                if ($ACTION -match '^(install|uninstall|hash|test)$') {        
                    if (($argsList.Count - $i) -gt 1) {
                        Write-Error "Error: Optional path argument must be the last argument."
                        exit 1
                    }
                    $script:GAME_DIR = $arg
                } else {
                    Write-Error "Error: Unexpected argument `"$arg`"."
                    exit 1
                }
            }
        }
        $i++
    }
}

# Script entry point execution
Parse-Params -argsList $args
if ([string]::IsNullOrEmpty($ACTION)) {
    Show-Usage
    exit 0
}
Main-Process