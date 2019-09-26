FROM alpine:3.10.2
MAINTAINER Serhiy Mitrovtsiy <mitrovtsiy@ukr.net>

LABEL name="kubectl"
LABEL version="1.0.0"
LABEL repository="https://github.com/exelban/gcloud"
LABEL homepage="https://github.com/exelban/gcloud"
LABEL maintainer="Serhiy Mytrovtsiy <mitrovtsiy@ukr.net>"

LABEL com.github.actions.name="Kuberentes (k8s) cli - kubectl"
LABEL com.github.actions.description="GitHub Action for working with kubectl (k8s)"
LABEL com.github.actions.icon="terminal"
LABEL com.github.actions.color="blue"

ARG KUBE_VERSION="1.15.4"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apk add --no-cache --update openssl curl ca-certificates && \
    curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cluster-info"]