#!/usr/bin/env bash

set -xeuo pipefail

cat >/usr/lib/bootc/kargs.d/00-vfio.toml <<EOF
kargs = ["intel_iommu=on", "iommu=pt"]
match-architectures = ["x86_64"]
EOF

KERNEL_SUFFIX=""
QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//')"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v -f
