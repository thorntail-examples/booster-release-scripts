#!/bin/sh

set -euxo pipefail

: ${LICENSES_TEST_HOME?"Need the location of the licenses test"}
: ${MAVEN_HOME?"Need the location of Maven"}

function main() {
  dir=$(pwd)
  echo "Validating the booster licenses for $dir"
  cd $LICENSES_TEST_HOME
  
  mvn clean test \
    -Dtest=BoostersLicensesXmlTest \
    -Dmaven.home="$MAVEN_HOME" \
    -Dmarete.config=rhoar-boosters-branch \
    -Dmarete.boosters.single="file:$dir@master"

  echo "Done validating licenses for $dir" 
}

main
