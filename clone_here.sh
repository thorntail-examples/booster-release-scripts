#!/bin/bash

repositories=(
  # community
  "git@github.com:thorntail-examples/rest-http.git"
  "git@github.com:thorntail-examples/rest-http-crud.git"
  "git@github.com:thorntail-examples/configmap.git"
  "git@github.com:thorntail-examples/rest-http-secured.git"
  "git@github.com:thorntail-examples/health-check.git"
  "git@github.com:thorntail-examples/circuit-breaker.git"
  "git@github.com:thorntail-examples/cache.git"
  # redhat
  "git@github.com:thorntail-examples/rest-http-redhat.git"
  "git@github.com:thorntail-examples/rest-http-crud-redhat.git"
  "git@github.com:thorntail-examples/configmap-redhat.git"
  "git@github.com:thorntail-examples/rest-http-secured-redhat.git"
  "git@github.com:thorntail-examples/health-check-redhat.git"
  "git@github.com:thorntail-examples/circuit-breaker-redhat.git"
  "git@github.com:thorntail-examples/cache-redhat.git"
)

for R in "${repositories[@]}" ; do
  git clone --origin upstream $R
done
