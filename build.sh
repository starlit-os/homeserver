#!/bin/bash

set -oue pipefail

container_name="$1"
container_tag="$2"
upstream="$3"
extra_tags="$4"

container=$(buildah from --pull=newer \
    --volume $(pwd)/build_files:/build_files:O \
    "quay.io/fedora/$upstream")

buildah copy $container system_files /

for filename in build_files/*-*.sh; do
    echo "===$(basename "$filename" ".sh")==="
    buildah run \
        --mount=type=cache,dst=/var/cache \
        --mount=type=cache,dst=/var/log \
        --mount=type=tmpfs,dst=/tmp \
        $container /build_files/$(basename "$filename")
done

buildah run $container /build_files/cleanup.sh

buildah commit --rm $container $container_name:$container_tag

for extra_tag in $extra_tags; do
  buildah tag $container_name $container_name:$extra_tag
done
