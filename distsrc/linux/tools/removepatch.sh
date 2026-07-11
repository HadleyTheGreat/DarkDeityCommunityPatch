#/usr/bin/env bash
# This script completely removes the Dark Deity community patch.
# Afterwards, it removes the removal script itself, so there are no remnants.

# Get the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$BASE_DIR\data.win" ]]; then
    if [[ -f "$BASE_DIR\data.win.old" ]]; then
        echo "--- Removing data.win ---"
        rm "$BASE_DIR\data.win"
        echo "--- Renaming data.win.old to data.win ---"
        mv "$BASE_DIR\data.win.old" "$BASE_DIR\data.win"
    else
        echo "There is no data.win.old file."
        echo "The patch appears to have been uinstalled already."
    fi
    echo "--- Cleaning up the removal script ---"
    self=$(realpath "${BASH_SOURCE[0]}")
    rm -- "$self"
    echo -e "\033[32mPatch has been successfully removed.\033[0m"
    pause
    exit
fi
echo "This batch file is an uninstaller for the Dark Deity community patch."
echo "It is meant to be copied into the Dark Deity folder automatically"
echo "when installing the patch with the patchtool, then run from inside"
echo "that folder to uninstall.  Its not intended to run from here."
pause
