#!/usr/bin/env bash

set -euox pipefail

# remove some packages present in CentOS bootc but not Fedora CoreOS
REMOVE_PACKAGES=(
    gssproxy
    nfs-utils
    quota
    quota-nls
)
dnf -y remove "${REMOVE_PACKAGES[@]}"
