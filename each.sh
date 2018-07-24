#!/bin/bash

case "$1" in
  "-p")
    find . -maxdepth 1 -type d -not -name '.*' -name '*-redhat' -exec bash -c "echo '{}' && cd '{}' && $2" \;
    ;;
  "-c")
    find . -maxdepth 1 -type d -not -name '.*' -not -name '*-redhat' -exec bash -c "echo '{}' && cd '{}' && $2" \;
    ;;
  *)
    echo "usage: each.sh <-p|-c> <command>"
    exit 1
    ;;
esac
