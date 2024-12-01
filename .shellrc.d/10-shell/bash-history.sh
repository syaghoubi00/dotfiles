#!/bin/bash

## Append to HISTFILE instead of overwriting
shopt -s histappend

## Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

## Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

## Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

### Use standard ISO 8601 timestamp
## %F equivalent to %Y-%m-%d
## %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

### Keep history in sync across multiple terminals
## Append history, clear history in memory to prevent duplicates, reload history
## (Push to PROMPT_COMMAND array)
PROMPT_COMMAND+=('history -a; history -c; history -r')
