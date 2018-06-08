FROM openresty/openresty:1.13.6.2-alpine
MAINTAINER Eugene Sapozhnikov <eugene@gpnxgroup.com>

# Inspired by https://github.com/ubergarm/openresty-nginx-jwt

#RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jwt

ADD startup-script.sh /startup-script.sh
RUN chmod +x /startup-script.sh
ADD nginx.conf /nginx.conf
ADD bearer.lua /bearer.lua

ADD lua-resty-jwt/lib/resty/jwt.lua /usr/local/openresty/lualib/resty/jwt.lua
ADD lua-resty-jwt/lib/resty/evp.lua /usr/local/openresty/lualib/resty/evp.lua
ADD lua-resty-jwt/lib/resty/jwt-validators.lua /usr/local/openresty/lualib/resty/jwt-validators.lua
ADD lua-resty-jwt/vendor/resty/hmac.lua /usr/local/openresty/lualib/resty/hmac.lua

ENTRYPOINT ["/startup-script.sh"]
