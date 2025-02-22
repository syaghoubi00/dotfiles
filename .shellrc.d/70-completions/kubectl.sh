#!/bin/bash

if command -v kubectl &>/dev/null; then
  if [[ "$SHELL" =~ bash ]]; then
    source <(kubectl completion bash)
  fi
fi
