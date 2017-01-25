# https://hub.docker.com/_/alpine
FROM alpine:latest

MAINTAINER Instrumentisto Team <developer@instrumentisto.com>


# Install dependencies
RUN apk add --update --no-cache \
            curl ca-certificates \
            libpcap \
            libgcc libstdc++ \
            libressl2.4-libcrypto libressl2.4-libssl \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*


# Compile and install Nmap from sources
RUN apk add --update --no-cache --virtual .build-deps \
        libpcap-dev libressl-dev lua-dev linux-headers \
        autoconf g++ libtool make \

 && curl -L -o /tmp/nmap.tar.bz2 \
         https://nmap.org/dist/nmap-7.40.tar.bz2 \
 && tar -xjf /tmp/nmap.tar.bz2 -C /tmp \
 && cd /tmp/nmap* \
 && ./configure \
 && make \
 && make install \

 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /tmp/nmap*


ENTRYPOINT ["/usr/local/bin/nmap"]
