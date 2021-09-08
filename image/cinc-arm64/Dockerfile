FROM ubuntu:20.04 AS build

ARG CINC_VERSION=17.4.38
ENV DEBIAN_FRONTEND=noninteractive

ADD http://downloads.cinc.sh/files/stable/cinc/${CINC_VERSION}/ubuntu/20.04/cinc_${CINC_VERSION}-1_arm64.deb /tmp/cinc.deb

FROM ubuntu:20.04

COPY --from=build /tmp/cinc.deb  /tmp/cinc.deb

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  && dpkg -i /tmp/cinc.deb \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*log /var/log/apt/* /var/lib/dpkg/*-old /var/cache/debconf/*-old /tmp/cinc.deb

VOLUME [ "/opt/cinc"]
