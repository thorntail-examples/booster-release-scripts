#!/bin/sh

case "$1" in
  "-p")
    target="prod"
    ;;
  "-c")
    target="."
    ;;
  *)
    echo "Usage: each.sh <-p|-c>"
    exit 1
    ;;
esac

find $target -maxdepth 1 -type d -not -name '.*' -exec bash -c "echo '{}' && cd '{}' && $2" \;
