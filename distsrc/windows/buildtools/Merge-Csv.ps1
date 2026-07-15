param(
    [Parameter(Mandatory = $true)]
    [string]$sourceFolder,
    [Parameter(Mandatory = $false)]
    [string]$outputFile = "$folder\hashes.csv"
)

# Get all CSV files in the folder (excluding the output file if it already exists)
$csvFiles = Get-ChildItem -Path $sourceFolder -Filter hashes_*.csv | Where-Object { $_.FullName -ne $outputFile }

# Import and merge them, then export to the new file
$csvFiles | ForEach-Object {
    Import-Csv -Path $_.FullName
} | Export-Csv -Path $outputFile -NoTypeInformation -Encoding utf8

Write-Host "Successfully merged $($csvFiles.Count) files into $outputFile" -ForegroundColor Green
