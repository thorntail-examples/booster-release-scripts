#!/bin/bash

set -euxo pipefail

: ${LICENSES_TEST_HOME:?"missing environment variable LICENSES_TEST_HOME with the licenses test location"}
: ${M2_HOME:?"missing environment variable M2_HOME with Maven location"}

dir=$(pwd)
echo "validating licenses in $dir"

cd $LICENSES_TEST_HOME
mvn clean test \
  -Dtest=BoostersLicensesXmlTest \
  -Dmaven.home="$M2_HOME" \
  -Dmarete.config=rhoar-boosters-branch \
  -Dmarete.boosters.single="file:$dir@master"
cd $dir

echo "done validating licenses in $dir"
