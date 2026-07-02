#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status,
# treat unset variables as an error, and catch pipeline failures.
set -euo pipefail

# Script global variables
SCRIPT_NAME=$(basename "$0")

# Default install locations for Steam
STEAM_ROOTS=(
    "$HOME/.local/share/Steam"
    "$HOME/.steam/steam"
)

# Display usage instructions
usage() {
    cat << EOF
Installation folder locator for Steam games and applications
USAGE:
    ${SCRIPT_NAME} {steam appid}   - Returns the current install path

EOF
}

# Print version information
version() {
    echo "${SCRIPT_NAME} version ${VERSION}"
}

find_libraryfolders_vdf() {
    for root in "${STEAM_ROOTS[@]}"; do
        if [[ -f "$root/steamapps/libraryfolders.vdf" ]]; then
            echo "$root/steamapps/libraryfolders.vdf"
            return 0
        fi
    done
    return 1
}

get_library_paths() {
    local vdf="$1"

    # Extract all "path" entries
    grep -E '^[[:space:]]*"path"' "$vdf" |
    sed -E 's/.*"path"[[:space:]]*"([^"]+)".*/\1/' |
    sed 's#\\\\#/#g'
}

find_game_dir() {
    local appid="$1"
    local vdf

    vdf=$(find_libraryfolders_vdf) || {
        echo "Steam libraryfolders.vdf not found" >&2
        return 1
    }

    while IFS= read -r library; do
        local steamapps="$library/steamapps"
        local manifest="$steamapps/appmanifest_${appid}.acf"

        if [[ -f "$manifest" ]]; then
            installdir=$(grep '"installdir"' "$manifest" |
                sed -E 's/.*"installdir"[[:space:]]*"([^"]+)".*/\1/')

            if [[ -n "$installdir" ]]; then
                echo "$steamapps/common/$installdir"
                return 0
            fi
        fi
    done < <(get_library_paths "$vdf")

    return 1
}

# Main application logic
main() {
	if ! GAME_DIR=$(find_game_dir "$1"); then
    	echo "Couldn't locate a current install for Steam AppID $1"
    	exit 1
	fi
	
	echo "${GAME_DIR}"
	exit 0
	
}



# Parse command-line arguments safely
parse_params() {
	if [[ $# -ne 1 ]]; then
		usage
		exit 1
	fi
	
    case "$1" in
        -h|-?|/?|--help)
            usage
            exit 0
            ;;
        -*) 
            echo "Unrecognized command switch '$1'"
            usage >&2
            exit 1
            ;;
        *[!0-9]*)
        	echo "AppID is invalid.  It should be a positive integer."
        	exit 1
            ;;        
        "")
        	echo "AppID is invalid.  It should be a positive integer."
        	exit 1
            ;;        
    esac
}

# Script entry point
parse_params "$@"
main "$@"

