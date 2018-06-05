#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo docker run \
-d \
--network=host \
--restart unless-stopped \
-p 80:80 \
-e PROXY_SERVER_NAME="http://127.0.0.1:8080" \
-e JWT_SECRET="$(<${DIR}/server.cert)" \
--name nginx-jwt \
gpnx/jwt-nginx-proxy:1.8

