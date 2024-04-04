#!/usr/bin/env bash
set -eu -o pipefail

git clone https://github.com/EdJoPaTo/meeting-countdown build-rust
cd build-rust
git checkout 32e6619e8080e21447b3bf4952a5862149b510ec
rm -rf .git .github

rustup override set 1.77
