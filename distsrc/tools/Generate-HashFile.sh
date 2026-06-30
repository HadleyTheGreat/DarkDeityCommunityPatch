#!/bin/bash

set -euo pipefail

# Get the directory where the script is located (equivalent to $PSScriptRoot)
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "BASE_DIR = $BASE_DIR"

# Define paths (handling relative paths)
IMAGES_DIR="$(realpath "$BASE_DIR/../../images")"
CSV_PATH="$(realpath "$BASE_DIR/../scripts/hashes.csv")"

# Ensure the destination directory for the CSV exists
mkdir -p "$(dirname "$CSV_PATH")"

GAME_DIR=$($BASE_DIR/steamappfinder 1374840)
echo "GAME_DIR = $GAME_DIR"

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
