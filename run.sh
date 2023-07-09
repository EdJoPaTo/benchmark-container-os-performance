#!/usr/bin/env bash
set -eu

alpines=(
	3.13
	3.17
	3.18
)

debians=(
	bookworm-slim
	experimental
)

targets=()

echo "untag images"

for version in $(podman image ls --filter=dangling=false --noheading --format="{{.Repository}}:{{.Tag}}" | rg localhost); do
	podman image untag "$version" || true
done

echo "build"

for version in "${debians[@]}"; do
	tag="debian-$version"
	podman build \
		-f "Dockerfile.debian" --build-arg "VERSION=$version" \
		-t "test:$tag" .
	targets+=("$tag")
done

for version in "${alpines[@]}"; do
	tag="alpine-$version"
	podman build \
		-f "Dockerfile.alpine" --build-arg "VERSION=$version" \
		-t "test:$tag" .
	targets+=("$tag")
done

podman image ls

echo "do tests"

# ./bench.sh

for tag in "${targets[@]}"; do
	echo
	echo
	echo "test $tag"
	podman run --mount=type=bind,source=/tmp/in.webm,destination=/tmp/in.webm "test:$tag"
done
