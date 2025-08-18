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

# Run the benchmarks on the host system
# ./bench.sh

podman run --rm --init -it --tmpfs=/tmp test:alpine
podman run --rm --init -it --tmpfs=/tmp test:debian

podman run --rm --init -it \
	--mount type=bind,source=./savegame.zip,destination=/factorio/saves/savegame.zip \
	--entrypoint=/opt/factorio/bin/x64/factorio \
	docker.io/factoriotools/factorio:2.0.60 \
	--benchmark /factorio/saves/savegame.zip
