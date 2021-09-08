FROM ubuntu:20.04 AS build

ARG CINC_WORKSTATION_VERSION=21.8.555
ENV DEBIAN_FRONTEND=noninteractive

ADD http://downloads.cinc.sh/files/unstable/cinc-workstation/${CINC_WORKSTATION_VERSION}/ubuntu/20.04/cinc-workstation_${CINC_WORKSTATION_VERSION}-1_amd64.deb /tmp/cinc-workstation.deb

FROM ubuntu:20.04

ENV PATH="/opt/cinc-workstation/bin:/root/.chefdk/gem/ruby/3.0.0/bin:/opt/cinc-workstation/embedded/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/cinc-workstation/gitbin" \
    GEM_ROOT="/opt/cinc-workstation/embedded/lib/ruby/gems/3.0.0" \
    GEM_HOME="/root/.chefdk/gem/ruby/3.0.0" \
    GEM_PATH="/root/.chefdk/gem/ruby/3.0.0:/opt/cinc-workstation/embedded/lib/ruby/gems/3.0.0"


# Run the entire container with the default locale to be en_US.UTF-8
RUN apt-get update \
  && apt-get install -y locales \
  && locale-gen en_US.UTF-8 \
  && update-locale LANG=en_US.UTF-8 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

COPY --from=build /tmp/cinc-workstation.deb  /tmp/cinc-workstation.deb
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    curl \
    gcc \
    git \
    graphviz \
    make \
    rsync \
    ssh \
    vim-tiny \
  && ln -s /usr/bin/vi /usr/bin/vim \
  && dpkg -i /tmp/cinc-workstation.deb \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*log /var/log/apt/* /var/lib/dpkg/*-old /var/cache/debconf/*-old

CMD ["/bin/bash"]
