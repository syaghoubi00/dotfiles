# A Better `$SHELL` experience

Source this folder (`~/.shellrc.d/*.sh`) from your shell configuration file:

```sh
if [ -d ~/.shellrc.d ]; then
  for rc in ~/.shellrc.d/*.sh; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
  unset rc
fi
```

I tried to make as much as I could POSIX shell compliant with a generic
`#!/bin/sh` interpreter directive (shebang line). Functions using arrays use
`bash` (as those aren't a POSIX capability), which most other `$SHELL`'s will
be able to run.
