#!/bin/bash

# Combined git commit browser with preview and graph options
fshow() {
  local preview_cmd="echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always --oneline %'"
  local copy_cmd="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
  local log_cmd="git log --color=always"

  # Add --graph flag if -g or --graph parameter is provided
  if [[ "$1" == "-g" ]] || [[ "$1" == "--graph" ]]; then
    log_cmd+=" --graph"
    shift
  fi

  # Add the common format string
  log_cmd+=" --format=\"%C(auto)%h%d %s %C(black)%C(bold)%cr%C(auto)%an\""

  # Add any remaining parameters
  [[ $# -gt 0 ]] && log_cmd+=" $*"

  eval "$log_cmd" |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
      --ansi --preview="$preview_cmd" \
      --header "enter:view, alt-y:copy hash, ctrl-s:toggle-sort" \
      --bind "enter:execute:$preview_cmd | less -R" \
      --bind "alt-y:execute:$copy_cmd | wl-copy" \
      --bind "ctrl-s:toggle-sort"
}
