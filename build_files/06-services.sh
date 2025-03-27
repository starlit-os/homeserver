#!/bin/bash

set -oue pipefail

# Enable services
systemctl enable cockpit.socket
systemctl enable tailscaled.service
systemctl enable incus.socket
systemctl enable incus.service
systemctl enable incus-startup
