#!/usr/bin/env bash

### Podman + fzf

if command -v podman &>/dev/null; then
  ## Select a podman container to start and attach to
  function fpa() {
    local cid
    cid=$(podman ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

    [ "$cid" != "" ] && podman start "$cid" && podman attach "$cid"
  }

  ## Select a running podman container to stop
  function fps() {
    local cid
    cid=$(podman ps | sed 1d | fzf -q "$1" | awk '{print $1}')

    [ "$cid" != "" ] && podman stop "$cid"
  }

  ## Same as above, but allows multi selection:
  function fprm() {
    podman ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r podman rm
  }

  ## Select a podman image or images to remove
  function fprmi() {
    podman images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r podman rmi
  }

  ## exec into a container
  fpex() {
    local ctr
    ctr=$(podman ps | sed 1d | fzf -q "$1" | awk '{ print $1 }')
    podman exec -it "$ctr" sh
  }
fi
