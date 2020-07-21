#!/bin/bash

rm -r python/

IMAGE_NAME=${1:-"lambci/lambda:build-python3.8"}
PACKAGES_PATH=${2:-"python/lib/python3.8/site-packages"}

CONTAINER_ID=$(docker create \
        --volume $PWD/requirements.txt:/src/requirements.txt \
        --workdir /src \
        ${IMAGE_NAME} \
        /bin/bash -c "pip install --no-deps -r /src/requirements.txt -t $PACKAGES_PATH;")
docker start --attach $CONTAINER_ID
docker cp $CONTAINER_ID:/src/python python
docker rm $CONTAINER_ID

find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
rm -r ${PACKAGES_PATH}/pandas/tests
rm -r ${PACKAGES_PATH}/numpy/tests