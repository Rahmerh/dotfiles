#!/bin/sh
# Script is modified version of the project's README: https://github.com/GloriousEggroll/proton-ge-custom?tab=readme-ov-file#installation

set -euo pipefail

STEAM_PROTON_FOLDER="$HOME/.steam/root/compatibilitytools.d"

if [ -d /tmp/proton-ge-custom ]; then
    sudo rm -rf /tmp/proton-ge-custom
fi

mkdir /tmp/proton-ge-custom
cd /tmp/proton-ge-custom

echo "Downloading tarball"
curl -sLOJ "$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | grep .tar.gz)"
echo "Done"

echo "Downloading checksum"
curl -sLOJ "$(curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest | grep browser_download_url | cut -d\" -f4 | grep .sha512sum)"
echo "Done"

sha512sum -c ./*.sha512sum

if ! [ -d "$STEAM_PROTON_FOLDER" ]; then
    mkdir -p ~/.steam/root/compatibilitytools.d
fi

CURRENT_VERSION_FULL_PATH=$(find $STEAM_PROTON_FOLDER -maxdepth 1 -type d -name 'GE-Proton*' -print -quit | head -n1)
CURRENT_VERSION=$(basename "$CURRENT_VERSION_FULL_PATH" .tar.gz)

VERSION_TO_INSTALL_FULL_PATH=$(find /tmp/proton-ge-custom -maxdepth 1 -type f -name 'GE-Proton*' -print -quit | head -n1)
VERSION_TO_INSTALL=$(basename "$VERSION_TO_INSTALL_FULL_PATH" .tar.gz)

if [ "$VERSION_TO_INSTALL" == "$CURRENT_VERSION" ]; then
    echo "Nothing to do, latest version of proton ge already installed. Exiting."
    exit 0
fi

sudo rm -rf "$CURRENT_VERSION_FULL_PATH"

echo "Extracting tarball"
tar -xf GE-Proton*.tar.gz -C ~/.steam/root/compatibilitytools.d/

echo "Latest proton GE installed."
