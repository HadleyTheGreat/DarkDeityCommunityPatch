#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Error: Missing argument."
    echo "Usage: $0 {path to folder}"
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: '$TARGET_DIR' is not a valid directory."
    exit 1
fi

# Get the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "BASE_DIR = $BASE_DIR"

GAME_DIR=$($BASE_DIR/Get-SteamAppPath.sh 1374840)
echo "GAME_DIR = $GAME_DIR"

# Define paths (handling relative paths)
CSV_PATH="$(realpath "$TARGET_DIR/hashes.csv")"

# Ensure the destination directory for the CSV exists
mkdir -p "$(dirname "$CSV_PATH")"

# Calculate SHA256 hashes
# 'sha256sum' outputs: "[hash] [file_path]". We use 'awk' to grab just the hash.
PRE_PATCH=$(sha256sum "$GAME_DIR/data.win" | awk '{print $1}')
POST_PATCH=$(sha256sum "$GAME_DIR/patched.win" | awk '{print $1}')

# Write to CSV format (sorted alphabetically by key: postPatch then prePatch)
{
    echo '"id","sha256hash"'
    echo "\"postPatch\",\"$POST_PATCH\""
    echo "\"prePatch\",\"$PRE_PATCH\""
} > "$CSV_PATH"

echo "Hashes successfully written to $CSV_PATH"
