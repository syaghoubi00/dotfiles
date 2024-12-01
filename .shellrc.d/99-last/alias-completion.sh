#!/bin/bash

### https://github.com/cykerway/complete-alias
### wget -O ~/bin/complete_alias.sh https://raw.githubusercontent.com/cykerway/complete-alias/master/complete_alias

## NOTE: Add method to fetch script if not present?
## it doesnt need to be run every time, so a single init script?

if [[ -f ~/bin/complete_alias.sh && "$SHELL" =~ bash ]]; then
  ## Source complete_alias
  source ~/bin/complete_alias.sh

  ## Complete all aliases
  complete -F _complete_alias "${!BASH_ALIASES[@]}"
fi
