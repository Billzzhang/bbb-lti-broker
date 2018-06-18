#!/bin/bash

account="bigbluebutton"
if [[ -n "$1" ]]; then
    account=$1
    account=${account##*:}
    account=${account%%/*}
fi

tag="latest"
if [[ -n "$2" ]]; then
    tag=$2
fi

image="$account/lti_tool_provider:$tag"

echo "Building $image ..."
docker build -t $image .

echo "Publishing $image ..."
docker login -u $DOCKER_USER -p $DOCKER_PASS
docker push $image

docker logout
