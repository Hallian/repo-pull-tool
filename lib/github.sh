#!/usr/bin/env bash

# Public: Fetch a list of repositories for an organization from GitHub API
#
# Calls GitHub api with curl and parses the name field from the response.
# It will then parse the "next" link from the Link header and if present
# will increment the page number and go to the next page.
# TODO: IMPROVEMENT: Actually use the next link value instead of just
# incrementing the previous page number.
#
# $1 - github token
# $2 - github organization name
# $3 - request page
# $4 - return repository name only, true/false
# $5 - number of repos per request page
#
# Outputs list of organization repositories
function getReposGithubOrg() {
  githubReposRequest $1 orgs $2 $3 $4 $5
}
export -f getReposGithubOrg

function getReposGithubUser() {
  githubReposRequest $1 users $2 $3 $4 $5
}
export -f getReposGithubUser

function githubReposRequest() {
  local github_token=$1
  local type=$2
  local name=$3
  local page=${4:-1}
  local per_page=${5:-25}
  local name_only=${6:-false}
  local response
  local headers
  local body
  response=$(curl -i -u :"$github_token" -s "https://api.github.com/$type/$name/repos?per_page=$per_page&page=$page")
  headers=$(getHeaders "$response")
  body=$(getBody "$response")
  nextLink=$(getNextPageLink "$headers")

  # Hack: sed to fix mysterious appearance of a carriage return on windows
  if [[ $name_only == true ]]; then
    echo "$body" | jq -r '.[]|.name' | sed 's|\r||g'
  else
    echo "$body" | jq -r '.[]|.name + "\t" + .ssh_url' | sed 's|\r||g'
  fi

  if [ -n "$nextLink" ]; then
    getReposGithubOrg "$github_token" "$name" $((page + 1))
  fi
}

# Public: Check the existence of $GITHUB_TOKEN
#
# Side effects: Value of $GITHUB_TOKEN comes from outside of function scope
function checkGithubToken() {
  if [ -z "$GITHUB_TOKEN" ]; then
    echo "No GITHUB_TOKEN found! Specify one in ~/.bashrc for example."
    exit 1
  fi
}
