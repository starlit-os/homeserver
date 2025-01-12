#!/usr/bin/env bash

set -ouex pipefail

# Required for Logically Bound images, see https://gitlab.com/fedora/bootc/examples/-/tree/main/logically-bound-images/usr/share/containers/systemd
ln -sr /etc/containers/systemd/*.container /usr/lib/bootc/bound-images.d/

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
mv /tmp/cosmos-cloud-*/* /usr/lib/cosmos-cloud
/usr/lib/cosmos-cloud/cosmos service install || true

# Fix group IDs
groupmod -g 250 docker

# Services

systemctl enable cockpit.socket
systemctl disable CosmosCloud.service
systemctl enable docker.service
