#!/usr/bin/env bash

set -xeuo pipefail

# Services

systemctl enable cockpit.socket
systemctl enable tailscaled.service
systemctl enable docker.service
systemctl enable docker.socket
systemctl disable rpm-ostree-countme.timer

# enable systemd-resolved for proper name resolution
systemctl enable systemd-resolved.service

# Enable ucore workaround services
systemctl enable libvirt-workaround.service

# Don't automatically restart when autoupdating.
sed -i 's/ --apply//' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
