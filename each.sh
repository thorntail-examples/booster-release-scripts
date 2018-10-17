#!/bin/bash

heading=$(printf '=%.0s' {1..30})

case "$1" in
  "-p")
    find . -maxdepth 1 -type d -not -name '.*' -name '*-redhat' -exec bash -c "echo -e '\033[1m$heading {} $heading\033[0m' && cd '{}' && $2" \;
    ;;
  "-c")
    find . -maxdepth 1 -type d -not -name '.*' -not -name '*-redhat' -exec bash -c "echo -e '\033[1m$heading {} $heading\033[0m' && cd '{}' && $2" \;
    ;;
  *)
    echo "usage: each.sh <-p|-c> <command>"
    exit 1
    ;;
esac
