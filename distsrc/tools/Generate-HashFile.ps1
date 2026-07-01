# Abort the script on any errors
$ErrorActionPreference = "Stop"

$BaseDir = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }

$GameDir = & $BaseDir\Get-SteamAppPath 1374840
if ("$GameDir" -eq "") {
    Write-Warning "Couldn't find the Steam path"
    exit 1
}
#$csvPath = "$BaseDir\..\scripts\hashes.csv"
$csvPath = Join-Path "$BaseDir" "..\scripts\hashes.csv"

$hashTable = @{}
$hashTable["prePatch"] = (Get-FileHash -Path "$GameDir\data.win" -Algorithm SHA256).Hash
$hashTable["postPatch"] = (Get-FileHash -Path "$GameDir\patched.win" -Algorithm SHA256).Hash

# Write the hashTable back to the csv file at $csvPath
$hashTable.GetEnumerator() |
    Sort-Object Key |
    Select-Object `
        @{Name='id'; Expression={$_.Key}},
        @{Name='sha256hash'; Expression={$_.Value}} |
    Export-Csv -Path $csvPath -NoTypeInformation
