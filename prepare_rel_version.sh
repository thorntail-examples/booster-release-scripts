#!/bin/sh

set -euxo pipefail

# preflight checks
case "$1" in
  "-p")
    echo "Product Release Preparation"
    target="pom-redhat.xml"
    ;;
  "-c")
    echo "Community Release Preparation"
    target="pom.xml"
    ;;
  *)
    echo "Usage: prepare_rel_version.sh <-p|-c>"
    exit 1
    ;;
esac

if [ -e "$target" ]; then
  echo "Target $target"
else
  echo "File $target does not exist, exiting."
  exit 0
fi

version=`../current_version.sh $1`
cleaned_version=`echo $version | sed -e 's/[^0-9][^0-9]*$//'`

echo $cleaned_version

# move pom.xml around
case "$1" in
  "-p")
    rm -f pom.xml
    mv pom-redhat.xml pom.xml
    ;;
  "-c")
    rm -f pom-redhat.xml
    ;;
esac

# update version
mvn versions:set -DnewVersion=$cleaned_version

# perform tests
mvn clean install

git commit -a -m "Prepare for release $cleaned_version"

git tag $cleaned_version

git log --oneline -n 3
