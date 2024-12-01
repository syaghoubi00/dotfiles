#!/bin/sh

### Dotfile management using bare git repo
### From https://www.atlassian.com/git/tutorials/dotfiles

## Use alias so completion works
## TODO: fix function completion
alias dotetc='/usr/bin/git --git-dir=/etc/.etc/ --work-tree=/etc/'
# dotetc() {
#   /usr/bin/git --git-dir=/etc/.etc/ --work-tree=/etc/
# }

dotetc_ls() {
  if [ "$#" -eq 0 ]; then
    (
      cd /
      for i in $(dotetc ls-files); do
        echo -n "$(dotetc -c color.status=always status "$i" -s | sed "s#$i##")"
        echo -e "¬/$i¬\e[0;33m$(dotetc -c color.ui=always log -1 --format="%s" -- "$i")\e[0m"
      done
    ) | column -t --separator=¬ -T2
  else
    dotetc "$@"
  fi
}
