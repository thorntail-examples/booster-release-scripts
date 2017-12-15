# Release Instructions

## Prerequisites

- Clone this directory into $BOOSTER_HOME (your choice)
- Fetch all booster repositories _into_ $BOOSTER_HOME (Need to be children of $BOOSTER_HOME)

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
./each.sh "git checkout master"
./each.sh "git pull upstream master"
```

## Create local branches

Assuming `SWARM-1571` is the jira issue to track the release:

```
./each.sh "git checkout -b SWARM-1571"
```
## Prepare the release

NOTE: `-c` for community releases, `-p` for product releases

```
./each.sh "../prepare_rel_version.sh <FLAG>"
```

Skim over the commit history. The version should be updated and a commit added.

```
./each.sh "git log --oneline -n 2"
```

### Verify the updated branches

i.e make sure the `pom.xml` looks correct.

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

Review the licenses and add them
```
git add src/licenses
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

## Create a tag and push it

If all is good you can push the tags that have been created in the previous step.

```
./each.sh "../push_latest_tag.sh"
```
### Gather the changes

It's good to update the release Jira with the changes (i.e. new version tags)

```
./each.sh " ../current_version.sh -c"
```

NOTE: This should match the tags


## Update master with the next development version

Remember, you are still on a branch, let's move back to `master`

```
./each.sh "git checkout master"
```

You may also cleanup the release meta data

```
./each.sh "git clean -fd"
```

### Update to the next dev version

```
./each.sh " ../next_dev_version.sh <FLAG>"
```

If all looks good, you can push the changes:

```
./each.sh "git push upstream master"
```
