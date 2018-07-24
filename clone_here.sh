#!/bin/bash

repositories=(
  # community
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-rest-http.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-configmap.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-health-check.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-cache.git"
  # redhat
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-redhat.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud-redhat.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-configmap-redhat.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured-redhat.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-health-check-redhat.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker-redhat.git"
  "git@github.com:wildfly-swarm-openshiftio-boosters/wfswarm-cache-redhat.git"
)

for R in "${repositories[@]}" ; do
  git clone --origin upstream $R
done
