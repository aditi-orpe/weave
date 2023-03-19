#!/bin/sh
set -e 

: ${DOCKERHUB_USER:=weaveworks}
: ${IMAGE_VERSION:=2.8.2}

BUILT_IMAGES="$DOCKERHUB_USER/weave $DOCKERHUB_USER/weaveexec $DOCKERHUB_USER/weave-kube $DOCKERHUB_USER/weave-npc $DOCKERHUB_USER/weavedb $DOCKERHUB_USER/network-tester"

for i in $BUILT_IMAGES
do
    docker image tag $i:latest  $i:$IMAGE_VERSION
done