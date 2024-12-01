### https://wiki.archlinux.org/title/XDG_Base_Directory
### https://github.com/b3nj5m1n/xdg-ninja

## Ansible
export ANSIBLE_HOME="${XDG_CONFIG_HOME}/ansible"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible.cfg"
export ANSIBLE_GALAXY_CACHE_DIR="${XDG_CACHE_HOME}/ansible/galaxy_cache"

## Rust
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"

## Docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

## FFmpeg
export FFMPEG_DATADIR="${XDG_CONFIG_HOME}/ffmpeg"

## Go
export GOPATH="${XDG_DATA_HOME}/go"
export GOMODCACHE="${XDG_CACHE_HOME}/go/mod"

## IPFS
export IPFS_PATH="${XDG_DATA_HOME}/ipfs"

## Ripgrep
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

## Screen
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"

## wget
# export WGETRC="$XDG_CONFIG_HOME/wgetrc"
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"

## Kubernetes
export KUBECONFIG="${XDG_CONFIG_HOME}/kube"
export KUBECACHEDIR="${XDG_CACHE_HOME}/kube"
