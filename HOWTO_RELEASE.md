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

Please handle the scripts with care: they have been tested on Mac OS and Fedora, but may fail on other linux or unix systems.

# Actual Released Steps

NOTE: the scripts expect a flag, `-c` for community releases, `-p` for product releases

## Start clean

```
./each.sh <FLAG>  "git checkout master"
./each.sh <FLAG>  "git pull upstream master"
```

## Create local branches

Assuming `SWARM-1571` is the jira issue to track the release:

```
./each.sh <FLAG> "git checkout -b SWARM-1571"
```
## Prepare the release

```
./each.sh <FLAG> "../prepare_rel_version.sh <FLAG>"
```

Skim over the commit history. The version should be updated and a commit added.

```
./each.sh <FLAG>  "git log --oneline -n 2"
```

### Verify the updated branches

i.e make sure the `pom.xml` looks correct.

### Do any additional work on the branch

i.e. you might want to update the swarm version, etc. do the work and commit it on the branch before proceeding.

#### License updates

NOTE: This requires `env.GENERATOR_HOME` and `env.BOOSTER_HOME`.
The license generator currently resides here:

- https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-booster-license-generator

```
./generate-licenses.sh <FLAG>
```

Review the licenses and add them
```
git add src/licenses
git commit -a -m 'Added licenses'
```

## Create a tag and push it

If all is good you can push the tags that have been created in the previous step.

```
./each.sh <FLAG> "../push_latest_tag.sh upstream"
```

### Gather the changes

It's good to update the release Jira with the changes (i.e. new version tags)

```
./each.sh <FLAG> " ../current_version.sh -c"
```

NOTE: This should match the tags


## Update master with the next development version

Remember, you are still on a branch, let's move back to `master`:

```
./each.sh <FLAG> "git checkout master"
```

You may also cleanup the release metadata:

```
./each.sh <FLAG> "git clean -fd"
```


### Update to the next dev version

```
./each.sh <FLAG> " ../next_dev_version.sh <FLAG>"
```

If all looks good, you can push the changes:

```
./each.sh <FLAG> "git push upstream master"
```
