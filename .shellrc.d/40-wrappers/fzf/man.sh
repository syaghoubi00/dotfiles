#!/usr/bin/env bash

### Quickly display a man page using fzf and fd.
## MANPATH has to be set to a single directory (usually /usr/share/man).
## Accepts an optional argument for the manual section (defaults to 1).

man-find() {
  f=$(fd . /usr/share/man"${1:-1}" -t f -x echo {/.} | fzf) && man "$f"
}

fman() {
  man -k . | fzf -q "$1" --prompt='man> ' --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
# Get the colors in the opened man page itself
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANROFFOPT="-c"
