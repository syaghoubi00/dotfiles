#!/bin/sh

if [ -d ~/.shellrc.d/30-aliases/ ]; then
  for rc in ~/.shellrc.d/30-aliases/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
