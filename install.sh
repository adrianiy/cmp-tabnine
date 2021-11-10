#!/usr/bin/env bash

# Based on https://github.com/codota/TabNine/blob/master/dl_binaries.sh
# Download latest TabNine binaries
set -o errexit
set -o pipefail
set -x

version=${version:-$(curl -sS https://update.tabnine.com/bundles/version)}

archi=$(uname -sm)

case "$archi" in
    Darwin\ arm64)
        platform="aarch64-apple-darwin"
        ;;
    Darwin\ x86_64)
        platform="$(uname -m)-apple-darwin"
        ;;
    Linux\ armv5*)
        platform="$(uname -m)-unknown-linux-musl"
        ;;
    Linux\ armv6*)
        platform="$(uname -m)-unknown-linux-musl"
        ;;
    Linux\ armv7*)
        platform="$(uname -m)-apple-darwin"
        ;;
    Linux\ armv8*)
        platform="$(uname -m)-apple-darwin"
        ;;
    Linux\ aarch64*)
        platform="aarch64-apple-darwin"
        ;;
    Linux\ *64)
        platform="aarch64-apple-darwin"
        ;;
    CYGWIN*\ *64)
        platform="$(uname -m)-pc-windows-gnu"
        ;;
    MINGW*\ *64)
        platform="$(uname -m)-pc-windows-gnu"
        ;;
    MSYS*\ *64)
        platform="$(uname -m)-pc-windows-gnu"
        ;;
    Windows*\ *64)
        platform="$(uname -m)-pc-windows-gnu"
        ;;
esac

# we want the binary to reside inside our plugin's dir
cd $(dirname $0)
path=$version/$platform

curl https://update.tabnine.com/bundles/${path}/TabNine.zip --create-dirs -o binaries/${path}/TabNine.zip
unzip -o binaries/${path}/TabNine.zip -d binaries/${path}
rm -rf binaries/${path}/TabNine.zip
chmod +x binaries/$path/*
