#!/usr/bin/env bash

# Define ANSI color codes for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color (reset)

# Get the parent directory of where the script is located (equivalent to %~dp0..)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# Check if data.win exists in the base directory
if [ -f "$BASE_DIR/data.win" ]; then

    if [ -f "$BASE_DIR/patch/backup/data.win" ]; then
        echo "--- Removing data.win ---"
        rm -f "$BASE_DIR/data.win"
        
        echo "--- Renaming data.win.old to data.win ---"
        mv "$BASE_DIR/patch/backup/data.win" "$BASE_DIR/data.win"
    fi

    echo "--- Restoring previous version files from backup ---"

    # Copy contents of patch/backup into base directory (equivalent to robocopy /E)
    if [ -d "$BASE_DIR/patch/backup" ]; then
        cp -r "$BASE_DIR/patch/backup/." "$BASE_DIR/" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo -e "${RED}Copy failed.${NC}"
            exit 1
        fi
    fi

    echo "--- Deleting new files created by the patch ---"
    
    # Read addedfiles.txt line by line and remove listed files relative to BASE_DIR
    if [ -f "$BASE_DIR/patch/addedfiles.txt" ]; then
        # tr -d '\r' strips Windows CR line endings if addedfiles.txt came from Windows
        while IFS= read -r line || [ -n "$line" ]; do
            # Clean path string and handle empty lines
            file_to_remove=$(echo "$line" | tr -d '\r' | xargs)
            [ -z "$file_to_remove" ] && continue

            target_path="$BASE_DIR/$file_to_remove"

            if [ -e "$target_path" ]; then
                rm -rf "$target_path"
                echo "Deleted: $file_to_remove"
            else
                echo "Not found: $file_to_remove"
            fi
        done < "$BASE_DIR/patch/addedfiles.txt"
    fi

    cd "$BASE_DIR" || exit 1

    # Remove the patch directory
    rm -rf "$BASE_DIR/patch"

    echo -e "${GREEN}The patch has been successfully removed.${NC}"
    read -rp "Press Enter to exit..."
    exit 0
fi

echo "This script is an uninstaller for the Dark Deity community patch."
echo "It is meant to be copied into the Dark Deity/patch folder automatically"
echo "when installing the patch with the patchtool, then run from inside"
echo "that folder to uninstall. It is not intended to run from here."
read -rp "Press Enter to exit..."