#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Initialize variables
NAME=""
DIR=""
CSV_PATH=""

# Parse command line options
while getopts "n:d:s:" opt; do
  case ${opt} in
    n ) NAME=$OPTARG ;;
    d ) DIR=$OPTARG ;;
    s ) CSV_PATH=$OPTARG ;;
    \? ) 
        echo "Usage: $0 -n Name -d Directory -s CsvPath" >&2
        exit 1
        ;;
  esac
done

# Ensure all mandatory parameters are provided
if [ -z "$NAME" ] || [ -z "$DIR" ] || [ -z "$CSV_PATH" ]; then
    echo "Error: Missing mandatory parameters." >&2
    echo "Usage: $0 -n Name -d Directory -s CsvPath" >&2
    exit 1
fi

# Define your file paths
BEFORE_FILE="${DIR}/data.win"
AFTER_FILE="${DIR}/patched.win"

# Check if files exist
if [ ! -f "$BEFORE_FILE" ]; then
    echo "Error: File not found \"$BEFORE_FILE\"" >&2
    exit 1
fi

if [ ! -f "$AFTER_FILE" ]; then
    echo "Error: File not found \"$AFTER_FILE\"" >&2
    exit 1
fi

# Calculate SHA256 hashes
# 'sha256sum' outputs lowercase hashes; we pipe to 'tr' to convert them to uppercase
# and 'awk' to grab just the hash portion (ignoring the file name)
BEFORE_HASH=$(sha256sum "$BEFORE_FILE" | awk '{print tolower($1)}')
AFTER_HASH=$(sha256sum "$AFTER_FILE" | awk '{print tolower($1)}')

# Format CSV line (handling quoting in case Name contains spaces or special characters)
# We replace any internal quotes in NAME with double-quotes to conform to CSV standards
SAFE_NAME=$(echo "$NAME" | sed 's/"/""/g')
CSV_ROW="\"$SAFE_NAME\",\"$BEFORE_HASH\",\"$AFTER_HASH\""

# Create CSV header if the file doesn't exist yet
if [ ! -f "$CSV_PATH" ]; then
    echo '"Name","BeforeHash","AfterHash"' > "$CSV_PATH"
fi

# Append the row to the CSV
echo "$CSV_ROW" >> "$CSV_PATH"

echo "Successfully logged hashes for '$NAME' to $CSV_PATH"
