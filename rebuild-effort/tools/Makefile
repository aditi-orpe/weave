DOCKERHUB_USER ?= rajchaudhuri
IMAGE_VERSION ?= 2.8.3-beta6
ALPINE_BASEIMAGE ?= alpine:3.17.2

# Targets
usage:
	echo "Usage: make state|build|push|clean"

../state/*.txt ../state/*.json: generate-state.sh 
	./generate-state.sh

.PHONY: state
state: ../state/*.txt ../state/*.json

.PHONY: clean
clean:
	rm -f build.uptodate
	rm -rf ../state/*
	make -C ../.. clean BUILD_IN_CONTAINER=false DOCKERHUB_USER=$(DOCKERHUB_USER) ALPINE_BASEIMAGE=$(ALPINE_BASEIMAGE)
	DOCKERHUB_USER=$(DOCKERHUB_USER) IMAGE_VERSION=$(IMAGE_VERSION) ./rm-local-images.sh

build.uptodate: build-local.sh ../../weave ../../go.mod ../../go.sum
	DOCKERHUB_USER=$(DOCKERHUB_USER) ALPINE_BASEIMAGE=$(ALPINE_BASEIMAGE) ./build-local.sh
	DOCKERHUB_USER=$(DOCKERHUB_USER) ./generate-state.sh
	DOCKERHUB_USER=$(DOCKERHUB_USER) IMAGE_VERSION=$(IMAGE_VERSION) ./retag-images.sh
	touch $@

.PHONY: build
build: build.uptodate

.PHONY: push
push:
	DOCKERHUB_USER=$(DOCKERHUB_USER) IMAGE_VERSION=$(IMAGE_VERSION) ./push-local-images.sh
