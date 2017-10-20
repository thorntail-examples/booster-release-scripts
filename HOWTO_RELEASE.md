# Release Instructions

## Prerequisites

- Clone this directory into $BOOSTER_DIR (your choice)
- Fetch all booster repositories _into_ $BOOSTER_DIR (Need to be children of $BOOSTER_DIR)

Your workspace should like like this:

```
.
├── HOWTO_RELEASE.md
├── advance_version.sh
├── current_version.sh
├── each.sh
├── next_dev_version.sh
├── prepare_rel_version.sh
├── push_latest_tag.sh
├── wfswarm-circuit-breaker
├── wfswarm-configmap
├── wfswarm-health-check
├── wfswarm-rest-http
├── wfswarm-rest-http-crud
└── wfswarm-rest-http-secured
```

## Handle with care

This works for me, but may not work for anybody else. In particular, these scripts have been tested on Mac OS, but may fail on other linux or unix systems.

# Actual Released Steps

## Start clean

```
./each.sh "pwd;git checkout master"
./each.sh "pwd;git pull upstream master"
```

## Create local branches

Assuming `SWARM-1571` is the jira issue to track the release:

```
./each.sh "pwd;git checkout -b SWARM-1571"
```
## Prepare the release

NOTE: `-c` for community releases, `-p` for product releases

```
./each.sh "pwd;../prepare_rel_version.sh <FLAG>"
```

Skim over the commit history. The version should updated and a commit added. This step also create the tag already.

```
./each.sh "pwd;git log --oneline -n 2"
```

### Verify the updated branches

i.e make sure the `pom.xml` looks correct and `pom-redhat.xml` has been removed.

### Do any additional work on the branch

i.e. you might want to update the swarm version, etc. do the work and commit it on the branch before proceeding.

#### License updates

In some cases you may have to regenerate the `license.xml`

NOTE: This requires `env.GENERATOR_HOME` and `env.BOOSTER_HOME`.
The license generator currently resides here:

- https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-booster-license-generator

```
./generate-licenses.sh
```

### Align the meta data

i.e. the version in `.openshiftio/booster.yml`

```
[...]
versions:
  - id: community
    name: <COMMUNITY_VERSION> (Community)
  - id: redhat
    name: <PRODUCT_VERSION> (RHOAR)

```

## Push the tags

If all is good you can push the tags that have been created in the previous step.

```
./each.sh "pwd;../push_latest_tag.sh"
```
### Gather the changes

It's good to update the release jira with the chnages (i.e. new version tags)

```
./each.sh "pwd; ../current_version.sh -c"
```

NOTE: This should match the tags


## Update master with the next development version

Remember, you are still on a branch, let's move back to `master`

```
./each.sh "pwd;git checkout master"
```

You may also cleanup the release meta data

```
./each.sh "pwd;git clean -fd"
```

### Update to the next dev version

```
./each.sh "pwd; ../next_dev_version.sh <FLAG>"
```

If all looks good, you can push the changes:

```
./each.sh "pwd;git push upstream master"
```
