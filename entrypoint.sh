#!/bin/sh -l

set -e

TAG=$1
DEPLOYMENT_DIR=$2
IMAGE_REPO=$3
GIT_TOKEN=$4
GIT_REPO=$5

GIT_REPO_URL="https://pepepot:$GIT_TOKEN@$GIT_REPO"

git clone $GIT_REPO_URL
cd hsv-ops

sed -i "s/0.1.*/0.1.$TAG/g" $DEPLOYMENT_DIR

git config --global user.name "pepepot"
git config --global user.email "ops@eastplayers.io"
git config --global color.ui true
git add $DEPLOYMENT_DIR
git commit -m "[ci] PROD Update $IMAGE_REPO to $TAG"
git push origin main
