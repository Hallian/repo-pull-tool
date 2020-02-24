#!/usr/bin/env bash

##
# getBody
# $1  curl -i output
# Removes carriage returns with sed due to curl sometimes returning those
# Removes everthing before the first empty line with sed.
# stdout  curl response body
function getBody {
  local response=$1
  echo -n "$response" | sed 's|\r$||g' | sed '1,/^$/d'
}
export -f getBody

##
# getHeaders
# $1  curl -i output
# Removes carriage returns with sed due to curl sometimes returning those
# Removes everthing after the first empty line with sed.
# stdout  curl response headers
function getHeaders {
  local response=$1
  echo -n "$response" | sed 's|\r$||g' | sed '/^$/,$d'
}
export -f getHeaders

HEADER_NEXT_REGEX="Link:.*(:?<([^<>]*)>); rel=\"next\""

##
# getNextPageLink
# $1  curl -i header output from getHeaders
# Parses the "next" page link from Link header
# stdout  the parsed "next" http link
function getNextPageLink {
  local headers=$1
  if [[ $headers =~ $HEADER_NEXT_REGEX ]]; then
    echo ${BASH_REMATCH[2]}
  fi
}
export -f getNextPageLink
