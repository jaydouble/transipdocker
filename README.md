# how to create wild card certificates with docker acme.sh and transip

start docker, to get any idea how: [docker docs](https://docs.docker.com/install)

then first add transip credentials:
```
docker run --rm  -it  \
  -v "$(pwd)/out":/acme.sh  \
  -v "$(pwd)/cli-config.json":/root/.config/transip-api/cli-config.json
  jaydouble/acme.sh \
  tipctl setup
```

then to request certificate
```
docker run --rm  -it  \
  -v "$(pwd)/out":/acme.sh  \
  -v "$(pwd)/cli-config.json":/root/.config/transip-api/cli-config.json
  jaydouble/acme.sh \
  --issue -d example.net -d example.com  -d '*.example.net' -d '*.example.net' --dns dns_transip --dnssleep 600
```

or start with:
``` 
docker-composer up -d
```

and then run acme.sh commands with:
```
docker exec -it acmesh_acme.sh_1 --issue example.com --dns trans_ip
```
