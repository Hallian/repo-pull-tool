#!/usr/bin/env bash

##
# loopReposParallel
# $1  containing output directory
# $2  github organization
# $3  list of repos
# stdout  pullOrCloneRepo output
function loopReposParallel {
  local output_dir
  local org
  local repos
  output_dir=$1
  org=$2
  repos=$3
  parallel -j 0 pullOrCloneRepo "$output_dir" "$org" ::: $repos
}
