#!/bin/sh
set -e

# These were the parameters used to create the last known good weave images
#   weaveworks/weave-*:2.8.1 or weaveworks/weave-*:latest
: ${DOCKERHUB_USER:=weaveworks}
: ${ALPINE_BASEIMAGE:=alpine:3.10}

echo "Building locally..."

make -C ../.. BUILD_IN_CONTAINER=false DOCKERHUB_USER=$DOCKERHUB_USER ALPINE_BASEIMAGE=$ALPINE_BASEIMAGE