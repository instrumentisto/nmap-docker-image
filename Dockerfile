# https://hub.docker.com/_/alpine
FROM alpine:3.18

ARG nmap_ver=7.94
ARG build_rev=0


# Install dependencies
RUN apk add --update --no-cache \
            ca-certificates \
            libpcap \
            libgcc libstdc++ \
            libssl3 \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*


# Compile and install Nmap from sources
RUN apk add --update --no-cache --virtual .build-deps \
        libpcap-dev lua-dev linux-headers openssl-dev \
        autoconf g++ libtool make \
        curl \
    \
 && curl -fL -o /tmp/nmap.tar.bz2 \
         https://nmap.org/dist/nmap-${nmap_ver}.tar.bz2 \
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
    \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /tmp/nmap*


ENTRYPOINT ["/usr/bin/nmap"]
