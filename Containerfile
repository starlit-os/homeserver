FROM ghcr.io/starlit-os/base:latest

COPY build.sh /tmp/build.sh

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    bootc container lint
