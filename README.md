# how to create wild card certificates with docker acme.sh and transip

start docker, to get any idea how: [docker docs](https://docs.docker.com/install)

clone this repo:
```
git clone https://github.com/jaydouble/transipdocker
cd transipdocker
```

then start with:
``` 
docker-composer up -d
```

and then run acme.sh commands like:
### setup transip api
```
docker exec -it transipdocker_acme.sh_1 tipctl setup
```
### issue a certificate
```
docker exec transipdocker_acme.sh_1 \
  --issue -d example.com -d '*.example.com' \
  --dns dns_transip --dnssleep 300
```
### install certificate into certs folder:
```
docker exec transipdocker_acme.sh_1 \
  --install-cert \
  -d example.com
  --fullchain-file /etc/ssl/private/fullchain.pem \
  --key-file /etc/ssl/private/privkey.pem
```
now you can use it somewhere else, like an nginx container.
