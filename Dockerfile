# https://hub.docker.com/_/alpine
# Create base image
FROM alpine:3.12 as base


# Install dependencies
RUN apk add --no-cache \
        libpcap \
        libgcc libstdc++ \
        libressl3.1-libcrypto libressl3.1-libssl

# Use base image to compile and install Nmap from sources
FROM base as compiler

# Note: no empty continuation lines as this will become errors in a future release
RUN apk add --no-cache --virtual .build-deps \
        libpcap-dev libressl-dev lua-dev linux-headers \
        autoconf g++ libtool make \
        curl ca-certificates \
 && curl -fL -o /tmp/nmap.tar.bz2 \
         https://nmap.org/dist/nmap-7.80.tar.bz2 \
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

# Use base image again
FROM base

# Copy neccsarry files from compiler step
COPY --from=compiler /usr/share/nmap/ /usr/share/nmap/ 
COPY --from=compiler /usr/bin /usr/bin/

ENTRYPOINT ["/usr/bin/nmap"]
