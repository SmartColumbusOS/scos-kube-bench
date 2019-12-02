#!/bin/bash

RELEASE_TYPE=$1
echo "Logging into Dockerhub ..."
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin

echo "Determining image tag for ${TRAVIS_BRANCH} build ..."

if [[ $RELEASE_TYPE == "release" ]]; then
    export TAGGED_IMAGE="smartcolumbusos/scos-kube-bench:${TRAVIS_BRANCH}"
elif [[ $RELEASE_TYPE == "master" ]]; then
    export TAGGED_IMAGE="smartcolumbusos/scos-kube-bench:development"
else
    echo "Branch should not be pushed to Dockerhub"
    exit 0
fi

echo "Pushing to Dockerhub with tag ${TAGGED_IMAGE} ..."

docker tag scos-kube-bench:build "${TAGGED_IMAGE}"
docker push "${TAGGED_IMAGE}"

helm upgrade --install ./chart --set image="${TAGGED_IMAGE}"