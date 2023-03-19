#!/bin/sh
set -e

: ${DOCKERHUB_USER:=weaveworks}

echo "Collecting system state..."

echo $DOCKERHUB_USER >../state/dockerhub-user.txt

cat <<EODEB >../state/debian-vesion.txt
# /etc/os-release
$(cat /etc/os-release)

# /etc/debian_version
$(cat /etc/debian_version)
EODEB

docker version >../state/docker-version.txt

docker image inspect $DOCKERHUB_USER/weave-kube:latest >../state/weave-kube-latest-image.json

git rev-parse HEAD >../state/weave-repo-head-hash.txt

go version >../state/go-version.txt

syft $DOCKERHUB_USER/weave-kube:latest >../state/syft-package-list.txt

grype $DOCKERHUB_USER/weave-kube:latest --add-cpes-if-none >../state/grype-vulns-list.txt 

echo "Vulnerable packages: $(cat ../state/grype-vulns-list.txt | tail +3 | wc -l)" >../state/vulnerable-package-count.txt
