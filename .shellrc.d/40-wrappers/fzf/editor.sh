#!/bin/bash

### fe [FUZZY PATTERN] - Open the selected file with the default editor

## Bypass fuzzy finder if there's only one match (--select-1)
## Exit if there's no match (--exit-0)

fe() {
  mapfile -t files < <(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview="bat --color=always {}")
  if [[ -n ${files[*]} ]]; then
    ${EDITOR:-vim} "${files[@]}"
  fi
}
