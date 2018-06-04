#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker stop zeppelin && docker rm zeppelin || true

docker run -d -p 8080:8080 \
    -v ${DIR}/proxy.nginx:/nginx.conf:ro \
    apache/zeppelin:0.7.3
