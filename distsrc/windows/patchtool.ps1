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
$PATCH_DIR = ""
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

$RED=""
$GREEN=""
$YELLOW=""
$BLUE=""
$MAGENTA=""
$CYAN=""
$WHITE=""
$NC="" # No Color (Reset)


function Show-BriefUsage {
@"
Dark Deity Community Patch installation and removal tool for Windows
Usage:
  .\$SCRIPT_NAME COMMAND [OPTIONS]                # auto-locate in Steam
  .\$SCRIPT_NAME COMMAND [OPTIONS] -p             # gui prompt for directory
  .\$SCRIPT_NAME COMMAND [OPTIONS] -d DIRECTORY  # specify Dark Deity directory
COMMAND can be one of:
  -h, -?, --help  Show the help    
  -i, --install   Install the patch
  -u, --uninstall Uninstall the patch
  -a, --auto      Interactively prompt to either uninstall or install 
                  based on the current patched state
  -q, --query     Query the current patch state of Dark Deity  
  -c, --hash      Calculate the SHA256 hash of Dark Deity's data.win file
OPTIONS can be zero or more of:
  -o, --override  Ignore version mismatch and attempt to patch anyway
  -v, --verbose   Show verbose output
DIRECTORY should be enclosed in quotation marks if it contains spaces.
"@
}

function Show-Examples {
    @"
Examples:
  .\$SCRIPT_NAME -a
  .\$SCRIPT_NAME -i -p
  .\$SCRIPT_NAME -i -d "C:\Program Files (x86)\GOG Galaxy\Games\Dark Deity"
  .\$SCRIPT_NAME -u -d "C:\Program Files\Epic Games\Dark Deity"
  .\$SCRIPT_NAME --hash "C:\Program Files (x86)\Steam\steamapps\common\Dark Deity"
"@
}

function Show-Usage {
    Show-BriefUsage
    Show-Examples
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
    $SourceDir = Join-Path $BASE_DIR files
    $addedFiles = Join-Path $PATCH_DIR "addedfiles.txt"

    # Get all files from the source directory
    $files = Get-ChildItem -Path $SourceDir -Name -Recurse -File

    if (-not $files) {
        Write-Host "No files found in source directory." -ForegroundColor Yellow
        return
    }
    
    # Create patch directory if it doesn't exist
    if (-not (Test-Path -Path $PATCH_DIR)) {
        New-Item -ItemType Directory -Path $PATCH_DIR -Force | Out-Null
    }

    # Create backup directory if it doesn't exist
    if (-not (Test-Path -Path $BACKUP_DIR)) {
        New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null
    }

    foreach ($file in $files) {
        $destinationPath = Join-Path -Path $GAME_DIR -ChildPath $file
        $backupPath = Join-Path -Path $BACKUP_DIR -ChildPath $file
        $sourcePath = Join-Path -Path $SourceDir -ChildPath $file

        if (Test-Path -Path $destinationPath) {
        # Is there already an earlier backup version of this file?
            if (-not (Test-Path -Path $backupPath)) {
                $folder = Split-Path -Path $backupPath -Parent
                if (-not (Test-Path -Path $folder)) {
                    New-Item -ItemType Directory -Path $folder -Force | Out-Null
                }

                if ($VERBOSE_OUTPUT) { Write-Output "$file" }           
                # No earlier backup, so store this file as a backup
                Move-Item -Path $destinationPath -Destination $backupPath
            }
        } else {
            if ($VERBOSE_OUTPUT) { Write-Output "$file" }
            # Keep a list of files that have been added that didn't overwrite an existing file
            # This will be used to delete them later on an uninstall
            Add-Content -Path $addedFiles -Value $file
        }

        # Copy the source file to the target directory
        Copy-Item -Path $sourcePath -Destination $destinationPath -Force
    }
}

