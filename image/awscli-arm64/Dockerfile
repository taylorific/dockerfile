FROM amazonlinux:2 as build

# https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst
ARG AWSCLI_VERSION=2.2.18

RUN yum update -y \
  && yum install -y unzip \
  && curl -o awscliv2.zip -L https://awscli.amazonaws.com/awscli-exe-linux-aarch64-2.2.18.zip \
  && unzip awscliv2.zip \
  # The --bin-dir is specified so that we can copy the
  # entire bin directory from the installer stage into
  # into /usr/local/bin of the final stage without
  # accidentally copying over any other executables that
  # may be present in /usr/local/bin of the installer stage.
  && ./aws/install --bin-dir /aws-cli-bin/

FROM amazonlinux:2
RUN yum update -y \
  && yum install -y less groff \
  && yum clean all
COPY --from=build /usr/local/aws-cli/ /usr/local/aws-cli/
COPY --from=build /aws-cli-bin/ /usr/local/bin/
WORKDIR /aws
ENTRYPOINT ["/usr/local/bin/aws"]
