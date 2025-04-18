#!/usr/bin/bash

### Interactively Install, Remove, Upgrade and Fuzzy search DNF packages using fzf

fdnf() {
  readonly basename="$(basename "$0")"

  if ! hash fzf &>/dev/null; then
    printf 'Error: Missing dep: fzf is required to use %s.\n' "${basename}" >&2
    exit 64
  fi

  #Colors
  declare -r esc=$'\033'
  declare -r BLUE="${esc}[1m${esc}[34m"
  declare -r RED="${esc}[31m"
  declare -r GREEN="${esc}[32m"
  declare -r YELLOW="${esc}[33m"
  declare -r CYAN="${esc}[36m"
  # Base commands
  readonly QRY="dnf --cacheonly --quiet repoquery "
  readonly PRVW="dnf --cacheonly --quiet --color=always info"
  readonly QRY_PRFX='  '
  readonly QRY_SFFX=' > '
  # Install mode
  readonly INS_QRYS="${QRY} --qf '${CYAN}%{name}'"
  readonly INS_PRVW="${PRVW}"
  readonly INS_PRMPT="${CYAN}${QRY_PRFX}Install packages${QRY_SFFX}"
  # Remove mode
  readonly RMV_QRYS="${QRY} --installed --qf '${RED}%{name}'"
  readonly RMV_PRVW="${PRVW} --installed"
  readonly RMV_PRMPT="${RED}${QRY_PRFX}Remove packages${QRY_SFFX}"
  # Remove-userinstalled mode
  readonly RUI_QRYS="${QRY} --userinstalled --qf '${YELLOW}%{name}'"
  readonly RUI_PRVW="${PRVW} --installed"
  readonly RUI_PRMPT="${YELLOW}${QRY_PRFX}Remove User-Installed${QRY_SFFX}"
  # Updates mode
  readonly UPD_QRY="${QRY} --upgrades --qf '${GREEN}%{name}'"
  readonly UPD_QRYS="if [[ $(${UPD_QRY} | wc -c) -ne 0 ]]; then ${UPD_QRY}; else echo ${GREEN}No updates available.; echo Try refreshing metadata cache...; fi"
  readonly UPD_PRVW="${PRVW}"
  readonly UPD_PRMPT="${GREEN}${QRY_PRFX}Upgrade packages${QRY_SFFX}"

  mapfile -d '' fhelp <<-EOF

          "${basename}"
          Interactive package manager for Fedora

          Alt-i       Install mode (default)
          Alt-r       Remove mode
          Alt-e       Remove User-Installed mode
          Alt-u       Updates mode
          Alt-m       Update package metadata cache

          Enter       Confirm selection
          Tab         Mark package ()
          Shift-Tab   Unmark package
          Ctrl-a      Select all

          ?           Help (this page)
          ESC         Quit
EOF

  declare tmp_file
  if tmp_file="$(mktemp --tmpdir "${basename}".XXXXXX)"; then
    printf 'in' >"${tmp_file}" &&
      SHELL='/bin/bash' \
        FZF_DEFAULT_COMMAND="${INS_QRYS}" \
        fzf \
        --ansi \
        --multi \
        --query=$* \
        --header=" ${basename} | Press Alt+? for help or ESC to quit" \
        --header-first \
        --prompt="${INS_PRMPT}" \
        --marker=' ' \
        --preview-window='right,67%,wrap' \
        --preview="${INS_PRVW} {1}" \
        --bind="enter:execute(if grep -q 'in' \"${tmp_file}\"; then sudo dnf install {+};
          elif grep -q 'rm' \"${tmp_file}\"; then sudo dnf remove {+}; \
          elif grep -q 'up' \"${tmp_file}\"; then sudo dnf upgrade {+}; fi; \
          read -s -r -n1 -p $'\n${BLUE}Press any key to continue...' && printf '\n')" \
        --bind="alt-i:unbind(alt-i)+reload(${INS_QRYS})+change-preview(${INS_PRVW} {1})+change-prompt(${INS_PRMPT})+execute-silent(printf 'in' > \"${tmp_file}\")+first+rebind(alt-r,alt-e,alt-u)" \
        --bind="alt-r:unbind(alt-r)+reload(${RMV_QRYS})+change-preview(${RMV_PRVW} {1})+change-prompt(${RMV_PRMPT})+execute-silent(printf 'rm' > \"${tmp_file}\")+first+rebind(alt-i,alt-e,alt-u)" \
        --bind="alt-e:unbind(alt-e)+reload(${RUI_QRYS})+change-preview(${RUI_PRVW} {1})+change-prompt(${RUI_PRMPT})+execute-silent(printf 'rm' > \"${tmp_file}\")+first+rebind(alt-i,alt-r,alt-u)" \
        --bind="alt-u:unbind(alt-u)+reload(${UPD_QRYS})+change-preview(${UPD_PRVW} {1})+change-prompt(${UPD_PRMPT})+execute-silent(printf 'up' > \"${tmp_file}\")+first+rebind(alt-i,alt-r,alt-e)" \
        --bind="alt-m:execute(sudo dnf makecache;read -s -r -n1 -p $'\n${BLUE}Press any key to continue...' && printf '\n')" \
        --bind="alt-?:preview(printf \"${fhelp[0]}\")" \
        --bind="ctrl-a:select-all"

    rm -f "${tmp_file}" &>/dev/null
  else
    printf 'Error: Failed to create tmp file. $TMPDIR (or /tmp if $TMPDIR is unset) may not be writable.\n' >&2
    exit 65
  fi
}
