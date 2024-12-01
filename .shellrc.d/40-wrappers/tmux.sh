#!/bin/sh

DEV_DIR="$HOME/devel"
DEV_SESSION_KEYWORD="dev"

if command -v tmux >/dev/null 2>&1; then
  tm() {
    ## If no arguments are given then create unnamed session, else create named session using first arg
    if [ $# -ne 1 ]; then
      tmux
    ## If creating a session with a keyword - then do custom action
    elif [ "$1" = "$DEV_SESSION_KEYWORD" ]; then
      if tmux has-session -t "$DEV_SESSION_KEYWORD" >/dev/null 2>&1; then
        tmux new-session -A -s "$DEV_SESSION_KEYWORD"
      else
        tmux new-session -d -s "$DEV_SESSION_KEYWORD"
        tmux send-keys -t "$DEV_SESSION_KEYWORD" "cd $DEV_DIR" C-m

        tmux new-window -t "$DEV_SESSION_KEYWORD" -n "editor"
        tmux send-keys -t "$DEV_SESSION_KEYWORD":editor "$EDITOR $DEV_DIR" C-m

        tmux attach-session -t "$DEV_SESSION_KEYWORD":0
      fi
    else
      ## create new tmux session or attach to it if it exists
      tmux new-session -A -s "$1"
    fi
  }
fi
