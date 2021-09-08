FROM busybox AS build

ARG CINC_VERSION=17.4.38
ENV DEBIAN_FRONTEND=noninteractive

ADD http://downloads.cinc.sh/files/stable/cinc/${CINC_VERSION}/el/7/cinc-${CINC_VERSION}-1.el7.x86_64.rpm /tmp/cinc.rpm

FROM busybox

COPY --from=build /tmp/cinc.rpm  /tmp/cinc.rpm

RUN rpm2cpio /tmp/cinc.rpm | cpio -idmv \
  && rm -rf /tmp/cinc.rpm

VOLUME [ "/opt/cinc"]
