#!/bin/sh

case "$1" in
  "-p")
    find . -maxdepth 1 -type d -not -name '.*' -name '*-redhat' -exec bash -c "echo '{}' && cd '{}' && $2" \;
    ;;
  "-c")
    find . -maxdepth 1 -type d -not -name '.*' -not -name '*-redhat' -exec bash -c "echo '{}' && cd '{}' && $2" \;
    ;;
  *)
    echo "Usage: each.sh <-p|-c>"
    exit 1
    ;;
esac
