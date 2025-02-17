#!/bin/sh

### Add syntax highlighting to tailing logs
if command -v bat >/dev/null 2>&1; then
  batlog() {
    tail -f "$@" | bat --paging=never -l log
  }
fi
