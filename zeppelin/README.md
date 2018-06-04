How to test
===========

Ports 80(nginx) and 8080(zeppelin) on host machine must not be used.

Run `./zeppelin.sh` - start Zeppelin container.

Run `./nginx.sh` - start Nginx container.

It uses host network to be able to connect to 127.0.0.1:8080.
In real life scenario DevOps would need to use named network and use container name within proxy.nginx
instead of 127.0.0.1.

Open web browser and type `127.0.0.1/zeppelin`

Green!
