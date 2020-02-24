#!/usr/bin/env bash

##
# pullRepo
# $1  path to repository
# stdout  git pull output
function pullRepo {
  local repo_path
  repo_path=$1

  echo "-- Pulling $repo_path"
  cd "$repo_path" || return
  git checkout master
  git pull
}

##
# cloneRepo
# $1  repository name
# $2  repository ssh_url
# $3  target containing directory path
# stdout  git clone output
function cloneRepo {
  local repo_name
  local ssh_url
  local git_output_path
  repo_name=$1
  ssh_url=$2
  git_output_path=$3
  echo "-- Cloning $repo_name"
  git clone "$ssh_url" "$git_output_path/$repo_name"
}

##
# pullOrCloneRepo
# $1  containing output directory, e.g. ~/workspace
# $2  github organization
# $3  repository name
# stdout  pullRepo or cloneRepo output
function pullOrCloneRepo {
  local output_dir=$1
  local org=$2
  local repo_name=$3
  if [ -d "$output_dir/$repo_name" ]; then
    pullRepo "$output_dir/$repo_name"
  else
    cloneRepo "$repo_name" "git@github.com:$org/$repo_name.git" "$output_dir"
  fi
}

##
# filterRepos
# $1  list of filters in grep regex, e.g. "^project1- ^project7-"
# $2  list of repos
# Takes a list of filters and list of repositories. Filters are
# added to a grep command as multiple -e regex options.
# stdout  list of repos filtered with grep
function filterRepos {
  local filters=$1
  local repos=$2
  local grep="grep"
  for filter in $filters; do
    grep="$grep -e $filter"
  done
  echo "$repos" | $grep
}
export -f filterRepos
