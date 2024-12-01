#!/usr/bin/env bash

### Fuzzy cd

## fcd - 'fuzzy cd' to selected directory
fcd() {
  local dir
  dir=$(find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2>/dev/null | fzf +m) && cd "$dir" || return
}

## Another fuzzy cd - cd into the selected directory
## This one differs from the one above by only showing the sub directories and not -
##  showing the directories within those.
fds() {
  local dir
  dir=$(find ./* -maxdepth 0 -type d -print 2>/dev/null | fzf-tmux) && cd "$dir" || return
}

## fda - including hidden directories
fda() {
  local dir
  dir=$(find "${1:-.}" -type d 2>/dev/null | fzf +m) && cd "$dir" || return
}
