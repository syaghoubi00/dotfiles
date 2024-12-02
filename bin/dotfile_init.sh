#!/bin/sh

### Fetch external items that aren't contained in the repo

## Bash alias completion
wget -O ~/bin/complete_alias.sh https://raw.githubusercontent.com/cykerway/complete-alias/refs/heads/master/complete_alias

## Sway autotiling
wget -O ~/bin/sway-autotiling.py https://raw.githubusercontent.com/nwg-piotr/autotiling/refs/heads/master/autotiling/main.py

## Fonts
## unzip can't process files from stdin, so create tmp
tmp_dir=$(mktemp -d)
tmp_path="$tmp_dir"/nerdfont.zip
wget -qO "$tmp_path" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -d ~/.local/share/fonts/nerdfonts/JetBrainsMono "$tmp_path"
rm "$tmp_path"