function Uninstall-FilesFromBackup {
    # This function restores previously backed up files from $BACKUP_DIR to $GAME_DIR, recursively.  After that it, deletes files that were added to $GAME_DIR that were not present before the patch, then finally it removes $BACKUP_DIR.
    if (-not $GAME_DIR) {
        Write-Error "Game directory was unset"
        exit 1
    }

    $addedFiles = Join-Path $PATCH_DIR "addedfiles.txt"

    # --- Restore files backed up in the backup directory ---
    if (Test-Path -Path $BACKUP_DIR -PathType Container) {
        Write-Output "--- Restoring previous version files from backup ---"
        if ($VERBOSE_OUTPUT) { Write-Output "BACKUP_DIR = $BACKUP_DIR" }
        $files2 = Get-ChildItem -Path $BACKUP_DIR -Name -Recurse -File
        foreach ($file in $files2)
        {
            if ($VERBOSE_OUTPUT) { Write-Output "$file" }
            Move-Item (Join-Path $BACKUP_DIR $file) (Join-Path $GAME_DIR $file) -Force
        }

        # Remove the backup folder now that all the files have been restored
        Remove-Item -Path "$BACKUP_DIR" -Recurse -Force
    } else {
        if ($VERBOSE_OUTPUT) { Write-Output "Backup directory '$BACKUP_DIR' does not exist.  Nothing to restore there." }
    }

    # --- Read 'addedfiles.txt' and Delete the files that were added during install ---
    Write-Output "--- Deleting new files added by the patch ---"
    if (Test-Path $addedFiles) {
        if ($VERBOSE_OUTPUT) { Write-Output "Reading file deletion list from '$addedFiles'..." }
            
        # Read lines, filtering out empty lines or spaces
        $filesToDelete = Get-Content -Path $addedFiles | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }

        foreach ($file in $filesToDelete) {
            # Make path relative to target directory if it is not already an absolute path
            if ([System.IO.Path]::IsPathRooted($file)) {
                $fullPath = $file 
            } else {
                $fullPath = Join-Path $GAME_DIR $file
            } 
            

            if (Test-Path $fullPath) {
                Remove-Item -Path $fullPath -Force
                if ($VERBOSE_OUTPUT) { Write-Output "Deleted: $file" }
            } else {
                if ($VERBOSE_OUTPUT) { Write-Output "Skipped (File not found): $file" }
            }
        }
    } else {
        if ($VERBOSE_OUTPUT) { Write-Output "File list '$addedFiles' not found. Skipping deletions." }
    }
}

function Test-LegacyInstall {
    $data_win_old = Join-Path $GAME_DIR "data.win.old"
    $data_win = Join-Path $GAME_DIR "data.win"
    $remove_script = Join-Path $GAME_DIR "removepatch.bat"  # windows remove script
    $remove_script_2 = Join-Path $GAME_DIR "removepatch.sh"  # linux remove script

    return ((Test-Path $data_win_old) -or (Test-Path $remove_script) -or (Test-Path $remove_script_2))
}

function Do-LegacyUninstall {
    $data_win_old = Join-Path $GAME_DIR "data.win.old"
    $data_win = Join-Path $GAME_DIR "data.win"
    $remove_script = Join-Path $GAME_DIR "removepatch.bat"  # windows remove script
    $remove_script_2 = Join-Path $GAME_DIR "removepatch.sh"  # linux remove script

    if ((Test-Path $data_win_old) -or (Test-Path $remove_script) -or (Test-Path $remove_script_2))
    {        
        # Remove or restore legacy files that might be present from earlier versions of the patch
        Write-Output "--- Removing legacy install files ---"
        if (Test-Path -Path $data_win_old) { 
            if ($VERBOSE_OUTPUT) { Write-Output "$data_win_old" }
            Remove-Item -Path $data_win -Force
            Move-Item -Path $data_win_old -Destination $data_win -Force        
        }
        if (Test-Path -Path $remove_script) { 
            if ($VERBOSE_OUTPUT) { Write-Output "$remove_script" }                
            Remove-Item -Path $remove_script -Force
        }
        if (Test-Path -Path $remove_script_2) { 
            if ($VERBOSE_OUTPUT) { Write-Output "$remove_script_2" }                
            Remove-Item -Path $remove_script_2 -Force
        }
    }
}

