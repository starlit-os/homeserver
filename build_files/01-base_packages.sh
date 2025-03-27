#!/bin/bash

set -oue pipefail

dnf -y install --setopt=install_weak_deps=False \
    'dnf5-command(config-manager)' \
    'dnf5-command(copr)' \
    audit \
    clevis-dracut \
    clevis-pin-tpm2 \
    firewalld \
    gcc \
    pciutils \
    usbutils \
    wireguard-tools

dnf config-manager setopt fedora-cisco-openh264.enabled=0
