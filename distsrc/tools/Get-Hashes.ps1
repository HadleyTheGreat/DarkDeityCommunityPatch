param(
    [Parameter(Mandatory = $true)]
    [string]$FolderPath,

    [string]$OutputFile = "known_hashes.csv"
)

# Create file with header if it doesn't exist
if (!(Test-Path $OutputFile)) {
    "filename,hash" | Out-File -Encoding utf8 $OutputFile
}

Get-ChildItem -Path $FolderPath -File -Recurse | ForEach-Object {

    # Just the file name (no path)
    $fileName = $_.Name

    # Compute SHA256
    $hash = Get-FileHash -Path $_.FullName -Algorithm SHA256

    # Write: filename,hash
    "$fileName,$($hash.Hash.ToLower())" | Add-Content -Path $OutputFile
}
