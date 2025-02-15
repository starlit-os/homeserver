ARG MAJOR_VERSION="${MAJOR_VERSION:-stream10}"

FROM ghcr.io/ublue-os/config:latest AS config
FROM ghcr.io/ublue-os/ucore:stable AS ucore
FROM quay.io/centos-bootc/centos-bootc:$MAJOR_VERSION as base

# Install/remove packages to make an image with resembles Fedora CoreOS
COPY build_scripts/build.sh /var/tmp/build.sh
COPY build_scripts/base /var/tmp/build_scripts
RUN --mount=type=bind,from=config,src=/rpms,dst=/tmp/rpms/config \
    --mount=type=bind,from=ucore,src=/usr/lib/systemd,dst=/tmp/ucore/systemd \
    --mount=type=bind,from=ucore,src=/usr/lib/tmpfiles.d,dst=/tmp/ucore/tmpfiles \
    /var/tmp/build.sh && \
    dnf clean all && \
    ostree container commit

# Build the homeserver image
FROM base

COPY build_scripts/build.sh /var/tmp/build.sh
COPY build_scripts/cleanup.sh /var/tmp/cleanup.sh
COPY build_scripts/homeserver /var/tmp/build_scripts
COPY etc /etc

RUN mkdir -p /var/lib/alternatives && \
    /var/tmp/build.sh && \
    /var/tmp/cleanup.sh
