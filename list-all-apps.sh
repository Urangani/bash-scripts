#!/bin/bash
# Script: list-desktop-apps.sh
# Usage: ./list-desktop-apps.sh

echo "Listing all desktop applications..."

# Function to parse .desktop files
list_apps() {
    DIR=$1
    if [ -d "$DIR" ]; then
        for file in "$DIR"/*.desktop; do
            [ -e "$file" ] || continue
            NAME=$(grep -m1 "^Name=" "$file" | cut -d'=' -f2)
            EXEC=$(grep -m1 "^Exec=" "$file" | cut -d'=' -f2)
            echo "App: $NAME | Exec: $EXEC"
        done
    fi
}

# System-wide applications
list_apps /usr/share/applications

# User-specific applications
list_apps ~/.local/share/applications

