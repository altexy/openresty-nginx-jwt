# JWT nginx proxy with SSL support

## Running Docker Container
``sudo docker run \
-d \
--restart unless-stopped \
--log-opt max-size=200m \
-p 80:80 \
-e JWT_SECRET=secret \
-e PROXY_SERVER_NAME="http://`hostname -i`:8088" \
--name nginx-jwt \
gpnx/jwt-nginx-proxy:1.8
``