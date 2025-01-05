#!/bin/sh

if command -v git >/dev/null 2>&1; then
  alias gc="git commit"
  alias gl="git log --abbrev-commit"
  alias glg="git log --oneline --graph"

  ## git status
  alias gs="git status"
  alias gss="git status --short --untracked-files=no"   # status of staged/unstaged files
  alias gsd="git status --verbose --untracked-files=no" # status with diff

  ## git diff
  alias gd="git diff"           # diff of unstaged changes
  alias gds="git diff --staged" # diff of staged changes

  ## git add
  alias ga="git add"
  alias gau="git add --update"      # stages all modified and deleted tracked files.
  alias gai="git add --interactive" # interactive file picker

  ## git ls-files
  alias gls="git ls-files"                              # list tracked files
  alias glsu="git ls-files --others --exclude-standard" # list untracked files, respecting .gitignore
fi
