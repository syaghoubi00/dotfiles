#!/bin/sh

## Create a temporary directory and change into it
tmp() {
  cd "$(mktemp -d)" || return 1
}
