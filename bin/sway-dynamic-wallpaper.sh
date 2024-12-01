#!/bin/sh

### Script for setting random wallpapers with swaybg

find_wallpapers() {
  find -O2 "$HOME"/Wallpapers/ -type f -regextype posix-extended -regex "[^\\s]+(.*?)\\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$"
}

set_random_sway_bg() {
  swaybg -i "$(find_wallpapers | shuf -n1)" -m fill &
}

## Kill existing swaybg instances
killall swaybg

## Set initial background
set_random_sway_bg

while true; do
  ## Get original instance of swaybg PID
  swaybg_pid=$(pidof swaybg)

  ## Change wallpaper every 10m
  sleep 10m

  ## Set new background
  set_random_sway_bg

  ## Sleep for 1s to allow for background to be set
  sleep 1

  ## Kill old swaybg
  ## (use for loop to fix bug where pid would change causing multiple pids)
  for i in $swaybg_pid; do
    kill "$i"
  done
done
