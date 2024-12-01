#!/bin/sh

if [ -x "$(command -v sensors)" ]; then
  sensors | sed -e 's/^Tccd/Core /' | awk -v format="%2.0fC" '/^Core [0-9]+/ {gsub("[^0-9.]", "", $3); sum+=$3; n+=1} END {printf(format, sum/n)}'
fi
