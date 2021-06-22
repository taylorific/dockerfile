FROM ubuntu:20.04 AS build

ARG SHELLCHECK_VERSION=v0.7.2

RUN apt-get update \
  && apt-get install --no-install-recommends -y ca-certificates curl xz-utils \
  && curl -LO https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz \
  && tar -xf shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz --wildcards '*/shellcheck' --strip-components=1 \
  && rm -rf /var/lib/apt/lists/*

FROM scratch
COPY --from=build /shellcheck /usr/local/bin/shellcheck
CMD ["shellcheck"]
