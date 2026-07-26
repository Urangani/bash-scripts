#!/bin/bash
# Usage: ./check-app.sh <app-name>
APP=$1

echo "Checking package managers for: $APP"

# Check APT/Deb
if dpkg -l | grep -qw "$APP"; then
    echo "✅ Found in APT/Deb (dpkg)"
    apt show "$APP" 2>/dev/null | grep -E 'Package|Version|Installed-Size'
fi

# Check Snap
if snap list | grep -qw "$APP"; then
    echo "✅ Found in Snap"
    snap info "$APP" | grep -E 'name|version|publisher'
fi

# Check Flatpak
if flatpak list | grep -qw "$APP"; then
    echo "✅ Found in Flatpak"
    flatpak info "$APP" 2>/dev/null | grep -E 'ID|Version|Origin'
fi

# Check AppImage (manual check)
if [ -f "$APP" ] && [[ "$APP" == *.AppImage ]]; then
    echo "✅ Found as AppImage file"
else
    echo "ℹ️ No AppImage detected (check manually if you downloaded one)"
fi

