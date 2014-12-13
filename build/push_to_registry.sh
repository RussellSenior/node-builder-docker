#!/bin/bash


function usage() {

    cat <<EOF

       $0 

       tags the image as 
               docker tag ${IMAGE} ${DREG}/${IMAGE}:${VERSION};

       push it to the public registry at https://registry.hub.docker.com/repos/personaltelco/

EOF
    exit;
}


CURDIR=${PWD}


SCRIPT=$(readlink -f "$0")
SDIR=$(dirname "$SCRIPT")
cd $SDIR

. ../docker_vars

DREG="";

if [ "" != "${1}" ];
then
    DREG=${1}
    docker tag ${IMAGE} ${DREG}/${IMAGE};
    IMAGE="${DREG}/${IMAGE}"
fi

echo "pushing ${IMAGE}";
docker push ${IMAGE};
