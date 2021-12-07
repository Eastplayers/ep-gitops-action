#!/bin/sh -l

set -e

APP_NAME=$1
REPO=$2
PATH=$3
DEST_NAMESPACE=$4
DOCKER_IMAGE=$5
PROJECT=$6
REVISION=${7:-HEAD}
USERNAME=$8
PASSWORD=$9
HOST=${10}

echo $APP_NAME
echo $REPO
echo $PATH
echo $DEST_NAMESPACE
echo $DOCKER_IMAGE
echo $PROJECT
echo $REVISION
echo $USERNAME
echo $PASSWORD
echo $HOST


/usr/bin/argocd login $HOST --username $USERNAME --password $PASSWORD

/usr/bin/argocd app create $APP_NAME \
  --repo $REPO \
  --path $PATH \
  --dest-namespace $DEST_NAMESPACE \
  --dest-server https://kubernetes.default.svc \
  --kustomize-image $DOCKER_IMAGE \
  --sync-policy auto \
  --project default \
  --revision $REVISION
