#!/bin/sh
set -e 

: ${DOCKERHUB_USER:=weaveworks}
: ${IMAGE_VERSION:=latest}

BUILT_IMAGES="$DOCKERHUB_USER/weave $DOCKERHUB_USER/weaveexec $DOCKERHUB_USER/weave-kube $DOCKERHUB_USER/weave-npc $DOCKERHUB_USER/weavedb $DOCKERHUB_USER/network-tester"

for i in $BUILT_IMAGES
do
    docker image rm $i:$IMAGE_VERSION
done