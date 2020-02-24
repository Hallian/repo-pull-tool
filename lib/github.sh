#!/usr/bin/env bash

##
# getReposGithubOrg
# $1  github token
# $2  github organization name
# $3  request page
# $4  return repository name only, true/false
# $5  number of repos per request page
# Calls GitHub api with curl and parses the name field from the response.
# It will then parse the "next" link from the Link header and if present
# will increment the page number and go to the next page.
# TODO: IMPROVEMENT: Actually use the next link value instead of just
# incrementing the previous page number.
# stdout  list of organization repositories
function getReposGithubOrg {
  local github_token=$1
  local org=$2
  local page=${3:-1}
  local per_page=${4:-25}
  local name_only=${5:-false}
  local response
  local headers
  local body
  response=$(curl -i -u :"$github_token" -s "https://api.github.com/orgs/$org/repos?per_page=$per_page&page=$page")
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
    getReposGithubOrg "$github_token" "$org" $((page + 1))
  fi
}
export -f getReposGithubOrg
