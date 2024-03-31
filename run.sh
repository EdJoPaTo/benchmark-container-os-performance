#!/usr/bin/env bash
set -eu -o pipefail

echo "untag images"

for version in $(podman image ls --filter=dangling=false --noheading --format="{{.Repository}}:{{.Tag}}" | rg localhost/test); do
	podman image untag "$version" || true
done

echo "build"

podman build -t test:alpine --file=Dockerfile.alpine .
podman build -t test:debian --file=Dockerfile.debian .

podman image ls

echo "do tests"
set -x

# ./bench.sh

podman run --rm --init -it --tmpfs=/tmp test:alpine
podman run --rm --init -it --tmpfs=/tmp test:debian
