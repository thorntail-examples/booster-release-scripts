#!/bin/sh

# move pom.xml around
case "$1" in
  "-p")
    target="pom-redhat.xml"
    ;;
  "-c")
    target="pom.xml"
    ;;
  *)
    echo "Usage: current_version.sh <-p|-c>"
    exit 1
    ;;
esac

if [ -e "$target" ]; then
  mvn -f $target -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec
else
  echo "File $target does not exist."
fi
