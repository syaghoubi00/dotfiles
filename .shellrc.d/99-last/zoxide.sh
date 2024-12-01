#!/bin/bash

if command -v zoxide &>/dev/null; then
  if [[ "$SHELL" =~ bash ]]; then
    eval "$(zoxide init bash)"
  fi
fi
