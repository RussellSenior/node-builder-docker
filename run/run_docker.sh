#!/bin/bash

# change dir to where this script is running
SCRIPT=$(readlink -f "$0")
SDIR=$(dirname "$SCRIPT")
cd $SDIR

. ../docker_vars

#docker stop $NAME;
#docker rm $NAME;

# sleep 3;


DCMD="";

if [ "" != "$1" ];
then
    DCMD=$*;
fi

# --privileged
# --restart=always
# --env-file ${SDIR}/../docker_vars
# 
#       -v ${SDIR}/volumes/staging_dir:/home/openwrt/openwrt/staging_dir

CMD="docker run 
       --rm -i -t 
       -h ${HOST} 
       --name ${NAME} 
       -v ${SDIR}/volumes/bin:/home/openwrt/openwrt/bin
       -v ${SDIR}/volumes/build_dir:/home/openwrt/openwrt/build_dir
       -v ${SDIR}/volumes/downloads:/home/openwrt/openwrt/dl
       ${RUNARGS}
       ${IMAGE} 
       ${DCMD}
";

echo $CMD;

$CMD;



