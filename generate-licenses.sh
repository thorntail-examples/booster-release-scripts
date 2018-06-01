#!/bin/sh

set -euxo pipefail

: ${GENERATOR_HOME?"Need the location of the license-generator"}

case "$1" in
  "-p")
    suffix="-redhat"
    repo="https://maven.repository.redhat.com/ga/"
    ;;
  "-c")
    suffix=""
    repo="https://repository.jboss.org/nexus/content/repositories/thirdparty-releases/"
    ;;
  *)
    echo "Usage: generate-licenses.sh <-p|-c>"
    exit 1
    ;;
esac


# circuit breaker
function cb() {
  complex_booster greeting-service name-service tests
}

# cache
function cache() {
  complex_booster greeting-service cute-name-service tests
}

function simple_booster() {
  dir=$(pwd)
  name=`basename $dir`
  version=`mvn -f $dir/pom.xml -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec`

  cd $GENERATOR_HOME

  mvn clean package \
    -Dbooster.pom.file="$dir/pom.xml" \
    -Dbooster.project.dir="$dir" \
    -Dbooster.name="$name" \
    -Dbooster.assembly.name="$name" \
    -Dbooster.product.build="$name" \
    -Dbooster.version="$version" \
    -Dbooster.repo.url="$repo"

  cp -R "target/license-project/target/licenses" "$dir/src/"
  add_licenses $dir
  commit_licenses $dir
  echo "Done generating licenses for $dir" 
}


function complex_booster() {
  dir=$(pwd)
  base=`basename $dir`
  version=`mvn -f $dir/pom.xml -q -Dexec.executable="echo" -Dexec.args='${project.version}' --non-recursive exec:exec`

  cd $GENERATOR_HOME

  for module in "$@"
  do

    name="$base-$module"

    mvn clean package \
    -Dbooster.pom.file="$dir/$module/pom.xml" \
    -Dbooster.name="$name" \
    -Dbooster.assembly.name="$name" \
    -Dbooster.product.build="$name" \
    -Dbooster.version="$version" \
    -Dbooster.project.dir="$dir/$module"

    cp -R "target/license-project/target/licenses" "$dir/$module/src/"
    add_licenses $dir/$module

    echo "Done generating licenses for $dir/$module"
  done
  commit_licenses $dir
}

function add_licenses() {
  cd $1
  git add src/licenses
  cd -
}

function commit_licenses() {
  cd $1
  git commit -a -m 'Added licenses'
  cd -
}

echo "Processing all boosters"
booster=`basename $(pwd)`

case "$booster" in
  "wfswarm-cache")
    cache
    ;;
  "wfswarm-circuit-breaker")
    cb
    ;;
  *)
    simple_booster
    ;;
esac
