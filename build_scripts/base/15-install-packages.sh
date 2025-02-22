#!/usr/bin/env bash

set -euox pipefail

dnf -y install 'dnf5-command(versionlock)'
dnf -y install 'dnf5-command(config-manager)'
dnf config-manager setopt fedora-cisco-openh264.enabled=0
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt
dnf -y update

# Install ublue-os stuff
dnf install -y \
    /tmp/rpms/config/ublue-os-{luks,udev-rules}.noarch.rpm

# add some packages present in Fedora CoreOS but not CentOS bootc
dnf -y install --setopt=install_weak_deps=False \
  afterburn \
  afterburn-dracut \
  audit \
  authselect \
  clevis-dracut \
  clevis-pin-tpm2 \
  coreos-installer \
  coreos-installer-bootinfra \
  firewalld \
  git-core \
  hwdata \
  ignition \
  ipcalc \
  iscsi-initiator-utils \
  nfs-utils-coreos \
  rsync \
  runc \
  ssh-key-dir \
  wireguard-tools
# TODO: Add these if/when available
# NetworkManager-team \

# Install some additional useful packages
dnf -y install \
  usbutils \
  pciutils
