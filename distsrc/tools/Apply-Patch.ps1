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

# The name of the data file that has the GameMaker scripts in it
$DataWinFileName = "data.win"

# The steam application id for Dark Deity
$AppId = "1374840"

# Locate the game's install folder that contains the DATA.WIN file
$DataWinFolder = Get-SteamGamePath -AppID $AppId

$DataWinPath = Join-Path $DataWinFolder $DataWinFileName
$backupPath = "${DataWinPath}.old"

$csvPath = "scripts/hashes.csv"

$hashTable = @{}

if ([System.IO.File]::Exists($csvPath)) {
    Import-Csv -Path $csvPath | ForEach-Object {
        # Key = id, Value = sha256hash
        $hashtable[$_.id] = $_.sha256hash
    }
    $buildingHashes = $false
} else {
    $hashTable["prePatch"] = ""
    $hashTable["postPatch"] = ""
    $buildingHashes = $true
}

# Fetch the pre-patch expected hash and post-patch expected hash from the hash table
$preHash = $hashTable["prePatch"]
$postHash = $hashTable["postPatch"]

if ([System.IO.File]::Exists($DataWinPath)) {
    # Calculate the file's SHA256 hash and extract just the Hash value
    Write-Host "Calculating the pre-patch SHA256 hash"
    $CurrentHash = (Get-FileHash -Path $DataWinPath -Algorithm SHA256).Hash
    
    if ($buildingHashes -eq $true) {
        $hashTable["prePatch"] = $CurrentHash
        $preHash = $CurrentHash
    }
    
    # Compare the hashes (PowerShell's -eq is case-insensitive by default)
    if ($CurrentHash -eq $preHash) {
        if ($buildingHashes -eq $true) {
            Write-Host "There is no hash file, so a new one will be created." -ForegroundColor Yellow
            Write-Host "No version validation will be performed." -ForegroundColor Yellow
        } else {
            Write-Host "DATA.WIN matches the expected version."
        }   
        
        Write-Host "Saving a backup to $backupPath"
        Copy-Item -Path $DataWinPath -Destination $backupPath -Force
        
        utmt_cli\undertalemodcli load "$DataWinPath" -s tools\scriptupdater.csx -o "$DataWinPath"
        
        if ($LASTEXITCODE -eq 0) {
            if ($buildingHashes -eq $true) {
                Write-Host "Calculating the post-patch SHA256 hash"

                $CurrentHash = (Get-FileHash -Path $DataWinPath -Algorithm SHA256).Hash
                $hashTable["postPatch"] = $CurrentHash

                # Write the hashTable back to the csv file at $csvPath
                $hashTable.GetEnumerator() |
                    Sort-Object Key |
                    Select-Object `
                        @{Name='id'; Expression={$_.Key}},
                        @{Name='sha256hash'; Expression={$_.Value}} |
                    Export-Csv -Path $csvPath -NoTypeInformation

                Write-Host "New hash file created at $csvPath"
                Write-Host "Patch applied successfully" -ForegroundColor Green
            } else {
                Write-Host "Calculating the post-patch SHA256 hash"
                $CurrentHash = (Get-FileHash -Path $DataWinPath -Algorithm SHA256).Hash
                if ($CurrentHash -eq $postHash) {
                    Write-Host "Validation hash matches expected value" 
                    Write-Host "Patch applied successfully" -ForegroundColor Green
                } else {
                    Write-Host "VALIDATION MISMATCH! The patch was applied but DATA.WIN may be corrupt." -ForegroundColor Red   
                }
            } 
        } else {
            Write-Host "Unexpected error while processing the DATA.WIN file" -ForegroundColor Red
            Write-Host "Restoring the original DATA.WIN from the backup file"
            Copy-Item -Path $backupPath -Destination $DataWinPath -Force
            Write-Host "The patch was not applied successfully." -ForegroundColor Red
        }
    } elseif ($CurrentHash -eq $postHash) {
        Write-Host "The DATA.WIN file was already patched with this patch." -ForegroundColor Yellow
        if ([System.IO.File]::Exists($backupPath)) {
            Write-Host "There exists a backup file in DATA.WIN.OLD"
            $title = ""
            $message = "Do you want to restore to the pre-patch state from the backup?"

            # Define the choices. The ampersand (&) marks the shortcut key.
            $choices = @(
                [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Continue with the operation.")
                [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel the operation.")
            )
            # default choice: 0 = yes, 1 = no
            $default = 1

            $choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)

            if ($choice -eq 0) {
                Write-Host "Restoring the original DATA.WIN from the backup file"
                Copy-Item -Path $backupPath -Destination $DataWinPath -Force
                Write-Host "Deleting the backup file"
                Remove-Item $backupPath
                Write-Host "The patch has been removed successfully." -ForegroundColor Green         
            } else {
                Write-Host "You chose No. No changes have been made to DATA.WIN" -ForegroundColor Yellow
            }
        } else {
            Write-Host "No backup file exists in WIN.DATA.OLD" -ForegroundColor Yellow

            $title   = ""
            $message = "Do you want to launch Steam's file integrity check URL for the game to restore it to its original version?"

            # Define the choices. The ampersand (&) marks the shortcut key.
            $choices = @(
                [System.Management.Automation.Host.ChoiceDescription]::new("&Yes", "Continue with the operation.")
                [System.Management.Automation.Host.ChoiceDescription]::new("&No", "Cancel the operation.")
            )
            # default choice: 0 = yes, 1 = no
            $default = 1

            $choice = $Host.UI.PromptForChoice($title, $message, $choices, $default)

            if ($choice -eq 0) {
                Start "steam://validate/1374840"

                $timeoutSeconds = 60  # Stop waiting after 1 minute
                $checkInterval = 1    # Check every 1 second
                $secondsElapsed = 0

                Write-Host "Waiting for '$DataWinPath' to be removed by Steam"
                while ((Test-Path -Path $DataWinPath) -and ($secondsElapsed -lt $timeoutSeconds)) {
                    Start-Sleep -Seconds $checkInterval
                    $secondsElapsed += $checkInterval
                    if ($secondsElapsed % 5 -eq 0) {
                        Write-Host "Still waiting... ($secondsElapsed seconds elapsed)"
                    }
                }

                $secondsElapsed = 0

                Write-Host "Waiting for '$DataWinPath' to be replaced by Steam"
                while (-not (Test-Path -Path $DataWinPath) -and ($secondsElapsed -lt $timeoutSeconds)) {
                    Start-Sleep -Seconds $checkInterval
                    $secondsElapsed += $checkInterval
                    if ($secondsElapsed % 5 -eq 0) {
                        Write-Host "Still waiting... ($secondsElapsed seconds elapsed)"
                    }
                }

                Write-Host "The patch has been removed successfully." -ForegroundColor Green
            } else {
                Write-Host "You chose No. No changes have been made to DATA.WIN" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Warning "Error: Hash mismatch!"
        Write-Host "Expected: $preHash" -ForegroundColor Cyan
        Write-Host "Calculated: $CurrentHash" -ForegroundColor Red
        Write-Host ""
        Write-Host "This patch is not meant to operate on this version of DATA.WIN" -ForegroundColor Red
        Write-Host "DATA.WIN does not match either the expected pre-patch or post-patch file hash" -ForegroundColor Red
    } 
} else {
    Write-Warning "Error: DATA.WIN not found at $DataWinPath"
}
