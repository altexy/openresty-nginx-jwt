#!/bin/bash
sed -i.bak 's|PROXY_SERVER_NAME|'"$PROXY_SERVER_NAME"'|g' /nginx.conf
/usr/local/openresty/bin/openresty -g 'daemon off;' -c /nginx.conf
