#!/bin/sh

## Check if you are in a toolbox container
is_toolbox() {
  if [ -f "/run/.toolboxenv" ]; then
    TOOLBOX_NAME=$(grep -oP "(?<=name=\")[^\";]+" /run/.containerenv)
    echo "[${HOSTNAME} ${TOOLBOX_NAME}]"
  else
    return 1
  fi
}
