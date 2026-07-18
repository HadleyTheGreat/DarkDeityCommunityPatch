#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Help/Usage function
usage() {
    echo "Usage: $0 --sourceFolder <path> [--outputFile <path>]"
    exit 1
}

# Parse named arguments
sourceFolder=""
outputFile=""

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --sourceFolder) sourceFolder="$2"; shift ;;
        --outputFile) outputFile="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; usage ;;
    esac
    shift
done

# Check mandatory parameter
if [ -z "$sourceFolder" ]; then
    echo "Error: --sourceFolder is mandatory."
    usage
fi

# Set default output file if not provided
if [ -z "$outputFile" ]; then
    outputFile="${sourceFolder}/versions.csv"
fi

# Ensure the output directory exists before resolving its path
outputDir=$(dirname "$outputFile")
mkdir -p "$outputDir"

# Resolve absolute paths to avoid issues with find/relative paths
sourceFolder=$(realpath "$sourceFolder")
outputFile=$(realpath "$outputFile")

# Find all 'hashes.csv' files, excluding the output file itself
# We read them into an array to keep track of the count
mapfile -t csvFiles < <(find "$sourceFolder" -type f -name "hashes.csv" ! -path "$outputFile")

fileCount=${#csvFiles[@]}

if [ "$fileCount" -eq 0 ]; then
    echo "No 'hashes.csv' files found in $sourceFolder."
    exit 0
fi

# Merge the CSVs safely (ensuring headers aren't repeated)
firstFile=true
> "$outputFile" # Clear/create the output file

for file in "${csvFiles[@]}"; do
    if [ "$firstFile" = true ]; then
        # Copy the entire first file (including the header)
        cat "$file" >> "$outputFile"
        firstFile=false
    else
        # Skip the header (first line) for subsequent files
        tail -n +2 "$file" >> "$outputFile"
    fi
done

# Green text output matching 'Write-Host -ForegroundColor Green'
echo -e "\e[32mSuccessfully merged ${fileCount} files into $outputFile\e[0m"
