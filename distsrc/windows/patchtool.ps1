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
$ACTION = ""
$OVERRIDE = $false

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

function Load-Hashes {
    if (-not (Test-Path -Path $SCRIPTS_DIR -PathType Container)) {
        Write-Error "Error: `"$SCRIPTS_DIR`" directory not found."
        exit 1
    }
    
    $hash_file = Join-Path $SCRIPTS_DIR "hashes.csv"
    if (-not (Test-Path -Path $hash_file -PathType Leaf)) {
        $script:prePatchHash = ""
        $script:postPatchHash = ""
        Write-Warning "Hash file not present. Version validation will be skipped."
    } else {
        # Emulate the awk logic using regex pattern matching
        Get-Content $hash_file | ForEach-Object {
            if ($_ -match '"prePatch"[^"]*"([^"]+)"') { $script:prePatchHash = $Matches[1] }
            if ($_ -match '"postPatch"[^"]*"([^"]+)"') { $script:postPatchHash = $Matches[1] }
        }
    }
}

function Show-Usage {
    @"
Dark Deity Community Patch installation and removal tool for Windows

This patch is for Dark Deity version 1.5.8.

Usage: 
  .\$SCRIPT_NAME COMMAND [FLAGS] [directory]
COMMAND can be one of
  -h, -?, --help  Show this help    
  -i, --install   Install the patch
  -u, --uninstall Uninstall the patch
  -c, --hash      Calculate the hash of data.win and data.win.old if it exists
FLAGS can be one or more of
  -o, --override  Ignore pre-patch validation failures and patch anyway
    
[directory] optionally specifies the directory of the Dark Deity executable 

Examples:
  .\$SCRIPT_NAME -i
  .\$SCRIPT_NAME -i "C:\Program Files (x86)\Steam\steamapps\common\Dark Deity"
  .\$SCRIPT_NAME -u "C:\Games\Dark Deity"
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
        Write-Error "Steam libraryfolders.vdf not found"
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

function Do-Uninstall {
    $oldFile = Join-Path $GAME_DIR "data.win.old"
    $currentFile = Join-Path $GAME_DIR "data.win"
    $removeScript = Join-Path $GAME_DIR "removepatch.ps1" # Changed extension for Windows

    if (Test-Path -Path $oldFile -PathType Leaf) {
        Write-Output "--- Uninstalling existing patch ---"
        if (Test-Path -Path $currentFile) { Remove-Item -Path $currentFile -Force }
        Move-Item -Path $oldFile -Destination $currentFile -Force
        if (Test-Path -Path $removeScript) { Remove-Item -Path $removeScript -Force }
    }
}

function Do-Install {
    $currentFile = Join-Path $GAME_DIR "data.win"
    $patchedFile = Join-Path $GAME_DIR "patched.win"
    $oldFile = Join-Path $GAME_DIR "data.win.old"
    
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
    
    # Note: Copying removepatch.ps1 instead of .sh for Windows environments
    $winTool = Join-Path $BASE_DIR "tools" | Join-Path -ChildPath "removepatch.ps1"
    if (Test-Path $winTool) {
        Copy-Item -Path $winTool -Destination (Join-Path $GAME_DIR "removepatch.ps1") -Force
    }
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

function Validate-GameDir {
    if ([string]::IsNullOrEmpty($script:GAME_DIR)) {
        $script:GAME_DIR = Find-GameDir $APPID
        if (-not $script:GAME_DIR) {
            Write-Error "Error: Failed to automatically locate the Dark Deity install folder.`nIf you can locate the directory, you can specify it manually.`nExamples:`n    .\$SCRIPT_NAME -i `"C:\Steam\steamapps\common\Dark Deity`""
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

function Validate-PreHash {
    if ([string]::IsNullOrEmpty($prePatchHash)) {
        return
    }
    
    $currentFile = Join-Path $GAME_DIR "data.win"
    $currentHash = Get-Sha256Hash $currentFile
    
    if ($currentHash -eq $postPatchHash) {
        Write-Output "Patch was already installed. Nothing to do."
        exit 0
    }
    
    if ($currentHash -eq $prePatchHash) {
        return
    }
    
    $backupHash = ""
    $oldFile = Join-Path $GAME_DIR "data.win.old"
    if (Test-Path -Path $oldFile -PathType Leaf) {
        $backupHash = Get-Sha256Hash $oldFile
    }

    if ($backupHash -eq $prePatchHash) {
        Do-Uninstall
        return
    }

    if ($OVERRIDE) {
        return
    }

    Write-Output "Expected pre-patch hash:  $prePatchHash"
    Write-Output "Expected post-patch hash: $postPatchHash"
    Write-Output "data.win hash:            $currentHash"
    if (-not [string]::IsNullOrEmpty($backupHash)) {
        Write-Output "data.win.old hash:    $backupHash"
    }
    Write-Error "Error: Dark Deity version mismatch."
    Write-Output "You can use the --override switch to force it to be applied."
    exit 1
}

function Validate-PostHash {
    if ([string]::IsNullOrEmpty($postPatchHash) -or $OVERRIDE) {
        Write-Host "The patch installation was successful." -ForegroundColor Green
        exit 0
    }
        
    $currentFile = Join-Path $GAME_DIR "data.win"
    $currentHash = Get-Sha256Hash $currentFile
    if ($currentHash -eq $postPatchHash) {
        Write-Output "Post-patch hash validation passed."
        Write-Host "The patch installation was successful." -ForegroundColor Green
        exit 0
    } else {    
        Write-Output "Expected hash: $postPatchHash"
        Write-Output "Actual hash: $currentHash"
        Write-Host "Post-patch hash validation failed." -ForegroundColor Red
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
        
function Main-Process {
    switch ($ACTION) {
        "install" {
            Load-Hashes
            Validate-GameDir
            Validate-PreHash
            Do-Install
            Validate-PostHash
        }
        "uninstall" {
            Validate-GameDir
            $oldFile = Join-Path $GAME_DIR "data.win.old"
            if (-not (Test-Path -Path $oldFile -PathType Leaf)) {
                @"
There is no backup file "$oldFile".
Either:
   1) The patch was never installed.
   2) The patch was installed but it has already been uninstalled.
   3) The patch is still installed but you deleted the backup file.
If your problem is #3 then to uninstall you should:
   - Go to your Library in Steam
   - Right-click Dark Deity and select Properties->Installed Files
   - Click on Verify integrity of game files
   This will cause Steam to check the game files and re-download data.win if necessary.
"@
            }
            Do-Uninstall
        }
        "help" {
            Show-Usage
        }
        "hash" {
            Validate-GameDir
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
            '^(-v|--verbose)$' {
                VERBOSE_OUTPUT = $true
                break
            }
            '^(-o|--override)$' {
                OVERRIDE = $true
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
                
                if ($ACTION -match '^(install|uninstall|hash)$') {        
                    if (($argsList.Count - $i) -gt 1) {
                        Write-Error "Error: Optional path argument must be the last argument."
                        exit 1
                    }
                    $GAME_DIR = $arg
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