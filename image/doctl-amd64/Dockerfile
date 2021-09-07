FROM ubuntu:20.04 AS build

ARG DOCTL_VERSION=1.64.0

ADD https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz /doctl-${DOCTL_VERSION}-linux-amd64.tar.gz

RUN mkdir -p /dist \
  && tar --extract --directory /dist --file /doctl-${DOCTL_VERSION}-linux-amd64.tar.gz

FROM ubuntu:20.04

ENV PATH=/app:$PATH
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    ca-certificates \
    curl \
    jq \
    openssh-client \
    rsync \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=build /dist/doctl /app/doctl
ENTRYPOINT ["./doctl"]
