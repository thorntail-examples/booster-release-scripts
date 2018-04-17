#!/bin/sh

set -euxo pipefail

git checkout master

git pull upstream master
