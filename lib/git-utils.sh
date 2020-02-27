#!/usr/bin/env bash

# Public: Pull git repository.
#
# Changes to the supplied git directory, checks out the master branch
# and pulls the repository.
#
# $1 - path to repository
#
# Outputs git pull output
function pullRepo() {
  local repo_path
  repo_path=$1

  echo "-- Pulling $repo_path"
  cd "$repo_path" || return
  git checkout master
  git pull
}

# Public: Clones a git repository
#
# Clone a git repository to a containing directory.
#
# $1 - repository name
# $2 - repository ssh_url
# $3 - target containing directory path
#
# Outputs git clone output
function cloneRepo() {
  local repo_name
  local ssh_url
  local git_output_path
  repo_name=$1
  ssh_url=$2
  git_output_path=$3
  echo "-- Cloning $repo_name"
  git clone "$ssh_url" "$git_output_path/$repo_name"
}

# Public: Pulls or clones a git repository
#
# $1 - containing output directory, e.g. `~/workspace`
# $2 - github organization
# $3 - repository name
#
# Outputs pullRepo or cloneRepo output
function pullOrCloneRepo() {
  local output_dir=$1
  local org=$2
  local repo_name=$3
  if [ -d "$output_dir/$repo_name" ]; then
    pullRepo "$output_dir/$repo_name"
  else
    cloneRepo "$repo_name" "git@github.com:$org/$repo_name.git" "$output_dir"
  fi
}

# Public: Filters repositories (or input lines rather) with regex
#
# Takes a list of filters and list of repositories. Filters are
# added to a grep command as multiple -e regex options.
#
# $1 - list of filters in grep regex, e.g. "^project1- ^project7-"
# $2 - list of repos
#
# Outputs list of repos filtered with grep
function filterRepos() {
  local filters=$1
  local repos=$2
  local grep="grep"
  for filter in $filters; do
    grep="$grep -e $filter"
  done
  echo "$repos" | $grep
}
export -f filterRepos
