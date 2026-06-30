function Get-SteamGamePath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$AppID
    )

    # Get primary Steam installation path from Registry
    $SteamPath = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "InstallPath" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty InstallPath

    if (-not $SteamPath) {
        Write-Warning "Steam installation not found in registry."
        return $null
    }

    # Initialize list of library paths with the primary one
    $LibraryPaths = [System.Collections.Generic.List[string]]::new()
    $LibraryPaths.Add((Join-Path $SteamPath "steamapps"))

    # Parse secondary libraries from libraryfolders.vdf
    $VdfPath = Join-Path $SteamPath "steamapps\libraryfolders.vdf"
    if (Test-Path $VdfPath) {
        $VdfContent = Get-Content -Path $VdfPath -Raw
        $LibraryMatches = [regex]::Matches($VdfContent, '"path"\s+"([^"]+)"')
        foreach ($Match in $LibraryMatches) {
            $CleanPath = $Match.Groups[1].Value -replace '\\\\', '\'
            $FullLibraryPath = Join-Path $CleanPath "steamapps"
            if ($LibraryPaths -notcontains $FullLibraryPath) {
                $LibraryPaths.Add($FullLibraryPath)
            }
        }
    }

    # Search the libraries for the appmanifest file
    foreach ($Folder in $LibraryPaths) {
        $ManifestPath = Join-Path $Folder "appmanifest_$AppID.acf"
        
        if (Test-Path $ManifestPath) {
            $ManifestContent = Get-Content -Path $ManifestPath -Raw
            if ($ManifestContent -match '"installdir"\s+"([^"]+)"') {
                $InstallDir = $Matches[1]
                # Return the full path and exit the function early
                return (Join-Path $Folder "common\$InstallDir")
            }
        }
    }

    # If the loop finishes without returning, the game wasn't found
    Write-Warning "AppID $AppID is not currently installed or could not be found."
    return $null
}

# Abort the script on any errors
$ErrorActionPreference = "Stop"

$GameDir = Get-SteamGamePath -AppID $1
if ($GameDir -eq $null) {
	exit 1
}
