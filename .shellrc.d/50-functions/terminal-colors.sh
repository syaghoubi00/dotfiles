#!/bin/bash

: '
To see the full range of colors your terminal supports, you can use a simple loop with tput
(change setab to setaf for text foregrounds)
Inspired by https://wiki.archlinux.org/title/Bash/Prompt_customization#Colors
'

colors-tput() {
  bg-tput() {
    for color in {0..255}; do
      tput setab "$color"
      echo -n "$color "
    done
    tput sgr0
    echo
  }

  fg-tput() {
    for color in {0..255}; do
      tput setaf "$color"
      echo -n "$color "
    done
    tput sgr0
    echo
  }

  if [[ $1 == "bg" ]]; then
    bg-tput
  elif [[ $1 == "fg" ]]; then
    fg-tput
  else
    fg-tput
    bg-tput
  fi
}

colors-ansi() {
  reset_prompt() {
    echo -e "\e(B\e[m"
  }

  echo "Foreground Colors"
  echo -en "Standard:\n"
  for colors in {30..37}; do
    echo -en "\e[${colors}m$colors "
  done
  reset_prompt

  # high intensity colors
  echo -en "High Intensity:\n"
  for colors in {90..97}; do
    echo -en "\e[${colors}m$colors "
  done
  reset_prompt

  # 256 colors
  echo -en "256 Color:\n"
  for colors in {16..255}; do
    echo -en "\e[38;5;${colors}m$colors "
  done
  reset_prompt

  echo -e "\nBackground Colors"
  echo -en "Standard:\n"
  for C in {40..47}; do
    echo -en "\e[${C}m$C "
  done
  reset_prompt

  # high intensity colors
  echo -en "High Intensity:\n"
  for C in {100..107}; do
    echo -en "\e[${C}m$C "
  done
  reset_prompt

  # 256 colors
  echo -en "256 Color:\n"
  for C in {16..255}; do
    echo -en "\e[48;5;${C}m$C "
  done
  reset_prompt
}

colors-ansi-escape-codes() {
  for color in {0..255}; do
    printf "\\e[38;5;%sm%3s\\e[0m " "$color" "\\e[38;5;${color}m"
    if ! (((color + 1) % 8)); then
      echo
    fi
  done
}
