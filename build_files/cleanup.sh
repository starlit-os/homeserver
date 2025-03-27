#!/bin/bash

set -oue pipefail

shopt -s extglob
rm -rf /var/\!\(cache\)
rm -rf /var/cache/\!\(rpm-ostree\)
dnf clean all

rm -rf /var/log/dnf5.log*

bootc container lint
