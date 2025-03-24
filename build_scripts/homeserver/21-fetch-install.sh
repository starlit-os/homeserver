#!/bin/bash

set -ouex pipefail

# Manually install chezmoi
pushd /usr
sh -c "$(curl -fsLS get.chezmoi.io)"
popd

# Manually install starship
curl --retry 3 -Lo /tmp/starship.tar.gz "https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz"
tar -xzf /tmp/starship.tar.gz -C /tmp
install -c -m 0755 /tmp/starship /usr/bin
