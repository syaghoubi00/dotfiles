#!/bin/sh

### like normal autojump when used with arguments but displays an fzf prompt when used without

fj() {
  preview_cmd="ls {2..}"
  if command -v exa >/dev/null 2>&1; then
    preview_cmd="exa -l {2}"
  fi

  if [ $# -eq 0 ]; then
    # cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')" || return 1
    cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -f2- | sed 's/^\s*//')" || return 1
  else
    cd "$(autojump "$@")" || return 1
  fi
}
