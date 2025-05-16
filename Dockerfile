FROM alpine:3.17
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ARG TARGETPLATFORM
ARG KUBE_VERSION="v1.33.1"

COPY entrypoint.sh /entrypoint.sh

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=arm64; else ARCHITECTURE=amd64; fi && \
    chmod +x /entrypoint.sh && \
    apk add --no-cache --update openssl curl ca-certificates && \
    curl -L https://dl.k8s.io/release/$KUBE_VERSION/bin/linux/$ARCHITECTURE/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cluster-info"]
