#!/usr/bin/env bash

function usage() {
    cat <<EOF

    usage:

        docker run -it ${IMAGE} architecture nodename

        this setup assumes you have a node registered with the ptp-api

        if not, enter one here:
        https://personaltelco.net/datamanager

        for a list of architectures see:
        https://github.com/personaltelco/ptp-cab/tree/master/ptp-node/files

        ex: if your architecture is atheros
        docker run -it ${IMAGE} atheros nodename

EOF

    exit
}

[ -z "$1" ] && usage


ARCH=$1
NODE=$2

set -e -x


cd /src/ptp-openwrt-files || exit 2

perl FOOCAB.pl --node "$NODE"
mv output /src/lede/files


cd /src/lede || exit 2

# copy architecture config; make sure dowload directory stays here
sed 's/CONFIG_DOWNLOAD_FOLDER/#CONFIG_DOWNLOAD_FOLDER/g' \
    "feeds/ptpcab/ptp-node/files/.config-${ARCH}" > .config

# config and build
make defconfig
time make BUILD_LOG=1 FORCE_UNSAFE_CONFIGURE=1 IGNORE_ERRORS=m V=99
