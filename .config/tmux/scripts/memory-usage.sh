#!/bin/sh

if [ -x "$(command -v free)" ]; then
  free | awk -v format="%3.1f%%" '$1 ~ /Mem/ {printf(format, 100*$3/$2)}'
fi
