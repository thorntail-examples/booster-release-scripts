#!/bin/bash

if [ -f "pom.xml" ]; then
  mvn --quiet --non-recursive exec:exec -Dexec.executable="echo" -Dexec.args='${project.version}'
else
  echo "pom.xml doesn't exist in $(pwd)"
fi
