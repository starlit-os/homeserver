#!/bin/bash

set -ouex pipefail

PACKAGES=(
    cockpit
    #cockpit-machines
    #cockpit-podman
    cockpit-files
    cockpit-selinux
    libvirt
)

# Docker Packages
# dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
# PACKAGES+=(
#     containerd.io
#     docker-buildx-plugin
#     docker-ce
#     docker-ce-cli
#     docker-compose-plugin
# )

# Tailscale Packages
dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
PACKAGES+=(
    tailscale
)

# Incus Packages
dnf copr enable -y ganto/lxc4
dnf copr enable -y ganto/umoci
PACKAGES+=(
    edk2-ovmf
    genisoimage
    incus
    incus-agent
    incus-client
    qemu-char-spice
    qemu-device-display-virtio-vga
    qemu-device-display-virtio-gpu
    qemu-device-usb-redirect
    qemu-img
    qemu-kvm-core
    umoci
    swtpm
)

# CLI utilities
# PACKAGES+=(
#     bat
#     eza
#     fd
#     fish
#     gh
#     micro
#     tealdeer
#     zoxide
# )

dnf -y install "${PACKAGES[@]}"

# Disable repos
dnf config-manager setopt tailscale-stable.enabled=0
#dnf config-manager setopt docker-ce-stable.enabled=0
dnf copr disable ganto/umoci
dnf copr disable ganto/lxc4
