#!/bin/sh

set -euxo pipefail

# preflight checks
case "$1" in
  "-p")
    echo "Product Release Preparation"
    ;;
  "-c")
    echo "Community Release Preparation"
    ;;
  *)
    echo "Usage: next_dev_version.sh <-p|-c>"
    exit 1
    ;;
esac

version=`../current_version.sh $1`
cleaned_version=`echo $version | sed -e 's/[^0-9][^0-9]*$//'`

function advance_version () {
    local v=$1
    # Get the last number. First remove any suffixes (such as '-SNAPSHOT').
    local cleaned=`echo $v | sed -e 's/[^0-9][^0-9]*$//'`
    local last_num=`echo $cleaned | sed -e 's/[0-9]*\.//g'`
    local next_num=$(($last_num+1))
    # Finally replace the last number in version string with the new one.
    echo $v | sed -e "s/[0-9][0-9]*\([^0-9]*\)$/$next_num/"
}

function advance_version_rh () {
    local v=$1
    # Get the last number. First remove any suffixes (such as '-SNAPSHOT').
    local cleaned=`echo $v | sed -e 's/[^0-9][^0-9]*$//'`
    local last_num=`echo $cleaned | sed -e 's/[0-9]*\.[0-9]*\.[0-9]*-redhat-*//g'`
    local next_num=$(($last_num+1))
    # Finally replace the last number in version string with the new one.
    echo $v | sed -e "s/[0-9][0-9]*\([^0-9]*\)$/$next_num/"
}

case "$1" in
  "-p")
    new_version=$(advance_version_rh $version)
    ;;
  "-c")
    new_version=$(advance_version $version)
    ;;
esac

echo "$cleaned_version -> $new_version"

# update version
case "$1" in
  "-p")
    # -i fails on mac os
    sed "s/$cleaned_version/$new_version/g" pom-redhat.xml  > pom.tmp && mv pom.tmp pom-redhat.xml
    ;;
  "-c")
    mvn versions:set -DnewVersion=$new_version
    ;;
esac

exit 0

# perform tests
mvn clean install

git commit -a -m "Next development version"
