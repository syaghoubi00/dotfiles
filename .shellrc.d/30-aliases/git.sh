#!/bin/sh

if command -v git >/dev/null 2>&1; then
  alias gs="git status"
  alias gd="git diff"

  ## git add
  alias ga="git add"
  alias gau="git add --update"      # stages all modified and deleted tracked files.
  alias gai="git add --interactive" # interactive file picker

  alias gc="git commit"

  ## git ls-files
  alias gls="git ls-files"                              # list tracked files
  alias glsu="git ls-files --others --exclude-standard" # list untracked files, respecting .gitignore
fi
