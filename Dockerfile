# https://hub.docker.com/_/alpine
FROM alpine:3.21

ARG nmap_ver=7.95
ARG build_rev=6


# Install dependencies
RUN apk add --update --no-cache \
            ca-certificates \
            libgcc libstdc++ \
            libcrypto3 libssl3 \
            libpcap \
            libssh2 \
            lua5.4-libs \
            zlib \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*


# Compile and install Nmap from sources
RUN apk add --update --no-cache --virtual .build-deps \
        linux-headers \
        openssl-dev \
        libpcap-dev \
        libssh2-dev \
        lua5.4-dev \
        pcre-dev \
        zlib-dev \
        autoconf automake g++ libtool make \
        curl \
    \
 && curl -fL -o /tmp/nmap.tar.bz2 \
         https://nmap.org/dist/nmap-${nmap_ver}.tar.bz2 \
 && tar -xjf /tmp/nmap.tar.bz2 -C /tmp \
 && cd /tmp/nmap* \
 && autoreconf libpcre libdnet-stripped -ivf \
 && ./configure \
        --prefix=/usr \
        --sysconfdir=/etc \
        --mandir=/usr/share/man \
        --infodir=/usr/share/info \
        --without-zenmap \
        --without-nmap-update \
        --with-liblua=/usr/lua5.4 \
        --with-libpcap=yes \
        --with-libpcre=yes \
        --with-libssh2=yes \
        --with-libz=yes \
        --with-openssl=yes \
 && make \
 && make install \
    \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /tmp/nmap*


ENTRYPOINT ["/usr/bin/nmap"]
