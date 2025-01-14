#!/usr/bin/env bash

set -ouex pipefail

# Packages

dnf install -y cockpit cockpit-machines cockpit-podman cockpit-files unzip

# Docker install: https://docs.docker.com/engine/install/centos/#install-using-the-repository
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Cosmos
curl -L $(curl -s https://api.github.com/repos/azukaar/Cosmos-Server/releases/latest | \
    sed 's/[()",{}]/ /g; s/ /\n/g' | grep "https.*releases/download.*amd64.zip$") \
    -o /tmp/cosmos-server.zip
mkdir /usr/lib/cosmos-cloud
unzip /tmp/cosmos-server.zip -d /tmp
mv /tmp/cosmos-cloud-*/* /var/lib/cosmos-cloud

# Fix group IDs
groupmod -g 250 docker

# Services

systemctl enable cockpit.socket
systemctl enable docker.service

# switch to server profile to allow cockpit by default
cp -a /etc/firewalld/firewalld-server.conf /etc/firewalld/firewalld.conf
