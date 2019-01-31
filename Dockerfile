# https://hub.docker.com/_/alpine
FROM alpine:3.9

MAINTAINER Instrumentisto Team <developer@instrumentisto.com>


# Install dependencies
RUN apk add --update --no-cache \
            ca-certificates \
            libpcap \
            libgcc libstdc++ \
            libressl2.7-libcrypto libressl2.7-libssl \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*


# Compile and install Nmap from sources
RUN apk add --update --no-cache --virtual .build-deps \
        libpcap-dev libressl-dev lua-dev linux-headers \
        autoconf g++ libtool make \
        curl \

 && curl -fL -o /tmp/nmap.tar.bz2 \
         https://nmap.org/dist/nmap-7.70.tar.bz2 \
 && tar -xjf /tmp/nmap.tar.bz2 -C /tmp \
 && cd /tmp/nmap* \
 && ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --without-zenmap \
        --without-nmap-update \
        --with-openssl=/usr/lib \
        --with-liblua=/usr/include \
 && make \
 && make install \

 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /tmp/nmap*


ENTRYPOINT ["/usr/bin/nmap"]
