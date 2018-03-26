#!/bin/sh

set -euxo pipefail

if [ -z "$1" ]
  then
    echo "Usage: create_branch.sh <BRANCH>"
    exit 1
fi

git checkout -b $1

