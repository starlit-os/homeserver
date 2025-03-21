#!/usr/bin/env bash

set -xeuo pipefail

# Services

systemctl enable cockpit.socket
systemctl enable tailscaled.service
# systemctl enable docker.service
# systemctl enable docker.socket
systemctl enable incus.socket
systemctl enable incus.service
systemctl enable incus-startup

systemctl disable rpm-ostree-countme.timer

# Don't automatically restart when autoupdating.
sed -i 's/ --apply//' /usr/lib/systemd/system/bootc-fetch-apply-updates.service
