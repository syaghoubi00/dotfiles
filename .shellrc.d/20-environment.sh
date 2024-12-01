#!/bin/sh

if [ -d ./20-environment ]; then
  for rc in ./20-environment/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
