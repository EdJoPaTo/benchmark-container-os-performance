#!/usr/bin/env bash
set -eu -o pipefail

shopt -s expand_aliases
type podman &>/dev/null || alias podman=docker

echo "build"

podman build -t test:alpine --file=Dockerfile.alpine .
podman build -t test:debian --file=Dockerfile.debian .

podman image ls

echo "do tests"
set -x

# ./bench.sh

podman run --rm --init -it --tmpfs=/tmp test:alpine
podman run --rm --init -it --tmpfs=/tmp test:debian
