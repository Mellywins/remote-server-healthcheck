#!/bin/bash

# set -o errexit

main () {
  local url=$1

  if [[ -z "$url" ]]; then
    echo "ERROR:
  An URL must be provided.

  Usage: check-res <url>

Aborting.
    "
    exit 1
  fi

  print_header
  for i in `seq 1 20`; do
    make_request $url
  done
}

print_header () {
  echo "code,time_total,time_connect,time_appconnect,time_starttransfer,launch_time,exit_code">output.txt
}

make_request () {
  local url=$1
  currentTime=$(date "+%r")
  curl -k \
    --write-out "%{http_code},%{time_total},%{time_connect},%{time_appconnect},%{time_starttransfer}" \
    --silent \
    --output /dev/null \
    --max-time 5 \
    "$url">>output.txt
  echo ",$currentTime,$?">>output.txt
}

main "$@"