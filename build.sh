#!/usr/bin/env bash

set -ouex pipefail

# Required for Logically Bound images, see https://gitlab.com/fedora/bootc/examples/-/tree/main/logically-bound-images/usr/share/containers/systemd
ln -sr /etc/containers/systemd/*.container /usr/lib/bootc/bound-images.d/

# Packages

dnf install -y cockpit cockpit-machines cockpit-podman cockpit-files

# Incus UI
# curl -Lo /tmp/incus-ui-canonical.deb \
#     https://pkgs.zabbly.com/incus/stable/pool/main/i/incus/"$(curl https://pkgs.zabbly.com/incus/stable/pool/main/i/incus/ | grep -E incus-ui-canonical | cut -d '"' -f 2 | sort -r | head -1)"

# ar -x --output=/tmp /tmp/incus-ui-canonical.deb
# tar --zstd -xvf /tmp/data.tar.zst
# mv /opt/incus /usr/lib/
# sed -i 's@\[Service\]@\[Service\]\nEnvironment=INCUS_UI=/usr/lib/incus/ui/@g' /usr/lib/systemd/system/incus.service

# Services

systemctl enable cockpit.socket
