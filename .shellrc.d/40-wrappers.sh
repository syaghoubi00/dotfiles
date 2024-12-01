#!/bin/sh

if [ -d ~/.shellrc.d/40-wrappers ]; then
  for rc in ~/.shellrc.d/40-wrappers/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
