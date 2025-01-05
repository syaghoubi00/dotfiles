#!/bin/sh

if command -v yq >/dev/null 2>&1; then
  alias yamlsort="yq 'sort_keys(.)'"
  alias yamlsortrecursive="yq 'sort_keys(..)'"
  alias yamlsortreverse="yq 'to_entries | sort_by(.key) | reverse | from_entries'"
fi
