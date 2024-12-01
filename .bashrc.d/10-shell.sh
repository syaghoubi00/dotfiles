#!/bin/sh

if [ -d ./10-shell ]; then
  for rc in ./10-shell/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
