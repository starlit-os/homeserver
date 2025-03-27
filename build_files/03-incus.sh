#!/bin/bash

# Incus
dnf -y copr enable ganto/umoci
dnf -y install \
    genisoimage \
    incus{,-agent,-client}\
    umoci \
    swtpm
dnf dnf -y copr disable ganto/umoci

groupmod -g 251 incus
groupmod -g 252 incus-admin
