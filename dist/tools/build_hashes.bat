del scripts\known_hashes.csv
powershell -ExecutionPolicy Unrestricted -Command ".\Get-Hashes.ps1 -folderPath "..\originals" -OutputFile "..\scripts\known_hashes.csv"