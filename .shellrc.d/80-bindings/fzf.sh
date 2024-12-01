#!/bin/bash

### Late Load Bindings (after all functions have been declared)

## HACK: Requires setting to unused keycode then calling that keycode with a newline
## Get unused numerical keycodes with `bind -p | grep self-insert`
## "\200" is an unused keycode bound to execute (-x) the ftm command
## "\et" corresponds to alt-e, which triggers the "\200" ftm binding and C-m (ctrl-m = newline)

if command -v ftm &>/dev/null; then
  bind -x '"\200":"ftm"'
  ## use alt-t (t for tmux) because ctrl-t is used by fzf
  bind '"\et":"\200\C-m"'
fi
