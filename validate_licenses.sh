#!/bin/bash

set -euxo pipefail

: ${LICENSES_TEST_HOME?"need the location of the licenses test"}
: ${MAVEN_HOME?"need the location of Maven"}

dir=$(pwd)
echo "validating booster licenses in $dir"
cd $LICENSES_TEST_HOME

mvn clean test \
  -Dtest=BoostersLicensesXmlTest \
  -Dmaven.home="$MAVEN_HOME" \
  -Dmarete.config=rhoar-boosters-branch \
  -Dmarete.boosters.single="file:$dir@master"

echo "done validating licenses in $dir"
