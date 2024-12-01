#!/bin/sh

if [ -d ~/.shellrc.d/99-last ]; then
  for rc in ~/.shellrc.d/99-last/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
