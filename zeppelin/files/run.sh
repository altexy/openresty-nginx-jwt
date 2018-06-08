#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker stop nginx-jwt && docker rm nginx-jwt || true

sudo docker run \
-d \
--network=host \
--restart unless-stopped \
-p 80:80 \
-e PROXY_SERVER_NAME="http://127.0.0.1:8088" \
-e JWT_SECRET="$(<${DIR}/server.cert)" \
--name nginx-jwt \
gpnx/jwt-nginx-proxy:1.8

