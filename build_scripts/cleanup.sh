#!/usr/bin/env bash

set -euox pipefail

# Image-layer cleanup
shopt -s extglob

# shellcheck disable=SC2115
rm -rf /var/!(cache)
rm -rf /var/cache/!(rpm-ostree)
# Ensure /var/tmp exists, FIXME: remove this once this is fixed upstream
mkdir -p /var/tmp
# Remove gitkeep file if that still is on / for any reason
rm -f /.gitkeep

dnf clean all
ostree container commit

ls /var/log

bootc container lint
