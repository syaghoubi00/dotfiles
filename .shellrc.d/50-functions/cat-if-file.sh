#!/bin/sh

cif() {
  if [ -f "$1" ]; then
    if command -v bat >/dev/null 2>&1; then
      bat -p "$1"
    else
      cat "$1"
    fi
  elif [ -d "$1" ]; then
    ls "$1"
  else
    echo "Not a file or directory"
  fi
}
