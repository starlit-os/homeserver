#!/bin/bash

set -ouex pipefail

# Packages
dnf install -y grubby

dnf install -y avahi cockpit cockpit-machines cockpit-podman cockpit-files libvirt firewalld

# Docker install: https://docs.docker.com/engine/install/centos/#install-using-the-repository
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Tailscale
dnf config-manager --add-repo https://pkgs.tailscale.com/stable/centos/10/tailscale.repo
dnf config-manager --set-disabled tailscale-stable
dnf -y --enablerepo tailscale-stable install \
  tailscale
