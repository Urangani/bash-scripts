#!/bin/bash

echo "Listing applications by category..."

for file in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do
    name=$(grep -m1 "^Name=" "$file" | cut -d= -f2)
    category=$(grep -m1 "^Categories=" "$file" | cut -d= -f2)
    echo "$category: $name"
done | sort
