#!/bin/bash

set -oue pipefail

# Universal Blue stuff
dnf -y copr enable ublue-os/packages
dnf -y install ublue-brew ublue-os-{luks,udev-rules}
dnf -y copr disable ublue-os/packages
