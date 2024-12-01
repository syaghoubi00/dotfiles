#!/bin/sh

if [ -d ~/.shellrc.d/50-functions ]; then
  for rc in ~/.shellrc.d/50-functions/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
