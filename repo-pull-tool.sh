#!/usr/bin/env bash

set -e


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/lib/argbash.sh
source $DIR/lib/curl-utils.sh
source $DIR/lib/github.sh
source $DIR/lib/git-utils.sh
source $DIR/lib/loop-xargs.sh

export ORG=$_arg_github_org
GIT_OUTPUT_DIRECTORY=$_positionals
export GIT_OUTPUT_DIRECTORY
FILTERS=$_arg_filter

# Internal: main function
#
# Calls GitHub and pulls repos.
function main() {
  checkGithubToken
  REPOS=$(filterRepos "$FILTERS" "$(getReposGithubOrg "$GITHUB_TOKEN" "$ORG" 1 100 true)")
  export -f pullOrCloneRepo cloneRepo pullRepo
  loopReposXargs "$GIT_OUTPUT_DIRECTORY" "$ORG" "$REPOS"
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f checkGithubToken filterRepos pullOrCloneRepo cloneRepo pullRepo
else
  main
fi
