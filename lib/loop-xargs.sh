#!/usr/bin/env bash

##
# loopReposXargs
# $1  containing output directory
# $2  github organization
# $3  list of repos
# stdout  pullOrCloneRepo output all jumbled up since xargs doesn't keep track of it
function loopReposXargs {
  local output_dir
  local org
  local repos
  output_dir=$1
  org=$2
  repos=$3
  export output_dir org
  echo "$repos" | xargs -I {} -n 1 -P 0 bash -c 'pullOrCloneRepo "$output_dir" "$org" "$@"' _ {}
}
