#!/bin/bash

CURDIR=${PWD}
EXTRA=$1

# change to the directory where we are
SCRIPT=$(readlink -f "$0")
SDIR=$(dirname "$SCRIPT")
cd $SDIR

# clean out the tree
find . -name '*.*~' -exec rm {} \;
find . -name '.*~' -exec rm {} \;
find . -name '*~' -exec rm {} \;

. ../docker_vars

echo "bulding ${IMAGE}:${VERSION}";

# docker rmi ${IMAGE}
# docker build --no-cache --rm -t ${IMAGE} .
docker build ${EXTRA} --rm -t ${IMAGE}:${VERSION} .
echo "built ${IMAGE}:${VERSION}";

cd ${CURDIR};
