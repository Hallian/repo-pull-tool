#!/usr/bin/env bash

# Public: Get body from curl -i output
#
# Removes carriage returns with sed due to curl sometimes returning those
# Removes everthing before the first empty line with sed.
#
# $1 - curl -i output
#
# Outputs curl response body
function getBody() {
  local response=$1
  echo -n "$response" | sed 's|\r$||g' | sed '1,/^$/d'
}
export -f getBody

# Public: Get headers from curl -i output
#
# Removes carriage returns with sed due to curl sometimes returning those
# Removes everthing after the first empty line with sed.
#
# $1 - curl -i output
#
# Outputs curl response headers
function getHeaders() {
  local response=$1
  echo -n "$response" | sed 's|\r$||g' | sed '/^$/,$d'
}
export -f getHeaders

HEADER_NEXT_REGEX="Link:.*(:?<([^<>]*)>); rel=\"next\""

# Public: Get next page link from curl headers.
#
# Parses the "next" page link from Link header.
#
# $1 - curl -i header output from getHeaders
#
# Outputs the parsed "next" http link
function getNextPageLink() {
  local headers=$1
  if [[ $headers =~ $HEADER_NEXT_REGEX ]]; then
    echo ${BASH_REMATCH[2]}
  fi
}
export -f getNextPageLink
