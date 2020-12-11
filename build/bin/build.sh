#!/usr/bin/env bash

function usage() {
    cat <<EOF

    usage:

        docker run -it ${IMAGE} device nodename

        this setup assumes you have a node registered with the ptp-api

        if not, enter one here:
        https://personaltelco.net/datamanager

        for a list of devices see:
        https://github.com/personaltelco/ptp-cab/tree/master/ptp-node/files

        ex: if your device is a TPLink TL-WDR3600:
        docker run -it ${IMAGE} WDR3600 nodename

EOF

    exit
}

[ -z "$1" ] && usage


DEVICE=$1
NODE=$2

set -e -x


cd /src/ptp-openwrt-files || exit 2

perl FOOCAB.pl --node "$NODE"
mv output /src/openwrt/files


cd /src/openwrt || exit 2

# copy device config; make sure dowload directory stays here
sed 's/CONFIG_DOWNLOAD_FOLDER/#CONFIG_DOWNLOAD_FOLDER/g' \
    "feeds/ptpcab/ptp-node/files/.config-${DEVICE}" > .config

# config and build
make defconfig
time make BUILD_LOG=1 FORCE_UNSAFE_CONFIGURE=1 IGNORE_ERRORS=m V=99
