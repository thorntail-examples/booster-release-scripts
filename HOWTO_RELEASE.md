# Release Instructions

## Create local branches

Assuming `SWARM-1571` is the jira issue to track the release:

```
./each.sh "pwd;git checkout -b SWARM-1571"
```

## Do any additional work on the branch

i.e. you might want to update the swarm version, etc. do the work and commit it on the branch before committing.


### Align the meta data

i.e. the version in `.openshiftio/booster.yml`

```
name: HTTP CRUD - Wildfly Swarm
description: A simple CRUD applicaiton using Wildfly Swarm
versions:
  - id: community
    name: 2017.10.0 (Community)
  - id: redhat
    name: 7.0.0.redhat-6 (RHOAR)

```


## Prepare the release

`-c` for community releases, `-p` for product releases

```
./each.sh "pwd;../prepare_rel_version.sh -p"
```
