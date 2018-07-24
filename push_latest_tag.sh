#!/bin/bash

set -euxo pipefail

version=$(../current_version.sh)
cleaned_version=$(echo $version | sed -e 's/[^0-9][^0-9]*$//')

echo "pushing tag $cleaned_version"

git tag -f $cleaned_version

git push upstream $cleaned_version
