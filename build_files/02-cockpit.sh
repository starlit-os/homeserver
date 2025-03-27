#!/bin/bash

set -oue pipefail

# Cockpit
dnf -y install cockpit{,-files,-selinux}
