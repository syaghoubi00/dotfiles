#!/bin/sh

if command -v fzf >/dev/null 2>&1; then
  ## Use partial height to not use full terminal
  ## Use reverse layout for more natural tab/shift-tab selection
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

  ## use `fd` instead of `find`
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --follow --exclude cache'

  ## Colorscheme
  export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} \
    --color fg:white,hl:yellow,fg+:white,bg+:black,hl+:yellow \
    --color info:blue,prompt:grey,spinner:yellow,pointer:blue \
    --color marker:bright-yellow,header:grey \
    --color border:bold:blue,label:bold:blue"

  ## source bindings and autocomplete
  . /usr/share/fzf/shell/key-bindings.bash
fi
