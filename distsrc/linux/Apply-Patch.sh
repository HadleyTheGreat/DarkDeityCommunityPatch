#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Error: Missing argument."
    echo "Usage: $0 {path to folder}"
    exit 1
fi

SCRIPT_DIR=$(realpath $1)

if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Error: '$SCRIPT_DIR' is not a valid directory."
    exit 1
fi

# Get the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "BASE_DIR = $BASE_DIR"

GAME_DIR=$($BASE_DIR/Get-SteamAppPath.sh 1374840)
echo "GAME_DIR = $GAME_DIR"

DATA_FILE="$GAME_DIR/data.win"
HASH_FILE="$SCRIPT_DIR/hashes.csv"
PATCH_SCRIPT="$BASE_DIR/patchtool"
install=0

[[ -f "$DATA_FILE" ]] || { echo "Error: $DATA_FILE not found."; exit 1; }
[[ -f "$HASH_FILE" ]] || { echo "Error: $HASH_FILE not found."; exit 1; }
[[ -x "$PATCH_SCRIPT" ]] || { echo "Error: $PATCH_SCRIPT not found or not executable."; exit 1; }

# Read hashes from CSV
prePatchHash=$(awk -F'"' '$2=="prePatch" {print $4}' "$HASH_FILE")
postPatchHash=$(awk -F'"' '$2=="postPatch" {print $4}' "$HASH_FILE")

if [[ -z "$prePatchHash" || -z "$postPatchHash" ]]; then
    echo "Error: Failed to read hashes from $HASH_FILE."
    exit 1
fi

# Calculate current hash
currentHash=$(sha256sum "$DATA_FILE" | awk '{print $1}')
backupHash=""

echo "Current SHA256: $currentHash"

# Check if already patched
if [[ "$currentHash" == "$postPatchHash" ]]; then
    echo "Patch is already installed."
    exit 0
fi

# Try to use data.win.old instead if data.win didn't match the expected hash
if [[ "$currentHash" != "$prePatchHash" ]]; then
	DATA_FILE="$(GAME_DIR)/old.data.win"
	if [[ -f "$BACKUP_FILE" ]]; then
		backupHash=$(sha256sum "$BACKUP_FILE" | awk '{print $1}')
	fi		
fi

# Fail with error if a data file matching the expected pre-patch hash wasnt found
if [[ "$currentHash" != "$prePatchHash" && "$backupHash" != "$prePatchHash" ]]; then	
    echo "Error: Dark Deity version mismatch."
    echo "Expected pre-patch hash:  $prePatchHash"
    echo "Expected post-patch hash: $postPatchHash"
    echo "Current:                  $currentHash"
	if [[ -f "$BACKUP_FILE" ]]; then
    	echo "Backup:                   $backupHash"
    fi
	exit 1
fi

echo "Pre-patch hash verified."

# Apply patch
echo "Applying patch..."
"$PATCH_SCRIPT" -i

# Verify post-patch hash
newHash=$(sha256sum "$DATA_FILE" | awk '{print $1}')

echo "New SHA256: $newHash"

if [[ "$newHash" != "$postPatchHash" ]]; then
    echo "Error: Patch completed, but the resulting file hash is incorrect."
    echo "Expected: $postPatchHash"
    echo "Actual:   $newHash"
    exit 1
fi

echo "Patch applied successfully."
