## Prompt if deleting more than 3 files at a time
alias rm='rm --interactive=once --preserve-root'

## Confirmation and verbosity
alias mv='mv --interactive --verbose'
alias cp='cp --interactive --verbose'
alias ln='ln --interactive'

## Parenting changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
