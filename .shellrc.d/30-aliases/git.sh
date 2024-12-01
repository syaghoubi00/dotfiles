#!/bin/sh

if command -v git >/dev/null 2>&1; then
  alias gs="git status"
  alias gd="git diff"
  alias ga="git add"
  alias gc="git commit"
fi
