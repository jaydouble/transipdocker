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

