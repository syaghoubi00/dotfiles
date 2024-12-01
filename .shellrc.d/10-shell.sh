#!/bin/sh

if [ -d ~/.shellrc.d/10-shell ]; then
  for rc in ~/.shellrc.d/10-shell/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
