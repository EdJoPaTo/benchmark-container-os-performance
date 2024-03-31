#!/usr/bin/env bash
set -eu -o pipefail

git clone https://github.com/EdJoPaTo/meeting-countdown
cd meeting-countdown
git checkout 32e6619e8080e21447b3bf4952a5862149b510ec
rm -rf .git .github
