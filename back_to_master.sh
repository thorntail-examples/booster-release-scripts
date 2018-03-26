#!/bin/sh

set -euxo pipefail

git checkout master

git clean -fd
