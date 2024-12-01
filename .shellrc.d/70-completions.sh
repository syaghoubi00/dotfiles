#!/bin/sh

if [ -d ~/.shellrc.d/70-completions ]; then
  for rc in ~/.shellrc.d/70-completions/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