function Do-Uninstall {
    if (Test-Path $BACKUP_DIR) {
        Write-Output "Uninstalling from backup"
        Uninstall-FilesFromBackup
    }

    # Once the restore is done, remove the patch folder
    if (Test-Path $PATCH_DIR -PathType Container) {
        Write-Output "--- Removing patch folder ---"
        Remove-Item $PATCH_DIR -Recurse -Force
    }

    Do-LegacyUninstall
}

function Do-Install {
    $unpatchedData = Join-Path $GAME_DIR "data.win"
    $patchedData = Join-Path $BASE_DIR "files" | Join-Path -ChildPath "data.win"
 
    Write-Output "--- Rebuilding data.win ---"
    if (Test-Path -Path $patchedData) { Remove-Item -Path $patchedData -Force }
    
    $cliExe = Join-Path $BASE_DIR "utmt_cli" | Join-Path -ChildPath "UndertaleModCli.exe"
    $script1 = Join-Path $BASE_DIR "scripts" | Join-Path -ChildPath "nongmlmods.csx"
    $script2 = Join-Path $BASE_DIR "scripts" | Join-Path -ChildPath "scriptupdater.csx"
    
    # Execute UndertaleModCli
    & $cliExe load "$unpatchedData" -s "$script1" -s "$script2" -o "$patchedData"
      
    Write-Output "--- Installing patch files ---"
    Install-FilesWithBackup
}

function Do-Version {
    Write-Output $VERSION
}

