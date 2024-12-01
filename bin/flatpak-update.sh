#!/bin/bash

if [[ -x /usr/bin/flatpak ]]; then
  # flatpaks_updated=$(flatpak remote-ls --updates --columns=application)
  flatpaks_updated=$(flatpak remote-ls --updates --columns=name)

  if [[ -n ${flatpaks_updated} ]]; then
    flatpak update -y &&
      notify-send -u normal "Flatpak Updates Available - Updating" "$flatpaks_updated"
  else
    exit 0
  fi
else
  exit 0
fi
