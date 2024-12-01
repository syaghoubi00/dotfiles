#!/bin/sh

### Display help menus with bat
if command -v bat >/dev/null 2>&1; then
  help() {
    "$@" --help 2>&1 | bat --plain --language=help
  }
fi
