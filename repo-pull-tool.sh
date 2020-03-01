#!/usr/bin/env bash

set -e


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/lib/argbash.sh
source $DIR/lib/curl-utils.sh
source $DIR/lib/github.sh
source $DIR/lib/git-utils.sh
source $DIR/lib/loop-xargs.sh

# Internal: main function
#
# Calls GitHub and pulls repos.
function main() {
  local git_output_dir=$_positionals
  checkGithubToken
  REPOS=$(filterRepos "$_arg_filter" "$(getReposGithubOrg "$GITHUB_TOKEN" "$_arg_github_org" 1 100 true)")
  export -f pullOrCloneRepo cloneRepo pullRepo
  if [ $_arg_list_only = on ]; then
    echo -n "$REPOS"
    exit 0
  fi
  loopReposXargs "$git_output_dir" "$_arg_github_org" "$REPOS"
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f checkGithubToken filterRepos pullOrCloneRepo cloneRepo pullRepo
else
  main
fi
