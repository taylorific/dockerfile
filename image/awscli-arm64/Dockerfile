FROM ubuntu:20.04 as build

# https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst
ARG AWSCLI_VERSION=2.2.18

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
   ca-certificates \
   curl \
   unzip \
  && curl -o awscliv2.zip -L https://awscli.amazonaws.com/awscli-exe-linux-aarch64-2.2.18.zip \
  && unzip awscliv2.zip \
  # The --bin-dir is specified so that we can copy the
  # entire bin directory from the installer stage into
  # into /usr/local/bin of the final stage without
  # accidentally copying over any other executables that
  # may be present in /usr/local/bin of the installer stage.
  && ./aws/install --bin-dir /aws-cli-bin/

FROM ubuntu:20.04

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    ca-certificates \
    groff \
    less \
  && rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=build /aws-cli-bin/ /usr/local/bin/
WORKDIR /aws
ENTRYPOINT ["/usr/local/bin/aws"]
