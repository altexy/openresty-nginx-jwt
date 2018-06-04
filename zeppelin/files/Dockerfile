FROM openresty/openresty:xenial
MAINTAINER Eugene Sapozhnikov <eugene@gpnxgroup.com>

# Inspired by https://github.com/ubergarm/openresty-nginx-jwt

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt

ADD startup-script.sh /startup-script.sh
ADD nginx.conf /nginx.conf
ADD bearer.lua /bearer.lua

ENTRYPOINT ["/startup-script.sh"]
