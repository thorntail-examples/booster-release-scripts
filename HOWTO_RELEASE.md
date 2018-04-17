# Release Instructions

## Prerequisites

- Clone this directory into $BOOSTER_HOME (your choice)
- Fetch all forked booster repositories _into_ $BOOSTER_HOME (Need to be children of $BOOSTER_HOME)

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

# Actual Release Steps

The release process is performed on the master branch.
NOTE: the scripts expect a flag, `-c` for community releases, `-p` for product releases.

## Start clean

The following script pulls from the upstream master into the local master:

Community:
```
./each.sh -c "../update_master.sh"
```

Product:
```
./each.sh -p "../update_master.sh"
```

## Prepare the release

The folowing scripts will set the booster pom(s) to the release version and log the relevant commits:

Community:
```
./each.sh -c "../prepare_rel_version.sh -c"
./each.sh -c "../log_commits.sh"
```

Product:
```
./each.sh -p "../prepare_rel_version.sh -p"
./each.sh -p "../log_commits.sh"
```

### Verify the updated master branches

i.e make sure the `pom.xml` looks correct.

### Do any additional work

i.e. you might want to update the swarm version, etc. do the work and commit it before proceeding.

#### License updates

NOTE: This requires `env.GENERATOR_HOME` and `env.BOOSTER_HOME`.
The license generator currently resides here:

- https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-booster-license-generator

The following script generates and adds the licenses to the local master branch:

Community:
```
./generate-licenses.sh -c
```

Product:
```
./generate-licenses.sh -p
```

Review the licenses: a recommended approach is to run a RHOAR licenses validation test against these licenses. This test is easy to set up and run, for example, the URL such as "file:$BOOSTER_HOME/wfs-rest-http@master" can be used by this test to validate the added licenses. Please ask the team for more details. 

If the validation test fails then remove the licenses, try to address the issues and repeat the process.

## Create a tag and push it

If all is good you can create and push the tags.

Community:
```
./each.sh -c "../push_latest_tag.sh upstream"
```

Product:
```
./each.sh -p "../push_latest_tag.sh upstream"
```

### Gather the changes

It's good to update the release Jira with the changes (i.e. new version tags).
Use the following script to get all the version tags:

Community:

```
./each.sh -c " ../current_version.sh -c"
```

Product:

```
./each.sh -p " ../current_version.sh -p"
```

## Update master with the next development version

Cleanup the release metadata and update the next development version:

Community:
```
./each.sh -c " ../next_dev_version.sh -c"
```

Product:
```
./each.sh -p " ../next_dev_version.sh -c"
```

If all looks good, you can push the changes to the upstream master:

Community:
```
./each.sh -c "../push_to_master.sh"
```

Product:
```
./each.sh -p "../push_to_master.sh"
```
