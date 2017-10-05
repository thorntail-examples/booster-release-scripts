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
[...]
versions:
  - id: community
    name: <COMMUNITY_VERSION> (Community)
  - id: redhat
    name: <PRODUCT_VERSION> (RHOAR)

```


## Prepare the release

NOTE: `-c` for community releases, `-p` for product releases

```
./each.sh "pwd;../prepare_rel_version.sh <FLAG>"
```

## Verify the updated branches

i.e make sure the pom.xml looks correct and pom-redhat.xml has been removed.

## Push the tags

If all is good you can push the tags

```
./each.sh "pwd;../push_latest_tag.sh"
```

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

```
./each.sh "pwd;git commit -a -m 'Next <product"community> development version'"
./each.sh "pwd;git push upstream master"
```
