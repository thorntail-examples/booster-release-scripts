#!/bin/bash

set -euxo pipefail

: ${GENERATOR_HOME:?"missing environment variable GENERATOR_HOME with the license generator location"}

dir=$(pwd)

cd $GENERATOR_HOME
mvn clean package -Dexample.project.dir="$dir" -Dexternal.license.service="$LICENSE_SERVICE"
cd $dir

git add src/licenses
git commit -a -m 'Added licenses'

echo "done generating licenses for $dir"

