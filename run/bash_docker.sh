#!/bin/bash

cd "$( dirname "${BASH_SOURCE[0]}" )";

. ../docker_vars

docker stop ${NAME}-bash;
docker rm ${NAME}-bash;

docker run \
       -t -i  \
       -h ${HOST}-bash \
       --name ${NAME}-bash \
       -e TERM=xterm \
       -v ${SDIR}/volumes/bin:/home/openwrt/openwrt/bin
       -v ${SDIR}/volumes/build_dir:/home/openwrt/openwrt/build_dir
       -v ${SDIR}/volumes/downloads:/home/openwrt/openwrt/dl
       -v ${SDIR}/volumes/staging_dir:/home/openwrt/openwrt/staging_dir
       --entrypoint /bin/bash \
      ${IMAGE}  



