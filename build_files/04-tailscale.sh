#!/bin/bash

set -oue pipefail

# Tailscale
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf -y install tailscale
dnf config-manager setopt tailscale-stable.enabled=0
