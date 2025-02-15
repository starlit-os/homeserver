#!/usr/bin/env bash

set -xeuo pipefail

# The hyperscale SIG's kernel straight from their official builds

dnf -y install centos-release-hyperscale-kernel
dnf config-manager --set-disabled "centos-hyperscale,centos-hyperscale-kernel"
dnf versionlock delete kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt
dnf --enablerepo="centos-hyperscale" --enablerepo="centos-hyperscale-kernel" -y update kernel
dnf versionlock add kernel kernel-devel kernel-devel-matched kernel-core kernel-modules kernel-modules-core kernel-modules-extra kernel-uki-virt
