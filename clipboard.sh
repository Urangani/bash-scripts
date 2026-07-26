#!/usr/bin/env bash

# Universal clipboard helper for Linux
# Usage:
#   ./clipboard.sh copy   < input.txt
#   ./clipboard.sh paste

action="$1"

case "$action" in
  copy)
    if command -v xclip &>/dev/null; then
      xclip -selection clipboard
    elif command -v xsel &>/dev/null; then
      xsel --clipboard --input
    else
      echo "No clipboard utility found. Install xclip or xsel."
      exit 1
    fi
    ;;
  paste)
    if command -v xclip &>/dev/null; then
      xclip -selection clipboard -o
    elif command -v xsel &>/dev/null; then
      xsel --clipboard --output
    else
      echo "No clipboard utility found. Install xclip or xsel."
      exit 1
    fi
    ;;
  *)
    echo "Usage: $0 {copy|paste}"
    exit 1
    ;;
esac
