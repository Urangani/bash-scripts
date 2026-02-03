#!/bin/bash

# Optional: pass a category name as an argument to filter
filter_category="$1"

declare -A apps

# Collect apps and their categories
for file in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do
    name=$(grep -m1 "^Name=" "$file" | cut -d= -f2)
    categories=$(grep -m1 "^Categories=" "$file" | cut -d= -f2 | tr ';' '\n')

    for category in $categories; do
        if [[ -z "$filter_category" || "$category" == "$filter_category" ]]; then
            apps[$category]="${apps[$category]}$name\n"
        fi
    done
done

# Sort categories first, then apps inside each category
for category in $(printf "%s\n" "${!apps[@]}" | sort); do
    printf "\033[1;34m=== %s ===\033[0m\n" "$category"
    echo -e "${apps[$category]}" | sort | uniq
    echo
done
