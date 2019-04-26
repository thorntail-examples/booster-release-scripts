# Release Instructions

## Prerequisites

- Clone this directory into $BOOSTER_HOME (your choice)
- Fetch all forked booster repositories _into_ $BOOSTER_HOME (Need to be children of $BOOSTER_HOME). Make sure that the remote from https://github.com/thorntail-examples/ is called **upstream**. You can run `./clone_here.sh` to do this.

Your workspace should like like this:

```
$ tree -L 1 -d
.
├── cache
├── cache-redhat
├── circuit-breaker
├── circuit-breaker-redhat
├── configmap
├── configmap-redhat
├── health-check
├── health-check-redhat
├── messaging-work-queue
├── rest-http
├── rest-http-crud
├── rest-http-crud-redhat
├── rest-http-redhat
├── rest-http-secured
└── rest-http-secured-redhat
```

## Handle with care

Please handle the scripts with care. They have been tested on Mac OS, Fedora and Ubuntu, but may fail on other Linux or Unix systems.
(At this point, they may actually also fail on Mac OS, as noone except the original author doesn't use them in that environment.)

# Actual Release Steps

The release process is performed on the master branch.
NOTE: the `each.sh` script expects a flag, `-c` for community releases, `-p` for product releases.

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

The following script will set the booster POM(s) to the release version and log the relevant commits:

Community:
```
./each.sh -c "../prepare_rel_version.sh"
```

Product:
```
./each.sh -p "../prepare_rel_version.sh"
```

### Verify the updated master branches

Make sure the `pom.xml` looks correct.

Community:
```
./each.sh -c "../log_commits.sh"
```

Product:
```
./each.sh -p "../log_commits.sh"
```

### Do any additional work

E.g. you might want to update the Thorntail version, etc. Do the work and commit it before proceeding.

#### License updates

Get the license generator from:

- https://github.com/thorntail-examples/booster-license-generator

and set the `GENERATOR_HOME` environment variable to point to the cloned directory.

The following script generates and adds the licenses to the local `master` branch:

Community:
```
./each.sh -c "../generate_licenses.sh"
```

Product:
```
./each.sh -p "../generate_licenses.sh"
```

Review the licenses. A recommended approach is to run the RHOAR licenses validation test against the local clones of the boosters.
Set the `LICENSES_TEST_HOME` environment variable to point to the test directory; if you don't know where to clone it from, ask the team.
Also set the `MAVEN_HOME` environment variable to point to the Maven installation.

Community:
```
./each.sh -c "../validate_licenses.sh"
```

Product:
```
./each.sh -p "../validate_licenses.sh"
```

If the validation test fails then remove the licenses, try to address the issues and repeat the process.

## Create a tag and push it

If all is good you can create and push the tags.

Community:
```
./each.sh -c "../push_latest_tag.sh"
```

Product:
```
./each.sh -p "../push_latest_tag.sh"
```

### Gather the changes

It's good to update the release Jira with the changes (i.e. new version tags).
Use the following script to get all the version tags:

Community:

```
./each.sh -c "../current_version.sh"
```

Product:

```
./each.sh -p "../current_version.sh"
```

## Update master with the next development version

Cleanup the release metadata and update the next development version:

Community:
```
./each.sh -c "../next_dev_version.sh"
```

Product:
```
./each.sh -p "../next_dev_version.sh"
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

## Update Booster Catalog

Finally, update Booster Catalog which resides at

- https://github.com/fabric8-launcher/launcher-booster-catalog

Update the tag reference at one of the existing modules or add a new module if it is a new booster.
