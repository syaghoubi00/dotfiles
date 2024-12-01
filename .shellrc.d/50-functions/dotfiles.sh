#!/bin/sh

### Dotfile management using bare git repo
### From https://www.atlassian.com/git/tutorials/dotfiles

DOTFILE_DIR="$HOME/.dotfiles"

## Use alias so completion works
## TODO: fix function completion
alias dotfile='/usr/bin/git --git-dir="$DOTFILE_DIR" --work-tree="$HOME"'
# dotfile() {
#   /usr/bin/git --git-dir="$DOTFILE_DIR" --work-tree="$HOME" "$@"
# }

dotfile_ls() {
  if [ "$#" -eq 0 ]; then
    (
      cd /
      for i in $(dotfile ls-files); do
        echo -n "$(dotfile -c color.status=always status "$i" -s | sed "s#$i##")"
        echo -e "¬/$i¬\e[0;33m$(dotfile -c color.ui=always log -1 --format="%s" -- "$i")\e[0m"
      done
    ) | column -t --separator=¬ -T2
  else
    dotfile "$@"
  fi
}