function Do-Hash {
    $currentFile = Join-Path $GAME_DIR "data.win"
    $data_win_old = Join-Path $GAME_DIR "data.win.old"

    if (-not (Test-Path -Path $currentFile -PathType Leaf)) {
        Write-Error "Error: Couldn't find file `"$currentFile`""
        exit 1
    }
    
    $currentHash = Get-Sha256Hash $currentFile
    Write-Output "data.win: $currentHash"
    
    if (Test-Path -Path $data_win_old -PathType Leaf) {        
        $backupHash = Get-Sha256Hash $data_win_old
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
            Write-Output "${YELLOW}Prompt for game directory was cancelled.  Operation aborted.${NC}"
            exit 1
        }
    } elseif ([string]::IsNullOrEmpty($script:GAME_DIR)) {
        $script:GAME_DIR = Find-GameDir $APPID
        if (-not $script:GAME_DIR) {
            Write-Output "Failed to locate the Dark Deity in Steam."
            $script:GAME_DIR = ""
        }    
        if (-not $script:GAME_DIR) {
            $script:GAME_DIR = PromptFor-GameDir
            if ([string]::IsNullOrEmpty($script:GAME_DIR)) {
                Write-Output "${YELLOW}Prompt for game directory was cancelled.  Operation aborted.${NC}"
                exit 1
            }
        }
    }
    if (-not $script:GAME_DIR) {
        @"
${RED}Error: Failed to locate the Dark Deity game directory.${NC}
Use [-d directory] to specify it on the command-line or [-p]
to prompt for it interactively.
Examples:
  .\$SCRIPT_NAME -i -d "C:\Program Files (x86)\GOG Galaxy\Games\Dark Deity"
  .\$SCRIPT_NAME -a -p
  .\$SCRIPT_NAME -u -d "C:\Program Files\Epic Games\Dark Deity"
"@
        exit 1
    }
    
    @"
GAME_DIR = `"$script:GAME_DIR`"
"@
    if (-not (Test-Path -Path $GAME_DIR -PathType Container))
    {
        @"
${RED}Error: Specified game directory does not exist.${NC}
"@
        exit 1
    }

    $currentFile = Join-Path $script:GAME_DIR "data.win"
    if (-not (Test-Path -Path $currentFile -PathType Leaf)) {
        Write-Error "${RED}Error: file not found `"$currentFile`"${NC}"
        exit 1
    }
    
    $script:PATCH_DIR = Join-Path $script:GAME_DIR "patch"
    $script:BACKUP_DIR = Join-Path $script:PATCH_DIR "backup"
}

function Validate-PostHash {
    if ([string]::IsNullOrEmpty($postPatchHash) -or $OVERRIDE) {
	    return
    }
    
    Write-Output "--- Validating data.win ---"
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
    # Return values:
    # 3: Other patch installed - Do-Uninstall needed
    # 2: Ready to install - Do-Install can be peformed
    # 1: Already installed - Do-Uninstall can be performed
    # 0: Cannot install - Dark Deity is the wrong version
    if (-not (Test-Path -Path "$SCRIPTS_DIR" -PathType Container)) {
        Write-Error "Error: Scripts directory missing at`"$SCRIPTS_DIR`""
        exit 1
    }

    $hash_file = Join-Path $SCRIPTS_DIR "versions.csv"
    if (-not (Test-Path -Path "$hash_file" -PathType Leaf)) {
        Write-Error "Error: Versions file is missing at `"$hash_file`""
        exit 1
    }

    if (Test-LegacyInstall) {
        # A patch is already installed, but it isn't this one
        # Return 3: Other patch installed - Uninstall needed
        return 3
    }

    $inputFile = Join-Path $GAME_DIR "data.win"
    $currentHash = Get-Sha256Hash $inputFile
    $match = Import-Csv -Path $hash_file | Where-Object { $_.AfterHash -eq $currentHash } | 
                Select-Object -First 1
    if ($null -ne $match) {
        # Return 1: Installed
        return 1
    }

    if (Test-Path -Path $PATCH_DIR) {
        # A patch is already installed, but it isn't this one or else the hash would have matched
        # Return 3: Other patch installed - Uninstall needed
        return 3
    }

    $match = Import-Csv -Path $hash_file | Where-Object { $_.BeforeHash -eq $currentHash } | 
                Select-Object -First 1
    if ($null -ne $match) {
        $script:postPatchHash = $match.AfterHash
        # The patch is not installed, but data.win is the right version to install on
        # Return 2: Ready to Install
        return 2
    }

    # data.win does doesn't match any expected version
    # Return 0: Dark Deity version mismatch 
    return 0
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
    Write-Host "A different version of the patch is currently installed." -ForegroundColor Yellow
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
        $state = Get-InstallState
        if ($state -eq 0) {
            Write-Host "Error: Dark Deity version mismatch." -ForegroundColor Red
            Write-Host "This patch is intended only for version 1.58 of Dark Deity."
            exit 1
        }
        if ($state -ne 2)
        {
            Write-Host "Error: Previous patch removal resulted in an inconsistent state."
            Write-Host "Please uninstall and reinstall Dark Deity or validate the integrity of the install."
            exit 1
        }
        Do-Install
        Validate-PostHash
        Write-Host "The patch installation was successful." -ForegroundColor Green
    } else {
        Write-Host "You chose No. No changes have been made." -ForegroundColor Yellow
    }
    exit 0
}

function PromptFor-Install {
    Write-Output "The patch is not currently installed."
    Write-Output "This version of Dark Deity is supported."

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
    Write-Output "The patch is not currently installed."
    Write-Output "The patch is not intended for this version of Dark Deity."
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
                # State 0: The game patch is not the right version  The user can override install.
                0 { PromptFor-OverrideInstall }      
                # State 1: The game patch is installed already.  The user can uninstall.
                1 { PromptFor-Uninstall }
                # State 2: The game patch can be installed now.  The user can install.
                2 { PromptFor-Install }
                # State 3: The game patch can only be installed after the previous is uninstalled.  The user can reinstall.
                3 { PromptFor-Reinstall }
            }
            exit 0
        }
        "install" {
            Resolve-GameDir
            $state = Get-InstallState
            if ($state -eq 3) {
                Do-Uninstall
                $state = Get-InstallState
            }
            if ($state -eq 1) {
                Write-Host "The patch is already installed.  Nothing to do." -ForegroundColor Yellow
                exit 0
            }
            if (($state -eq 0) -and ($OVERRIDE -eq $false)) {
                Write-Host "Dark Deity version mismatch.  Operation aborted." -ForegroundColor Red
                exit 1
            }
            if ($state -eq 2) {
                Do-Install
                Validate-PostHash
                Write-Host "The patch installation was successful." -ForegroundColor Green
                exit 0
            }
        }
        "uninstall" {
            Resolve-GameDir
            $state = Get-InstallState
            switch ($state)
            {
                3 { 
                    Do-Uninstall
                    Write-Host "The patch was successfully uninstalled." -ForegroundColor Green
                    exit 0                
                }
                2 {
                    Write-Host "The patch is not currently installed, but this version is supported." -ForegroundColor Yellow
                }
                1 {
                    Do-Uninstall
                    Write-Host "The patch was successfully uninstalled." -ForegroundColor Green
                    exit 0   
                }
                0 {
                    Write-Host "The patch is not currently installed, but it is not intended for this version." -ForegroundColor Yellow
                    exit 0
                }
            }
        }
        "query" {
            Resolve-GameDir
            $state = Get-InstallState
            switch ($state) {
                0 {
                    Write-Output "${YELLOW}The patch is not installed.${NC}"
                    Write-Output "The patch does not support this version of Dark Deity."
                    exit 0
                }
                3 {
                    Write-Output "${YELLOW}A different version of the patch is currently installed.${NC}"
                    exit 0
                }
                2 {
                    Write-Output "${YELLOW}The patch is not currently installed.${NC}"
                    Write-Output "The patch supports this version of Dark Deity."
                    exit 0
                }
                1 {
                    Write-Output "${YELLOW}The patch is already installed.${NC}"
                    exit 0
                }
            }
            exit 0
        }
        "help" {
            Show-Usage
            exit 0
        }
        "hash" {
            Resolve-GameDir
            Do-Hash
            exit 0
        }
        "version" {
            Do-Version
            exit 0
        }
        Default {
            Write-Output "${RED}Internal error: No handler for command `"$ACTION`".${NC}"
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
                continue
            }
            '^(-a|--auto)$' {
                Set-Action "auto"
                continue
            }

            '^(-i|--install)$' {
                Set-Action "install"
                continue
            }
            '^(-u|--uninstall)$' {
                Set-Action "uninstall"
                continue
            }
            '^(-c|--hash)$' {
                Set-Action "hash"
                continue
            }
            '^--version$' {
                Set-Action "version"
                continue
            }
            '^(-q|--query)$' {
                Set-Action "query"
                continue
            }
            '^(-v|--verbose)$' {
                $script:VERBOSE_OUTPUT = $true
                continue
            }
            '^(-o|--override)$' {
                $script:OVERRIDE = $true
                continue
            }
            '^(-p|--prompt)$' {
                $script:PROMPT = $true
                continue
            }
            '^(-d|--directory)$' {
                $i++;
                if (-not ($i -lt $argsList.Count)) {
                    @"
${RED}Error: missing directory after `"$arg`".${NC}
"@
                    exit 1
                } 
                if ([string]::IsNullOrEmpty($argsList[$i])) {
                    @"
${RED}Error: directory argument is empty.${NC}
"@
                }

                $script:GAME_DIR = $argsList[$i]
                continue
            }
            '^-' {
                @"
${RED}Error: Unrecognized command or option `"$arg`".${NC}
"@
                exit 1
                continue;
            }
            Default {
                @"
${RED}Error: Unexpected argument \"$arg\".${NC}
Be sure to enclose directory paths with quotation marks if they contain spaces.
Examples:
  ./$SCRIPT_NAME -i -d `"C:\Program Files (x86)\GOG Galaxy\Games\Dark Deity`"
  ./$SCRIPT_NAME -u -d `"C:\Program Files\Epic Games\Dark Deity`"
"@
                exit 1
            }
        }
        $i++
    }
}

# Script entry point execution
Parse-Params -argsList @($args)
if ([string]::IsNullOrEmpty($ACTION)) {
    Show-Usage
    exit 0
}
Main-Process
