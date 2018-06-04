#!/usr/bin/env bash

# script folder detection, from http://stackoverflow.com/a/1638387/792313
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cd $SCRIPTPATH

VERSION=1.8

docker build -t gpnx/jwt-nginx-proxy:$VERSION . && docker push gpnx/jwt-nginx-proxy:$VERSION
EXIT_CODE=$?

exit $EXIT_CODE