$BaseDir = if ($PSScriptRoot) { $PSScriptRoot } else { Get-Location }
$ImagesDir = Join-Path $BaseDir "..\..\images"

$csvPath = "$BaseDir\..\scripts\hashes.csv"

$hashTable = @{}
$hashTable["prePatch"] = (Get-FileHash -Path "$ImagesDir\PREPATCH.WIN" -Algorithm SHA256).Hash
$hashTable["postPatch"] = (Get-FileHash -Path "$ImagesDir\POSTPATCH.WIN" -Algorithm SHA256).Hash

# Write the hashTable back to the csv file at $csvPath
$hashTable.GetEnumerator() |
    Sort-Object Key |
    Select-Object `
        @{Name='id'; Expression={$_.Key}},
        @{Name='sha256hash'; Expression={$_.Value}} |
    Export-Csv -Path $csvPath -NoTypeInformation
