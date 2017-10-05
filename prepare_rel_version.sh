#!/bin/sh

set -euxo pipefail

# move pom.xml around
case "$1" in
  "-p")
    echo "Product Release Preparation"
    rm -f pom.xml
    mv pom-redhat.xml pom.xml
    ;;
  "-c")
    echo "Product Release Preparation"
    rm -f pom-redhat.xml
    ;;
  *)
    echo "Usage: prepare_rel_version.sh <-p|-c>"
    exit 1
    ;;
esac

version=`../current_version.sh`
cleaned_version=`echo $version | sed -e 's/[^0-9][^0-9]*$//'`

echo $cleaned_version

# update version
mvn versions:set -DnewVersion=$cleaned_version

# perform tests
mvn clean install

git commit -a -m "Prepare for release $cleaned_version"

git tag $cleaned_version

git log --oneline -n 5
