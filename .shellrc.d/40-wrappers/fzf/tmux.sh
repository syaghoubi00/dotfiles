#!/bin/bash

if command -v fzf &>/dev/null && command -v tmux &>/dev/null; then
  # ftm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
  # `ftm` will allow you to select your tmux session via fzf.
  # `ftm irc` will attach to the irc session (if it exists), else it will create it.

  ftm() {
    [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
    if [ "$1" ]; then
      tmux "$change" -t "$1" 2>/dev/null || (tmux new-session -d -s "$1" && tmux "$change" -t "$1")
      return
    fi

    # tmux_short_format="#S:#I.#P: #W - #T"
    tmux_format="#{session_name}:#{window_index}.#{pane_index}: #{window_name} - #{pane_title}"
    fzf_opts=(--no-multi --cycle --tmux --border-label="╢ tmux switcher ╟" --exit-0)

    set -o pipefail
    selection=$(tmux list-panes -a -F "$tmux_format" 2>/dev/null | fzf "${fzf_opts[@]}" | cut -d ":" -f 1-2)
    ## save exit code from fzf to return from 130 if exited without a selection in fzf
    selection_exit_code=$?

    if [[ $selection_exit_code == 0 && -n "$selection" ]]; then
      tmux "$change" -t "$selection"
    elif [[ $selection_exit_code == 130 ]]; then
      return
    else
      echo "No tmux sessions available (create one with 'ftm your-session-name')"
    fi
  }
fi
