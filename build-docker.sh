#!/bin/bash
set -e

PUSH=$1

# This is the official version label for this project.
MAJOR_MINOR=0.2

if [ -z "${CIRCLE_BUILD_NUM}" ]; then
	export BUILD_NUMBER=localbuild
else
	export BUILD_NUMBER=${CIRCLE_BUILD_NUM}
fi

export SEMANTIC_VERSION=${MAJOR_MINOR}-${BUILD_NUMBER}

if [ -z "${DOCKER_IMAGE}" ]; then
	export DOCKER_IMAGE=${REPO_NAME}:${SEMANTIC_VERSION}
fi

rm -rf ./.build
mkdir ./.build
mkdir ./.build/metadata


if [ -z "$GIT_COMMIT" ]; then
	export GIT_COMMIT=$(git rev-parse HEAD)
	export GIT_URL=$(git config --get remote.origin.url)
	export BUILD_DATE=$(date)
fi

if [ -z "$BRANCH_NAME" ]; then
	export BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
fi


docker build \
	-t ${DOCKER_IMAGE} \
	-t ${REPO_NAME}:latest \
	--cache-from ${REPO_NAME}:latest \
	-f Dockerfile .


if [ -d "/caches/" ]; then
	docker save -o /caches/layercache.tar ${REPO_NAME}:latest
fi

echo ${DOCKER_IMAGE}

if [ "${PUSH}" = "push" ]; then
	docker push ${REPO_NAME}
fi
