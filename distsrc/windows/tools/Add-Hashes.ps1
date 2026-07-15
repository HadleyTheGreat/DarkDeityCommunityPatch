param (
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $true)]
    [string]$s,
    [Parameter(Mandatory = $true)]
    [string]$d
)

# Define your file paths here
$BeforeFile = Join-Path "$d" "$data.win" 
$AfterFile  = Join-Path "$d" "patched.win"
$CsvPath    = $s

if (-not Test-Path $BeforeFile) {
    Write-Error "File not found \"$BeforeFile\"
    exit 1"
}

if (-not Test-Path $AfterFile) {
    Write-Error "File not found \"$AfterFile\"
    exit 1"
}

# Calculate SHA256 hashes (.Hash is always uppercase by default)
$BeforeHash = (Get-FileHash -Path $BeforeFile -Algorithm SHA256).Hash
$AfterHash  = (Get-FileHash -Path $AfterFile -Algorithm SHA256).Hash

# Create a custom object to hold the row data
$RowData = [PSCustomObject]@{
    Name       = $Name
    BeforeHash = $BeforeHash
    AfterHash  = $AfterHash
}

# Export to CSV. -Append ensures we don't overwrite existing records.
# -NoTypeInformation cleans up the old-school #TYPE header metadata line.
$RowData | Export-Csv -Path $CsvPath -Append -NoTypeInformation

Write-Host "Successfully logged hashes for '$Name' to $CsvPath"
