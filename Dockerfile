FROM neilpang/acme.sh:latest

MAINTAINER dockerhub@woudenbergh.nl

RUN apk add composer && composer global require transip/tipctl

RUN mkdir -p /root/.config/transip-api/

RUN apk add jq

ADD dns_transip.sh /root/.acme.sh/dnsapi/

ENV PATH="/root/.composer/vendor/bin:${PATH}"
