#!/bin/bash

RELEASE_TYPE=$1
echo "Logging into Dockerhub ..."
echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin

echo "Determining image tag for ${BRANCH_NAME} build ..."

if [[ $RELEASE_TYPE == "release" ]]; then
    export TAGGED_IMAGE="smartcolumbusos/scos-kube-bench:${BRANCH_NAME}"
elif [[ $RELEASE_TYPE == "master" ]]; then
    export TAGGED_IMAGE="smartcolumbusos/scos-kube-bench:development"
else
    echo "Branch should not be pushed to Dockerhub"
    exit 0
fi


echo "Pushing to Dockerhub with tag ${TAGGED_IMAGE} ..."

docker build . -t "${TAGGED_IMAGE}"
docker push "${TAGGED_IMAGE}"
