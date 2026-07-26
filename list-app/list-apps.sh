#!/bin/bash

# Usage:
#   ./list_apps.sh             → full listing (categories + apps)
#   ./list_apps.sh categories  → categories only (with counts + total)
#   ./list_apps.sh Network     → filter by category "Network"

mode="$1"
declare -A apps

# Collect apps and their categories
for file in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do
    name=$(grep -m1 "^Name=" "$file" | cut -d= -f2)
    categories=$(grep -m1 "^Categories=" "$file" | cut -d= -f2 | tr ';' '\n')

    for category in $categories; do
        if [[ -z "$mode" || "$mode" == "categories" || "$category" == "$mode" ]]; then
            apps[$category]="${apps[$category]}$name\n"
        fi
    done
done

total=0
category_count=$(printf "%s\n" "${!apps[@]}" | wc -l)

# If categories-only mode, print number of categories first
if [[ "$mode" == "categories" ]]; then
    printf "\033[1;36mTotal categories: %d\033[0m\n\n" "$category_count"
fi

# Sort categories first
for category in $(printf "%s\n" "${!apps[@]}" | sort); do
    count=$(echo -e "${apps[$category]}" | sort | uniq | wc -l)
    total=$((total + count))

    if [[ "$mode" == "categories" ]]; then
        # Categories only mode
        printf "\033[1;34m%s\033[0m (%d apps)\n" "$category" "$count"
    else
        # Full listing mode
        printf "\033[1;34m=== %s (%d apps) ===\033[0m\n" "$category" "$count"
        echo -e "${apps[$category]}" | sort | uniq
        echo
    fi
done

# Print grand total
printf "\n\033[1;32mTotal applications across all categories: %d\033[0m\n" "$total"
