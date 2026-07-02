Add-Type @"
using System;
using System.Text;
using System.Runtime.InteropServices;

public class Win32 {
    // Grabs the handle (HWND) of the current foreground window
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();

    // Attempts to set the current foreground window
    [DllImport("user32.dll")]
    public static extern bool SetForegroundWindow(IntPtr hWnd);

    // Retrieves the title text of a specific window handle
    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

    // Gets the process id of the process that owns a specific window
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint ProcessId);

    // Change the state that the current window is shown in (to minimize, restore or maximize it)
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

    // Post a message to a window and don't resume until after it is received
    [DllImport("user32.dll")]
    public static extern bool PostMessage(
        IntPtr hWnd,
        uint Msg,
        IntPtr wParam,
        IntPtr lParam);

    // Constants for nCmdShow
    public const int SW_MINIMIZE = 6;
    public const int SW_RESTORE = 9;

    // Constant for PostMessage
    public const int WM_CLOSE = 0x0010;
}
"@

function Take-ForegroundWindowFromSteam {
    param(
        [Parameter(Mandatory = $true)]
        [IntPtr]$hwnd
    )
    # This function sees if Steam is the owner of the current foreground window and if it is it posts a windows message to close the window.  Windows security prevents unelevated background threads from taking the foreground window (input focus) away from the foreground thread to prevent malware shenanigans, but once we close the Steam window there will be no foreground window and this script will be eligible to set the current foreground window.

    # Get the thread ID of the current foreground window and our script's thread ID
    $foregroundHwnd = [Win32]::GetForegroundWindow()
    
    [uint32]$foregroundProcessId = 0
    $foregroundThreadId = [Win32]::GetWindowThreadProcessId($foregroundHwnd, [ref]$foregroundProcessId)
    
    [uint32]$targetProcessId = 0
    $targetThreadId = [Win32]::GetWindowThreadProcessId($hwnd, [ref]$targetProcessId)

    # Only do something if this process isn't the one that already owns the foreground window
    if ($foregroundThreadId -ne $targetThreadId) {
        $proc = Get-Process -Id $foregroundProcessId -ErrorAction SilentlyContinue
        $procName = $proc.ProcessName
        if ($proc -and $proc.ProcessName -eq "steamwebhelper") {
            # Post a windows message requesting the current foreground window to close.  This is the equivalent of clicking on the X in the corner of the window.  Once the window is closed, there will no longer be a foreground window so Windows security will allow a background process to set a new foreground window.
            Write-Host "Closing the steamwebhelper window and restoring the original foreground window"
            #$result = [Win32]::ShowWindow($foregroundHwnd, [Win32]::SW_MINIMIZE)
            $result = [Win32]::PostMessage($foregroundHwnd, [Win32]::WM_CLOSE, [IntPtr]::Zero, [IntPtr]::Zero)

            # With there being no current foreground window, we are eligible to set a new one
            $result = [Win32]::SetForegroundWindow($hwnd)
        }
    }
}

# Helper function to extract the title string from the HWND
function Get-ActiveWindowTitle {
    $Hwnd = [Win32]::GetForegroundWindow()
    if ($Hwnd -eq [IntPtr]::Zero) { return "No Active Window" }

    $TitleBuilder = [System.Text.StringBuilder]::new(256)
    [Win32]::GetWindowText($Hwnd, $TitleBuilder, $TitleBuilder.Capacity) | Out-Null
    
    #return [PSCustomObject]@{
    #    Handle = $Hwnd
    #    Title  = $TitleBuilder.ToString()
    #}
    return $TitleBuilder.ToString()
}

function WaitFor-FileExists {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$waitForPath,

        [Parameter(Mandatory = $false, Position = 1)]
        [int]$timeoutSeconds =  9999999,

        [Parameter(Mandatory = $false, Position = 2)]
        [int]$checkInterval = 1
    )

    $secondsElapsed = 0

    Write-Host "Waiting for '$waitForPath' to be replaced by Steam"
    while (-not (Test-Path -Path $waitForPath) -and ($secondsElapsed -lt $timeoutSeconds)) {
        Start-Sleep -Seconds $checkInterval
        $secondsElapsed += $checkInterval
        if ($secondsElapsed % 5 -eq 0) {
            Write-Host "Still waiting... ($secondsElapsed seconds elapsed)"
        }
    }
}

function Launch-SteamAppValidate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$AppID
    )

    Start-Process "steam://validate/$AppID"
}

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

$StoredForegroundWindow = [Win32]::GetForegroundWindow()

# The name of the data file that has the GameMaker scripts in it
$DataWinFileName = "data.win"

# The steam application id for Dark Deity
$AppId = "1374840"

# Locate the game's install folder that contains the DATA.WIN file
$DataWinFolder = Get-SteamGamePath -AppID $AppId
if (-not $DataWinFolder) {
    Throw "Could not find game installation folder path."
}

$DataWinPath = Join-Path $DataWinFolder $DataWinFileName
$backupPath = "${DataWinPath}.old"

# Delete the DATA.WIN file so that the Steam file integrity check will have to replace it with the original un-patched version
if ([System.IO.File]::Exists($DataWinPath)) {
    Remove-Item -Path $DataWinPath -Force
}

Write-Host "Launching the application's Steam file integrity check to acquire the original DATA.WIN file"
# Launch the Steam file integrity check to get it to replace the deleted file
Launch-SteamAppValidate $AppId
Start-Sleep -Milliseconds 5000

# The Launch-SteamAppValidate call will have resulted in the Steam window becoming the current foreground window if there was already a Steam window open on the desktop.  Windows security restrictions won't allow a thread (this script) to change the foreground window to take the foreground focus if it is owned by another thread unless the thread is running with elevated security status or there is no current foreground window set.  Take-ForegroundWindowFromSteam will close the Steam window if it has the foreground so that there is no current foreground window anymore, then set the original foreground window back as the foreground window.  If Steam doesn't have ownership of the foreground window it won't do anything.
Take-ForegroundWindowFromSteam $StoredForegroundWindow

WaitFor-FileExists $DataWinPath

# Fallback to protect path layout if running selections (F8) inside an editor where $PSScriptRoot resolves as null
$BaseDir = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
$DestinationPath = Join-Path $BaseDir "..\..\images\PREPATCH.WIN"

Write-Host "Copying the DATA.WIN file to $DestinationPath"
Copy-Item -Path $DataWinPath -Destination $DestinationPath