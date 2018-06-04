# JWT nginx proxy with SSL support

## Running Docker Container
``sudo docker run \
  -d \
  --network=host \
  --restart unless-stopped \
  -p 80:80 \
  -e JWT_SECRET=secret \
  -e PROXY_SERVER_NAME="http://127.0.0.1:8080" \
  --name nginx-jwt \
  gpnx/jwt-nginx-proxy
``