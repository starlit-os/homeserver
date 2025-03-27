ARG MAJOR_VERSION="${MAJOR_VERSION:-41}"

FROM quay.io/fedora/fedora-bootc:$MAJOR_VERSION

COPY system_files /

# gcc is required so homebrew works indefinitely.
# Symlinking it makes it so whenever another GCC version gets released it will break if the user has updated it without-
# the homebrew package getting updated through our builds.
# We could get some kind of static binary for GCC but this is the cleanest and most tested alternative. This Sucks.
RUN dnf -y install --setopt=install_weak_deps=False \
    'dnf5-command(config-manager)' \
    'dnf5-command(copr)' \
    audit \
    clevis-dracut \
    clevis-pin-tpm2 \
    firewalld \
    gcc \
    pciutils \
    usbutils \
    wireguard-tools && \
    dnf config-manager setopt fedora-cisco-openh264.enabled=0

# Cockpit
RUN dnf -y install cockpit{,-files,-selinux}

# Incus
RUN dnf -y copr enable ganto/lxc4 && dnf -y copr enable ganto/umoci && \
    dnf -y install \
    genisoimage \
    incus{,-agent,-client}\
    umoci \
    swtpm && \
    dnf -y copr disable ganto/lxc4 && dnf -y copr disable ganto/umoci && \
    groupmod -g 251 incus && groupmod -g 252 incus-admin

# Tailscale
RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo && \
    dnf -y install tailscale && \
    dnf config-manager setopt tailscale-stable.enabled=0

# Universal Blue stuff
RUN dnf -y copr enable ublue-os/packages && \
    dnf -y install ublue-brew ublue-os-{luks,udev-rules} && \
    dnf -y copr disable ublue-os/packages

# Enable services
# Don't automatically restart when autoupdating (TODO: Remove when everything is migrated to incus).
RUN systemctl enable cockpit.socket && \
    systemctl enable tailscaled.service && \
    systemctl enable incus.socket && \
    systemctl enable incus.service && \
    systemctl enable incus-startup && \
    sed -i 's/ --apply//' /usr/lib/systemd/system/bootc-fetch-apply-updates.service

RUN KERNEL_SUFFIX="" && \
    QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')" && \
    /usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v -f

RUN shopt -s extglob && \
    rm -rf /var/\!\(cache\) && \
    rm -rf /var/cache/\!\(rpm-ostree\) && \
    dnf clean all && \
    rm -rf /var/log/dnf5.log*

RUN bootc container lint
