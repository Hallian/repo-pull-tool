#!/usr/bin/env bash

# Public: Run pullOrCloneRepo for a list of repos using parallel
#
# $1 - containing output directory
# $2 - github organization
# $3 - list of repos
#
# Outputs pullOrCloneRepo output
function loopReposParallel() {
  local output_dir
  local org
  local repos
  output_dir=$1
  org=$2
  repos=$3
  parallel -j 0 pullOrCloneRepo "$output_dir" "$org" ::: $repos
}
