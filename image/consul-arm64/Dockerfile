FROM ubuntu:20.04 AS build
# LABEL org.opencontainers.image.authors="Consul Team <consul@hashicorp.com>"

# Hashcorp apt repos do not currently support arm64, so we must use the
# binary download

# This is the release of Consul to pull in.
ARG CONSUL_VERSION=1.9.6
ARG CONSUL_ARCH=arm64
LABEL org.opencontainers.image.version=$CONSUL_VERSION

# This is the location of the releases.
ENV HASHICORP_RELEASES=https://releases.hashicorp.com

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Create a consul user and group first so the IDs get set the same way, even as
# the rest of this may change over time.
RUN addgroup consul && \
    adduser --system --group consul

# Set up certificates, base tools, and Consul.
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
   ca-certificates \
   curl \
   gnupg \
   unzip \
  && gpg --keyserver pool.sks-keyservers.net --recv-keys C874011F0AB405110D02105534365D9472D7468F \
  && mkdir -p /tmp/build \
  && cd /tmp/build \
  && curl -O ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_${CONSUL_ARCH}.zip \
  && curl -O ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS \
  && curl -O ${HASHICORP_RELEASES}/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_SHA256SUMS.sig \
  && gpg --batch --verify consul_${CONSUL_VERSION}_SHA256SUMS.sig consul_${CONSUL_VERSION}_SHA256SUMS \
  && grep consul_${CONSUL_VERSION}_linux_${CONSUL_ARCH}.zip consul_${CONSUL_VERSION}_SHA256SUMS | sha256sum -c \
  && unzip -d /usr/local/bin consul_${CONSUL_VERSION}_linux_${CONSUL_ARCH}.zip \
  && cd /tmp \
  && rm -rf /tmp/build \
  && gpgconf --kill all \
  && rm -rf /root/.gnupg \
# tiny smoke test to ensure the binary we downloaded runs
  consul version

FROM ubuntu:20.04

# Create a consul user and group first so the IDs get set the same way, even as
# the rest of this may change over time.
RUN addgroup consul && \
    adduser --system --group consul

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    ca-certificates \
    dumb-init \
    gosu \
    iproute2 \
    iptables \
    jq \
    net-tools \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local/bin/consul /usr/local/bin/consul

# The /consul/data dir is used by Consul to store state. The agent will be started
# with /consul/config as the configuration directory so you can add additional
# config files in that location.
RUN mkdir -p /consul/data && \
    mkdir -p /consul/config && \
    chown -R consul:consul /consul

# set up nsswitch.conf for Go's "netgo" implementation which is used by Consul,
# otherwise DNS supercedes the container's hosts file, which we don't want.
RUN test -e /etc/nsswitch.conf || echo 'hosts: files dns' > /etc/nsswitch.conf

# Expose the consul data directory as a volume since there's mutable state in there.
VOLUME /consul/data

# Server RPC is used for communication between Consul clients and servers for internal
# request forwarding.
EXPOSE 8300

# Serf LAN and WAN (WAN is used only by Consul servers) are used for gossip between
# Consul agents. LAN is within the datacenter and WAN is between just the Consul
# servers in all datacenters.
EXPOSE 8301 8301/udp 8302 8302/udp

# HTTP and DNS (both TCP and UDP) are the primary interfaces that applications
# use to interact with Consul.
EXPOSE 8500 8600 8600/udp

# Consul doesn't need root privileges so we run it as the consul user from the
# entry point script. The entry point script also uses dumb-init as the top-level
# process to reap any zombie processes created by Consul sub-processes.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# By default you'll get an insecure single-node development server that stores
# everything in RAM, exposes a web UI and HTTP endpoints, and bootstraps itself.
# Don't use this configuration for production.
CMD ["agent", "-dev", "-client", "0.0.0.0"]
