#!/bin/bash

set -xeuo pipefail

# This is a bucket list. We want to not have anything in this file at all.

# enable systemd-resolved for proper name resolution
systemctl enable systemd-resolved.service

# Copy ucore workaround services and enable them
cp /tmp/ucore/systemd/system/{libvirt,swtpm}-workaround.service /usr/lib/systemd/system/
cp /tmp/ucore/tmpfiles/{libvirt,swtpm}-workaround.conf /usr/lib/tmpfiles.d/
cp /tmp/ucore/systemd/system/ucore-paths-provision.service /usr/lib/systemd/system/
cp /tmp/ucore/etc/systemd/ucore-paths-provision.conf /etc/systemd/
cp /tmp/ucore/sbin/ucore-paths-provision.sh /usr/sbin/

systemctl enable libvirt-workaround.service
systemctl enable swtpm-workaround.service
systemctl enable ucore-paths-provision.service
