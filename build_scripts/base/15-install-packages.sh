#!/usr/bin/env bash

set -euox pipefail

# This thing slows down downloads A LOT for no reason
dnf remove -y subscription-manager

# The base images take super long to update, this just updates manually for now
dnf -y update
dnf -y install 'dnf-command(versionlock)'
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt

dnf config-manager --set-enabled crb
dnf -y install epel-release

# add some packages present in Fedora CoreOS but not CentOS bootc
dnf -y install --setopt=install_weak_deps=False \
  audit \
  clevis-dracut \
  clevis-pin-tpm2 \
  firewalld \
  git-core \
  hwdata \
  iscsi-initiator-utils \
  rsync \
  ssh-key-dir \
  wireguard-tools
# TODO: Add runc when it's available in EPEL

# Install some additional useful packages
dnf -y install \
  usbutils \
  pciutils
