#/usr/bin/env bash
# This script completely removes the Dark Deity community patch.
# Afterwards, it removes the removal script itself, so there are no remnants.

# Get the directory where the script is located
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$BASE_DIR\data.win.old" ]]; then
	if [[ -f "$BASE_DIR\data.win" ]]; then
		echo "--- Removing data.win ---"
		rm "$BASE_DIR\data.win"
	fi
	echo "--- Renaming data.win.old to data.win ---"
	mv "$BASE_DIR\data.win.old" "$BASE_DIR\data.win"
fi

echo "--- Cleaning up removal script ---"
rm removepatch.sh
echo -e "\033[32mPatch has been successfully removed.\033[0m"
