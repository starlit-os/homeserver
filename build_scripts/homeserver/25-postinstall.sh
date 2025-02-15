#!/usr/bin/env bash

set -xeuo pipefail

# Fix group IDs
groupmod -g 250 docker
