#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker stop zeppelin-nginx && docker rm zeppelin-nginx || true

docker run -d -p 80:80 \
    --network=host \
    --name=zeppelin-nginx \
    -v ${DIR}/proxy.nginx:/etc/nginx/nginx.conf:ro \
    nginx
