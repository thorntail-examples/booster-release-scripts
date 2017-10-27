#!/bin/sh

set -euxo pipefail

if [ -e "pom-redhat.xml" ]; then
  echo "pom-redhat.xml should not exists in a branch that's already tagged! Exiting."
  exit 1
fi

version=`../current_version.sh -c` # remains -c since we already have removed pom-redhat.xml
cleaned_version=`echo $version | sed -e 's/[^0-9][^0-9]*$//'`

echo "Going to push tag $cleaned_version"

git tag -f $cleaned_version

git push upstream $cleaned_version
