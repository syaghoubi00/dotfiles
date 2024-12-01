#!/bin/bash

if [[ $UID != 0 ]] && [[ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh

  ### Use ANSI escape sequences as testing showed it was much faster than tput
  RED_FG="\e[31m"
  GREEN_FG="\e[32m"
  ORANGE_FG="\e[33m"
  BLUE_FG="\e[34m"
  PURPLE_FG="\e[35m"
  TEAL_FG="\e[36m"

  RESET_STYLE_ATTR="\e[0m"

  git_prompt() {
    GIT_PS1_SHOWDIRTYSTATE="true"
    GIT_PS1_SHOWSTASHSTATE="true"
    GIT_PS1_SHOWUNTRACKEDFILES="true"
    GIT_PS1_SHOWUPSTREAM="auto,verbose,name"
    GIT_PS1_SHOWCONFLICTSTATE="yes"
    GIT_PS1_DESCRIBE_STYLE="default"
    GIT_PS1_SHOWCOLORHINTS="true"
    GIT_PS1_HIDE_IF_PWD_IGNORED="true"

    GIT_LOGO="$ORANGE_FG$RESET_STYLE_ATTR"

    __git_ps1 "$GIT_LOGO (%s)"
  }

  exit_status() {
    echo -e "$RED_FG${?#0}$RESET_STYLE_ATTR"
  }

  ## Push update window title command to PROMPT_COMMAND array
  PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')

  ## Unset current prompt, so items can be pushed to empty array
  PS1=""

  if [[ -f "/run/.toolboxenv" ]]; then
    # TOOLBOX_ICON="\e[38;5;129m  $RESET_STYLE_ATTR"
    TOOLBOX_ICON="$TEAL_FG $RESET_STYLE_ATTR"
    # TOOLBOX_ICON="$PURPLE_FG $RESET_STYLE_ATTR"

    toolbox_name() {
      grep -oP "(?<=name=\")[^\";]+" /run/.containerenv
    }

    PS1+="$TOOLBOX_ICON"

    # PS1+="$TOOLBOX_ICON $(toolbox_name) $RESET_STYLE_ATTR"

    ## cd to ~ to avoid /var/home/user when using ostree  NOTE: This will prevent retaining the $PATH you entered toolbox from
    ## Alternatively set $HOME equal to /var/home/user  NOTE: This may break some configs that use the $HOME path when moving to non rpm-ostree
    # cd ~ || return 1
    # declare HOME
    # HOME=/var/home/$(whoami)
  fi
  PS1+="\u@\h:"
  PS1+="[$BLUE_FG\w$RESET_STYLE_ATTR]"
  ## exit status must come before git_prompt, otherwise git_prompt exit code will be used
  PS1+=" \$(exit_status)"
  PS1+=" \$(git_prompt)"
  PS1+="\n"

elif [[ $UID == 0 ]]; then
  PS1=''
  ## Toolbox
  # PS1+='\[\e[31m\]\`is_toolbox\`\]\e[m\]\[\e[32m\]'
  ## user@hostname
  PS1+='\u@\h'
  ## [working dir]
  PS1+='[\w]'
  ## prompt sign (# if root)
  PS1+='$ '
  ## show return value of last command
  PS1+='\[\e[31;3m\]${?#0}\[\e[0m\]'
  ## enter commands on newline
  PS1+='\n'
else
  PS1='\u@\h[\W]$\n\[\e[31;3m\]${?#0}\[\e[0m\]'
fi
