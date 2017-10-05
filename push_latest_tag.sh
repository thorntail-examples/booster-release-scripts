#!/bin/sh

set -euxo pipefail

version=`../current_version.sh`
cleaned_version=`echo $version | sed -e 's/[^0-9][^0-9]*$//'`

echo "Going to push tag $cleaned_version"

git push upstream $cleaned_version
