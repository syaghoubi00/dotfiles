#!/bin/sh

if [ -x "$(command -v iostat)" ]; then
  cpu_percentage_format="%3.1f%%"

  iostat -c 1 2 | sed '/^\s*$/d' | tail -n 1 | awk -v format="$cpu_percentage_format" '{usage=100-$NF} END {printf(format, usage)}' | sed 's/,/./'
  sleep 2
fi
