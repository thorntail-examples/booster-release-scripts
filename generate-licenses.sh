#!/bin/sh

set -euxo pipefail

: ${GENERATOR_HOME?"Need the location of the license-generator"}
: ${BOOSTER_HOME?"Need the location of the boosters"}

case "$1" in
  "-p")
    suffix="-redhat"
    ;;
  "-c")
    suffix=""
    ;;
  *)
    echo "Usage: generate-licenses.sh <-p|-c>"
    exit 1
    ;;
esac

function main() {
  for booster in "wfswarm-rest-http" "wfswarm-rest-http-secured" "wfswarm-configmap" "wfswarm-health-check" "wfswarm-rest-http-crud"
  do

    dir="$BOOSTER_HOME/$booster$suffix"
    name=`basename $dir`
    version=`mvn -f $dir/pom.xml -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec`

    # preflight
    if [ -f "$dir/src/licenses/licenses.html" ]; then
       echo "ERROR: Licenses already present, exiting..."
       exit 1
    fi

    mvn clean package \
    -Dbooster.pom.file="$dir/pom.xml" \
    -Dbooster.project.dir="$dir" \
    -Dbooster.name="$name" \
    -Dbooster.assembly.name="$name" \
    -Dbooster.product.build="$name" \
    -Dbooster.version="$version"

    cp -R "target/license-project/target/licenses" "$dir/src/"

    echo "Done generating licenses for $dir"

  done
}

function custom() {
  for booster in $1
  do

    dir="$BOOSTER_HOME/$booster$suffix"
    name=`basename $dir`
    version=`mvn -f $dir/pom.xml -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec`

    # preflight
    if [ -f "$dir/src/licenses/licenses.html" ]; then
       echo "ERROR: Licenses already present, exiting..."
       exit 1
    fi

    mvn clean package \
    -Dbooster.pom.file="$dir/pom.xml" \
    -Dbooster.project.dir="$dir" \
    -Dbooster.name="$name" \
    -Dbooster.assembly.name="$name" \
    -Dbooster.product.build="$name" \
    -Dbooster.version="$version"

    cp -R "target/license-project/target/licenses" "$dir/src/"

    echo "Done generating licenses for $dir"

  done
}

# circuit breaker
function cb() {
  for module in "greeting-service" "name-service"
  do

    dir="$BOOSTER_HOME/wfswarm-circuit-breaker$suffix"
    base=`basename $dir`
    name="$base-$module"
    version=`mvn -f $dir/pom.xml -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec`

    # preflight

    if [ -f "$dir/$module/src/licenses/licenses.html" ]; then
       echo "ERROR: Licenses already present, exiting..."
       exit 1
    fi

    mvn clean package \
    -Dbooster.pom.file="$dir/$module/pom.xml" \
    -Dbooster.name="$name" \
    -Dbooster.assembly.name="$name" \
    -Dbooster.product.build="$name" \
    -Dbooster.version="$version" \
    -Dbooster.project.dir="$dir/$module"

    cp -R "target/license-project/target/licenses" "$dir/$module/src/"

    echo "Done generating licenses for $dir/$module"
  done
}

echo "Processing all boosters"
cd $GENERATOR_HOME
main
cb
