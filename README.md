openresty-nginx-jwt
===
JWT Bearer Token authorization with `nginx`, `openresty`, and `lua-resty-jwt`.

An easy way to setup JWT Bearer Token authorization for any API endpoint, reverse proxy service, or location block without having to touch your server-side code.

## Run
This example uses the secret, token, and claims from [jwt.io](https://jwt.io/):

Server:
```bash
docker run --rm \
           -it \
           -e JWT_SECRET=secret \
           -v `pwd`/nginx.conf:/nginx.conf \
           -v `pwd`/bearer.lua:/bearer.lua \
           -p 8080:8080 \
           ubergarm/openresty-nginx-jwt
```

Client:
```bash
# apt-get install httpie || brew install httpie
http --print HBhb localhost:8080/secure/ "Authorization:Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ"
# token as url argument
http --print HBhb localhost:8080/secure/?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ
# token as cookie
http --print HBhb localhost:8080/secure/ "Cookie:token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWV9.TJVA95OrM7E2cBab30RMHrHDcEfxjoYZgeFONFh7HgQ"
```

## Asymmetric encryption
Example above use symmetric encryption. It is also possible to use asymmetric RSA256 encryption.

Generate private key (without password) and a certificate:

```bash
 openssl req  -nodes -new -x509  -keyout private.key -out server.cert
```

`keys` folder contains example certificate.

Run server:
```bash
#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker stop ubergarm/openresty-nginx-jwt && docker rm ubergarm/openresty-nginx-jwt || true

docker run -d -p 8080:8080 \
    -e JWT_SECRET="$(<${DIR}/keys/server.cert)" \
    -v ${DIR}/nginx.conf:/nginx.conf:ro \
    -v ${DIR}/bearer.lua:/bearer.lua:ro \
    ubergarm/openresty-nginx-jwt
```

Test:

```bash
curl 127.0.0.1:8080/secure/test -H "Authorization:Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6Im1yVGE3cG1DQUR3ZWZSX2NQMGpUbzkyVjd2YyIsInR5cCI6IkpXVCJ9.eyJmb28iOiJiYXIiLCJleHAiOjk5OTk5OTk5OTl9.d0JcUjq-Lc-C9kMMl_H8g8UJAHjPYfk1ZxFUy-ER6KWbVWa9QZ8lJcuiwCbmwXqe_Wp9L1Q9-pn6Ytiqo4cpFEvmLbdK4YIo5n7EX1Y4M4ZokaUw1_qWM_mil5E3fKrVvvOFrnTF5mlUGOXwwhu8bAVrpkE4_PH9XUVMq6z2o40L84IzKhF9BQbeV6eIXa-680ou-ewlNARaNoGYGHI_D9HyjpfytkegUu9LHn5UHs8XBpj7ycKHSUPoErxLPLkoyqe5nI8AYkzN1gYn9JDrhgfnm3wLoob0zoUz7m8OMUGoY4efhEWs5g57zub3gs9Rjdq_dwZhxUplM3FM09nDvQ"
```


## Configure
Edit `nginx.conf` to setup your custom location blocks.

Edit `bearer.lua` or create new `lua` scripts to meet your specific needs for each location block.

Restart a container and volume mount in all of the required configuration.

## Build
To update or build a custom image edit the `Dockerfile` and:
```bash
docker build -t ubergarm/openresty-nginx-jwt .
```

## Note
I originally tried to get [auth0/nginx-jwt](https://github.com/auth0/nginx-jwt) working, but even the newer forks are not as straight forward as simply using `lua-resty-jwt` rock directly.

If you're looking for something beyond just JWT auth, check out [kong](https://getkong.org/) for all your API middleware plugin needs!

Also [Caddy](https://caddyserver.com/) might be faster for a simple project.

## TODO
I'd love to get this running in an [Alpine Linux](https://alpinelinux.org/), but `openresty/openresty:alpine` doesn't come with LuaRocks. It should be possible with some work and would reduce the image size considerably.

## References
* https://github.com/openresty/docker-openresty
* https://github.com/SkyLothar/lua-resty-jwt
* https://github.com/svyatogor/resty-lua-jwt
* https://getkong.org/
* https://jwt.io/
