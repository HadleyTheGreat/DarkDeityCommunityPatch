$ErrorActionPreference = "Stop"

if ($args.Count -ne 1) {
	throw "Usage: .\$($MyInvocation.MyCommand.Name) {path to folder}"
}

$TargetDir = $args[0]

if (-not (Test-Path -Path $TargetDir -PathType Container)) {
    Write-Error "Error: '$TargetDir' is not a valid directory." -Category ObjectNotFound
}

# Get the directory where the script is located
$BaseDir = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

$GameDir = & (Join-Path $BaseDir "Get-SteamAppPath.ps1") 1374840
if ([string]::IsNullOrWhiteSpace($GameDir)) {
	Write-Error "Error: Couldn't find the Steam path" -Category ObjectNotFound
}

$CsvPath = [System.IO.Path]::GetFullPath((Join-Path $TargetDir "hashes.csv"))
$ParentDir = Split-Path $CsvPath -Parent

# Ensure the destination directory for the CSV file exists
if (-not (Test-Path -Path $ParentDir)) {
    New-Item -ItemType Directory -Path $ParentDir -Force | Out-Null
}

# Calculate SHA256 hashes
# Get-FileHash outputs an object; we grab just the .Hash property
$PrePatch  = (Get-FileHash -Path (Join-Path $GameDir "data.win") -Algorithm SHA256).Hash.ToLower()
$PostPatch = (Get-FileHash -Path (Join-Path $GameDir "patched.win") -Algorithm SHA256).Hash.ToLower()

# Create a hash table
$Hashes = @(
    [PSCustomObject]@{ id = "prePatch";  sha256hash = $PrePatch }
    [PSCustomObject]@{ id = "postPatch"; sha256hash = $PostPatch }
)

# Export the hash table to a CSV file
$Hashes | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8

Write-Host "Hashes successfully written to $CsvPath"
