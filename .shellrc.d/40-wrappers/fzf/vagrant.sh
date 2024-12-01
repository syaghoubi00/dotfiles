#!/bin/sh

if command -v vagrant >/dev/null 2>&1; then
  ## List all vagrant boxes available in the system including its status, and try to access the selected one via ssh
  vs() {
    cd "$(jq '.machines[] < ~/.vagrant.d/data/machine-index/index | {name, vagrantfile_path, state}' | jq '.name + "," + .state  + "," + .vagrantfile_path' | sed 's/^"\(.*\)"$/\1/' | column -s, -t | sort -rk 2 | fzf | awk '{print $3}')" || return 1
    vagrant ssh
  }
fi
