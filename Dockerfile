FROM alpine:3.2
MAINTAINER mkscsy@gmail.com

ENV COMPOSE_VERSION 1.5.2

RUN apk --update add curl libgcc libstdc++ \
    && curl -SLO https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk \
    && curl -SLO https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/8/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk \
    && apk add --allow-untrusted glibc-2.21-r2.apk glibc-bin-2.21-r2.apk \
    && /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib \
    && curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/bin/docker-compose \
    && chmod +x /usr/bin/docker-compose \
    && apk del curl \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT ["/usr/bin/docker-compose"]
CMD ["--version"]