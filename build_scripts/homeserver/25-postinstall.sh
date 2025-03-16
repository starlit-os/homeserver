#!/usr/bin/env bash

set -xeuo pipefail

# Fix group IDs
groupmod -g 250 docker

# Fix libvirt networking
echo "firewall_backend  = \"iptables\"" >> /etc/libvirt/network.conf
