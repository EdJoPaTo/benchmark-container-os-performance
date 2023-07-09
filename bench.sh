#!/usr/bin/env bash
set -eu

hyperfine --style full \
    'ffmpeg -y -v error -i /tmp/in.webm -c copy -codec:v libx264 -t 0:15 -f mp4 /dev/null' \
    'ffmpeg -y -v error -i /tmp/in.webm -c copy -codec:v libx265 -t 0:15 -f mp4 /dev/null'

# . "$HOME/.cargo/env"
# cd /build

# # Dev
# hyperfine --warmup 1 'touch src/main.rs && cargo build'

# # Release
# hyperfine 'cargo clean && cargo build --release'
