#!/bin/sh

set -euxo pipefail

version=`../current_version.sh`
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

new_version="$(advance_version $version)-SNAPSHOT"
echo "$cleaned_version -> $new_version"

# update version
mvn versions:set -DnewVersion=$new_version

# perform tests
mvn clean install

git commit -a -m "Next development version"
