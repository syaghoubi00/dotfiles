#!/bin/sh

## Set default editor in order of preference
if [ -x "$(command -v nvim)" ]; then
  export EDITOR="/usr/bin/nvim"
elif [ -x "$(command -v vim)" ]; then
  export EDITOR="/usr/bin/vim"
elif [ -x "$(command -v vi)" ]; then
  export EDITOR="/usr/bin/vi"
elif [ -x "$(command -v nano)" ]; then
  export EDITOR="/usr/bin/nano"
fi
