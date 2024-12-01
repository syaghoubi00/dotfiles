#!/bin/sh

## Set default editor in order of preference
if [ -x nvim ]; then
  export EDITOR="/usr/bin/nvim"
elif [ -x vim ]; then
  export EDITOR="/usr/bin/vim"
elif [ -x nano ]; then
  export EDITOR="/usr/bin/nano"
elif [ -x vi ]; then
  export EDITOR="/usr/bin/vi"
fi
