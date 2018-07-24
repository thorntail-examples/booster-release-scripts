#!/bin/bash

set -euxo pipefail

if [ ! -f "pom.xml" ]; then
  echo "pom.xml does not exist in $(pwd), exiting"
  exit 0
fi

version=$(../current_version.sh)
cleaned_version=$(echo $version | sed -e 's/[^0-9][^0-9]*$//')

echo $cleaned_version

mvn versions:set -DnewVersion=$cleaned_version

mvn clean install

git commit -a -m "Prepare for release $cleaned_version"

git log --oneline -n 3
