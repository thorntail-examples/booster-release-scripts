#!/bin/bash

set -euxo pipefail

: ${GENERATOR_HOME?"need the location of the license-generator"}

case "$(basename $(pwd))" in
  *-redhat)
    repo="https://maven.repository.redhat.com/ga/"
    ;;
  *)
    repo="https://repository.jboss.org/nexus/content/repositories/thirdparty-releases/"
    ;;
esac


simple_booster () {
  dir=$(pwd)
  name=$(basename $dir)
  version=$(../current_version.sh)

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
  echo "done generating licenses for $dir" 
}


complex_booster () {
  dir=$(pwd)
  base=$(basename $dir)
  version=$(../current_version.sh)

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

    echo "done generating licenses for $dir/$module"
  done
  commit_licenses $dir
}

add_licenses () {
  cd $1
  git add src/licenses
  cd -
}

commit_licenses () {
  cd $1
  git commit -a -m 'Added licenses'
  cd -
}

case "$(basename $(pwd))" in
  cache*)
    complex_booster greeting-service cute-name-service tests
    ;;
  circuit-breaker*)
    complex_booster greeting-service name-service tests
    ;;
  messaging-work-queue*)
    complex_booster frontend worker tests
    ;;
  istio-tracing*)
    complex_booster greeting-service cute-name-service
    ;;
  *)
    simple_booster
    ;;
esac
