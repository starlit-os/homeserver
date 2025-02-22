#!/usr/bin/env bash

set -euox pipefail

# Fix some missing directories and files
# mkdir -p /var/lib/rpm-state
# touch /var/lib/rpm-state/nfs-server.cleanup

# remove some packages present in CentOS bootc but not Fedora CoreOS
dnf -y remove \
  gssproxy \
  nfs-utils \
  quota \
  quota-nls
