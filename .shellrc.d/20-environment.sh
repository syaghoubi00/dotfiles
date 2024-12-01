#!/bin/sh

if [ -d ~/.shellrc.d/20-environment ]; then
  for rc in ~/.shellrc.d/20-environment/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
