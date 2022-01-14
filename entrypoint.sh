#!/bin/sh -l

set -e

GIT_TOKEN=$4
GIT_REPO=$5

TAG=$1
DEPLOYMENT_DIR=$2

IMAGE_REPO=$3
BRANCH=${6:master}
MATCH=$7

GIT_REPO_URL="https://pepepot:$GIT_TOKEN@$GIT_REPO"

git clone $GIT_REPO_URL

cd hsv-ops

ls -la
sed "s/$MATCH/$TAG/g" $DEPLOYMENT_DIR
sed -i "s/$MATCH/$TAG/g" $DEPLOYMENT_DIR

git config --global user.name "pepepot"
git config --global user.email "ops@eastplayers.io"
git config --global color.ui true

git add $DEPLOYMENT_DIR
git commit -m "[ci] PROD Update $IMAGE_REPO to $TAG"
git push origin $BRANCH
