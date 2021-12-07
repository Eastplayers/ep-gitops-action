#!/bin/sh -l

set -e

APP_NAME=$1
REPO=$2
PATH=$3
DEST_NAMESPACE=$4
DOCKER_IMAGE=$5
PROJECT=$6
REVISION=${7:-HEAD}

argocd app create $APP_NAME \
  --repo $REPO \
  --path $PATH \
  --dest-namespace $DEST_NAMESPACE \
  --dest-server https://kubernetes.default.svc \
  --kustomize-image $DOCKER_IMAGE \
  --sync-policy auto \
  --project default \
  --revision $REVISION \
