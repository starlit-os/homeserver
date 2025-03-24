#!/usr/bin/env bash

set -xeuo pipefail

# Fix group IDs
groupmod -g 250 docker
groupmod -g 251 incus
groupmod -g 252 incus-admin

# Manually install chezmoi
pushd /usr/bin
sh -c "$(curl -fsLS get.chezmoi.io)"
popd

# Fix libvirt networking
echo "firewall_backend  = \"iptables\"" >> /etc/libvirt/network.conf
