<#
.SYNOPSIS
    Dark Deity Community Patch installation and removal tool for Steam on Windows.
.DESCRIPTION
    Ported from Bash to PowerShell. Automatically finds Steam library folders, 
    modifies data.win using UndertaleModCli, and handles backups/restores.
#>

# --- MUST BE FIRST ---
param (
    [Parameter(ParameterSetName='Install')][Switch]$Install,
    [Parameter(ParameterSetName='Uninstall')][Switch]$Uninstall,
    [Parameter(ParameterSetName='Hash')][Switch]$Hash,
    [Parameter(ParameterSetName='Version')][Switch]$VersionInfo,
    [Parameter(ParameterSetName='Help')][Switch]$Help,
    [Parameter(Position=0)][string]$Path,
    [Switch]$VerboseLog
)

# PowerShell equivalent of set -euo pipefail
$ErrorActionPreference = "Stop"

# Script global variables
$SCRIPT_NAME = $MyInvocation.MyCommand.Name
$VERSION = "3.0.0"
$APPID = "1374840"

# Helper to find Steam installation root on Windows via Registry
function Get-SteamRoot {
    $regPath = "HKCU:\SOFTWARE\Valve\Steam"
    if (Test-Path $regPath) {
        return (Get-ItemProperty -Path $regPath).SteamPath
    }
    return $null
}

# Display usage instructions
function Show-Usage {
    @"
Dark Deity Community Patch installation and removal tool for Steam on Windows
Version $VERSION

Usage: 
    .\$SCRIPT_NAME -Install [path]   Install the Dark Deity community patch.
    .\$SCRIPT_NAME -Uninstall [path] Uninstall the Dark Deity community patch.
    .\$SCRIPT_NAME -Hash [path]      Get SHA256 hash of data.win.
    .\$SCRIPT_NAME -VersionInfo      Display the version of the community patch and exit.
    .\$SCRIPT_NAME -Help             Display this help message and exit.

[path] is optional.
The tool will try to locate the Dark Deity install directory automatically.
If that fails for any reason, you can provide the path manually.

Examples:
    .\$SCRIPT_NAME -Install "C:\Program Files (x86)\Steam\steamapps\common\Dark Deity"
    .\$SCRIPT_NAME -Uninstall
"@
}

function Find-LibraryFoldersVdf {
    $steamRoot = Get-SteamRoot
    if ($null -ne $steamRoot) {
        $vdfPath = Join-Path $steamRoot "steamapps\libraryfolders.vdf"
        if (Test-Path $vdfPath) {
            return $vdfPath
        }
    }
    return $null
}

function Get-LibraryPaths {
    param ([string]$vdf)
    
    # Extract paths using regex matching from the vdf file
    $paths = Get-Content $vdf | Where-Object { $_ -match '^\s*"path"\s*"([^"]+)"' } | ForEach-Object {
        $Matches[1] -replace '\\\\', '\'
    }
    return $paths
}

function Find-GameDir {
    param ([string]$appid)

    $vdf = Find-LibraryFoldersVdf
    if ($null -eq $vdf) {
        Write-Error "Steam libraryfolders.vdf not found."
        return $null
    }

    $libraries = Get-LibraryPaths $vdf
    foreach ($library in $libraries) {
        $steamapps = Join-Path $library "steamapps"
        $manifest = Join-Path $steamapps "appmanifest_$appid.acf"

        if (Test-Path $manifest) {
            $installDirLine = Get-Content $manifest | Where-Object { $_ -match '"installdir"\s*"([^"]+)"' }
            if ($installDirLine -and $Matches[1]) {
                return Join-Path $steamapps "common\$($Matches[1])"
            }
        }
    }
    return $null
}

function Invoke-UninstallLogic {
    param ([string]$gameDir)
    $oldData = Join-Path $gameDir "data.win.old"
    $newData = Join-Path $gameDir "data.win"

    if (Test-Path $oldData) {
        Write-Host "--- Uninstalling existing patch ---" -ForegroundColor Yellow
        if (Test-Path $newData) { Remove-Item -Path $newData -Force }
        Rename-Item -Path $oldData -NewName "data.win" -Force
    }
}

