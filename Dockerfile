FROM python:alpine
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

ARG KUBE_VERSION="1.21.2"

COPY entrypoint.sh /entrypoint.sh
RUN pip3 --no-cache-dir install aws
RUN chmod +x /entrypoint.sh && \
    apk add --no-cache --update openssl curl ca-certificates && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cluster-info"]
