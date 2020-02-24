#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/lib/curl-utils.sh
source $DIR/lib/github.sh
source $DIR/lib/git-utils.sh
source $DIR/lib/loop-xargs.sh

export ORG=$1
GIT_OUTPUT_DIRECTORY=$2
export GIT_OUTPUT_DIRECTORY
FILTERS=$3

# Side effects: Value of $GITHUB_TOKEN comes from outside of function scope
function checkGithubToken {
  if [ -z "$GITHUB_TOKEN" ]; then
    echo "No GITHUB_TOKEN found! Specify one in ~/.bashrc for example."
    exit 1
  fi
}

function main {
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