function Resolve-GameDirectory {
    param ([string]$providedPath)

    if ([string]::IsNullOrWhiteSpace($providedPath)) {
        $detected = Find-GameDir $APPID
        if ($null -eq $detected) {
            Write-Host "Could not automatically locate the Dark Deity install directory." -ForegroundColor Red
            Write-Host "If you can locate the directory, you can specify it manually."
            Write-Host "Example:`n    .\$SCRIPT_NAME -Install 'C:\Steam\steamapps\common\Dark Deity'"
            exit 1
        }
        return $detected
    }
    return $providedPath
}

# --- Execution Flow ---

if ($Help) {
    Show-Usage
    exit 0
}

if ($VersionInfo) {
    Write-Host "$SCRIPT_NAME version $VERSION"
    exit 0
}

if ($VerboseLog) {
    Write-Host "[INFO] Running script in verbose mode..." -ForegroundColor Cyan
}

# 1. INSTALL LOGIC
if ($Install) {
    $gameDir = Resolve-GameDirectory $Path
    Invoke-UninstallLogic $gameDir

    $targetFile = Join-Path $gameDir "data.win"
    if (Test-Path $targetFile) {
        Write-Host "Found data.win at: $targetFile"
        Write-Host "--- Building patched.win ---" -ForegroundColor Cyan
        
        $patchedWin = Join-Path $gameDir "patched.win"
        if (Test-Path $patchedWin) { Remove-Item $patchedWin -Force }

        # Execute UndertaleModCli
        & utmt_cli\UndertaleModCli.exe load "$targetFile" -s "scripts\nongmlmods.csx" -s "tools\scriptupdater.csx" -o "$patchedWin"

        Write-Host "--- Renaming data.win to data.win.old to save as a backup ---" -ForegroundColor Cyan
        $oldData = Join-Path $gameDir "data.win.old"
        if (Test-Path $oldData) { Remove-Item $oldData -Force }
        Rename-Item -Path $targetFile -NewName "data.win.old" -Force

        Write-Host "--- Renaming patched.win to data.win ---" -ForegroundColor Cyan
        Rename-Item -Path $patchedWin -NewName "data.win" -Force

        Write-Host "Patch was installed successfully." -ForegroundColor Green
        exit 0
    } else {
        Write-Host "Could not find Dark Deity's data.win file." -ForegroundColor Red
        Write-Host "Example:`n    .\$SCRIPT_NAME -Install 'C:\Steam\steamapps\common\Dark Deity'"
        Write-Host "Patch was not installed successfully." -ForegroundColor Red
        exit 1
    }
}

# 2. UNINSTALL LOGIC
if ($Uninstall) {
    $gameDir = Resolve-GameDirectory $Path
    Write-Host "Found Dark Deity folder at: $gameDir"
    
    $oldData = Join-Path $gameDir "data.win.old"
    if (-not (Test-Path $oldData)) {
        Write-Host "Could not find data.win.old in the Dark Deity folder." -ForegroundColor Red
        Write-Host "Either the patch was never installed, it was already uninstalled, or you deleted data.win.old"
        Write-Host "If you deleted data.win.old, follow these steps to uninstall the patch:"
        Write-Host "1) In Steam, select Library"
        Write-Host "2) Right-click Dark Deity and select Properties > Installed Files > Verify integrity of game files"
        exit 1
    }

    Invoke-UninstallLogic $gameDir
    Write-Host "Patch was uninstalled successfully." -ForegroundColor Green
    exit 0
}

# 3. HASH LOGIC
if ($Hash) {
    $gameDir = Resolve-GameDirectory $Path
    $targetFile = Join-Path $gameDir "data.win"
    if (Test-Path $targetFile) {
        (Get-FileHash -Path $targetFile -Algorithm SHA256).Hash.ToLower()
        exit 0
    }
    Write-Host "Could not find the file 'data.win' in the Dark Deity directory" -ForegroundColor Red
    exit 1
}

# Default fall-through if no matching flags are given
Show-Usage