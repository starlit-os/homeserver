#!/usr/bin/env bash

set -euox pipefail

# apply CoreOS overlays
cd /tmp/
git clone https://github.com/coreos/fedora-coreos-config
cd fedora-coreos-config
git checkout stable
cd overlay.d
# zincati should not even exist in a bootc image
rm -fr 16disable-zincati
# now try to apply
for od in $(find * -maxdepth 0 -type d); do
  pushd ${od}
  find * -maxdepth 0 -type d -exec rsync -av ./{}/ /{}/ \;
  if [ -f statoverride ]; then
    for line in $(grep ^= statoverride|sed 's/ /=/'); do
      DEC=$(echo $line|cut -f2 -d=)
      OCT=$(printf %o ${DEC})
      FILE=$(echo $line|cut -f3 -d=)
      chmod ${OCT} ${FILE}
    done
  fi
  popd
done
