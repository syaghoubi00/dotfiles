#!/bin/sh

if [ -d ~/.shellrc.d.d/40-wrappers/fzf ]; then
  for rc in ~/.shellrc.d/40-wrappers/fzf/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
