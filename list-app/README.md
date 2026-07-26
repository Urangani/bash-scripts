# Application Listing Script

## Overview
This Bash script lists all applications installed on your system by reading `.desktop` files from standard directories. It can display apps grouped by category, show category counts, and provide a grand total of applications.  

It supports three modes:
1. **Full listing** – categories + apps + totals  
2. **Categories-only** – just category names with app counts + totals  
3. **Filtered view** – apps from a specific category only  

---

## Usage

### 1. Full Listing
Run without arguments to see all categories, apps, and totals:

```bash
./list_apps.sh
```

**Output example:**
```
=== Network (2 apps) ===
Firefox Web Browser
Thunderbird Mail

=== Utility (3 apps) ===
Calculator
Text Editor
Disk Usage Analyzer

Total applications across all categories: 5
```

---

### 2. Categories-Only Mode
Run with the `categories` argument to see only category names and app counts, plus the number of categories at the start:

```bash
./list_apps.sh categories
```

**Output example:**
```
Total categories: 12

Network (2 apps)
Utility (3 apps)
Office (5 apps)
System (4 apps)

Total applications across all categories: 14
```

---

### 3. Filter by Category
Run with a category name to list only apps in that category:

```bash
./list_apps.sh Network
```

**Output example:**
```
=== Network (2 apps) ===
Firefox Web Browser
Thunderbird Mail

Total applications across all categories: 2
```

---

## Features
- Groups apps by category headers  
- Shows app counts per category  
- Removes duplicates (e.g., multiple “About” entries)  
- Displays a grand total of apps at the end  
- Categories-only mode shows the number of categories at the start  

---

## Notes
- The script reads `.desktop` files from:
  - `/usr/share/applications` (system-wide apps)  
  - `~/.local/share/applications` (user-specific apps)  
- Categories are defined by the `Categories=` field inside `.desktop` files.  
- Some categories may be desktop-environment-specific (e.g., `X-GNOME`, `X-XFCE`).  

---
This README makes the script self-explanatory for anyone who wants to use or adapt it.  


## TODO:

**“Quick Install” section** (e.g., how to copy the script, make it executable, and run it) so it’s beginner-friendlY