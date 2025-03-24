#!/usr/bin/env bash

set -xeuo pipefail

# Fix group IDs
groupmod -g 250 docker
groupmod -g 251 incus
groupmod -g 252 incus-admin

# Fix libvirt networking
echo "firewall_backend  = \"iptables\"" >> /etc/libvirt/network.conf
