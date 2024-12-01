#!/usr/bin/env bash

### Make all kubectl completion fzf
### Tested kubectl version `v1.23.6`

# BASH
if command -v kubectl &>/dev/null && [[ $SHELL =~ bash ]]; then
  command -v fzf >/dev/null 2>&1 && {
    source <(kubectl completion bash | sed 's#"${requestComp}" 2>/dev/null#"${requestComp}" 2>/dev/null | head -n -1 | fzf  --multi=0 #g')
  }
fi

# ZSH
if command -v kubectl &>/dev/null && [[ $SHELL =~ zsh ]]; then
  command -v fzf >/dev/null 2>&1 && {
    source <(kubectl completion zsh | sed 's#${requestComp} 2>/dev/null#${requestComp} 2>/dev/null | head -n -1 | fzf  --multi=0 #g')
  }
fi
