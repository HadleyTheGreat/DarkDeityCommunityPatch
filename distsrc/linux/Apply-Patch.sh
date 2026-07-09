#!/usr/bin/env bash

set -euo pipefail

DATA_FILE="data.win"
HASH_FILE="hashes.csv"
PATCH_SCRIPT="./apply_patch"

# Ensure required files exist
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

echo "Current SHA256: $currentHash"

# Check if already patched
if [[ "$currentHash" == "$postPatchHash" ]]; then
    echo "Patch is already installed."
    exit 0
fi

# Verify pre-patch hash
if [[ "$currentHash" != "$prePatchHash" ]]; then
    echo "Error: $DATA_FILE is not in a recognized state."
    echo "Expected pre-patch:  $prePatchHash"
    echo "Expected post-patch: $postPatchHash"
    echo "Actual:              $currentHash"
    exit 1
fi

echo "Pre-patch hash verified."

# Apply patch
echo "Applying patch..."
"$PATCH_SCRIPT"

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
