# how to create wild card certificates with docker acme.sh and transip

start docker, to get any idea how: [docker docs](https://docs.docker.com/install)

clone this repo:
```
git clone https://github.com/jaydouble/transipdocker
```

then start with:
``` 
docker-composer up -d
```

and then run acme.sh commands like:
```
docker exec -it transipdocker_acme.sh_1 tipctl setup
```
```
docker exec -it transipdocker_acme.sh_1 --issue -d example.com -d *.example.com --dns dns_trans_ip --dnssleep 300
```
