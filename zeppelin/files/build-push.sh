#!/usr/bin/env bash
set -e

# script folder detection, from http://stackoverflow.com/a/1638387/792313
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR

VERSION=1.8

docker build -t gpnx/jwt-nginx-proxy:$VERSION . && docker push gpnx/jwt-nginx-proxy:$VERSION
#docker build -t gpnx/jwt-nginx-proxy:$VERSION .
EXIT_CODE=$?

exit $EXIT_CODE