#!/bin/bash

set -ouex pipefail

# Packages
dnf install -y avahi cockpit cockpit-machines cockpit-podman cockpit-files libvirt firewalld

# CLI stuff
dnf install -y fish

# Docker install: https://docs.docker.com/engine/install/centos/#install-using-the-repository
dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
dnf install -y docker-ce docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf config-manager setopt tailscale-stable.enabled=0
dnf -y --enablerepo tailscale-stable install \
  tailscale
