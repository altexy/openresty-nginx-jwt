#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker stop ubergarm/openresty-nginx-jwt && docker rm ubergarm/openresty-nginx-jwt || true

docker run -d -p 8080:8080 \
    -e JWT_SECRET="$(<${DIR}/keys/server.cert)" \
    -v ${DIR}/nginx.conf:/nginx.conf:ro \
    -v ${DIR}/bearer.lua:/bearer.lua:ro \
    ubergarm/openresty-nginx-jwt