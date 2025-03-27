#!/bin/bash

set -xeuo pipefail

dnf -y copr enable ublue-os/packages

dnf -y install ublue-brew

# This is required so homebrew works indefinitely.
# Symlinking it makes it so whenever another GCC version gets released it will break if the user has updated it without-
# the homebrew package getting updated through our builds.
# We could get some kind of static binary for GCC but this is the cleanest and most tested alternative. This Sucks.
dnf -y --setopt=install_weak_deps=False install gcc

# Forcefully enable brew setup since the preset doesnt seem to work?
systemctl enable brew-setup.service

