#!/bin/sh -l

# echo "Hello $1"
set -e

K8S_SERVER_URL=$1
K8S_TOKEN=$2
K8S_DEPLOYMENT=$3
K8S_IMAGE_NAME=$4
K8S_NAMESPACE=$5
K8S_CONTAINER_NAME=${6:-app}

KUBECTL=kubectl


time=$(date)
echo "::set-output name=time::$time"
if ! test -z "$K8S_IMAGE_NAME"
then
  RESULT="$($KUBECTL \
    --insecure-skip-tls-verify \
    --kubeconfig="/dev/null" \
    --server=${K8S_SERVER_URL} \
    --token=${K8S_TOKEN} \
    set image deployment/${K8S_DEPLOYMENT} \
    ${K8S_CONTAINER_NAME}=${K8S_IMAGE_NAME} \
    -n ${K8S_NAMESPACE} \
    --record)"
  echo $RESULT
else
  RESULT_RESTART="$($KUBECTL \
    --insecure-skip-tls-verify \
    --kubeconfig="/dev/null" \
    --server=${K8S_SERVER_URL} \
    --token=${K8S_TOKEN} \
    rollout \
    restart \
    deployment/${K8S_DEPLOYMENT} \
    -n ${K8S_NAMESPACE})"
fi


