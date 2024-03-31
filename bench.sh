#!/usr/bin/env bash
set -eu -o pipefail

wget -O '/tmp/in.webm' 'https://cdn.media.ccc.de/congress/2017/webm-sd/34c3-8710-deu-eng-Relativitaetstheorie_fuer_blutige_Anfaenger_webm-sd.webm'

hyperfine 'ffmpeg -y -v error -i /tmp/in.webm -c copy -codec:v libx264 -t 0:15 -f mp4 /dev/null'
hyperfine 'ffmpeg -y -v error -i /tmp/in.webm -c copy -codec:v libx265 -t 0:15 -f mp4 /dev/null'

cd meeting-countdown

hyperfine --warmup 1 'touch src/main.rs && cargo build'
hyperfine 'cargo clean && cargo build --release'
