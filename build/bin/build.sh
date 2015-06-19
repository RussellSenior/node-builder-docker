#!/bin/bash

# build an openwrt image suitable for uploading to a router

#
# Benjamin Foote
# bfoote@bnf.net
#

function usage() {
    cat <<EOF

    usage:

        $docker run -it ${IMAGE} architecture nodename

        this setup assumes you have a node registered with the ptp-api

        if not, enter one here:
        https://personaltelco.net/datamanager

        for a list of architectures see:
        https://github.com/personaltelco/ptp-cab/tree/master/ptp-node/files

        ex: if your architecture is atheros
        $docker run -it ${IMAGE} atheros nodename

        $1 $2

EOF

    exit;

}

if [ "" = "$1" ];
then
    usage;
fi

ARCH=$1
NODE=$2

function foocab() {
    cd /home/${OWUSER}/ptp-openwrt-files
    perl FOOCAB.pl --node $NODE
    mv output /home/${OWUSER}/openwrt/files

}

function build_openwrt() {
    cd /home/${OWUSER}/openwrt/

    # set proper permissions for docker volumes
    for DIR in bin build_dir dl
    do
        if [ -e $DIR ]
        then
            sudo chown -R ${OWUSER}:${OWUSER} $DIR
            sudo chmod -R 775 $DIR
        fi
    done

    # copy architectur config
    cp feeds/ptpcab/ptp-node/files/.config-${ARCH} ./.config

    # make sure dowload directory stays here
    sed -i 's/CONFIG_DOWNLOAD_FOLDER/#CONFIG_DOWNLOAD_FOLDER/g' .config

    # config and build
    make defconfig
    time make BUILD_LOG=1 IGNORE_ERRORS=m V=99 -j17

    # look for build errors
    for i in $(find logs -name compile.txt) ;
    do
        grep -H --label=$i 'Error ' $i grep -v ignored | awk -F: '{ print $1 }';
    done
}

foocab
build_openwrt
