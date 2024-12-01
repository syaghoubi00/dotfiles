#!/bin/sh

if [ -d ~/.shellrc.d/80-bindings ]; then
  for rc in ~/.shellrc.d/80-bindings/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
