#!/bin/bash

set -xe
set -o pipefail

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl patch configmap feature-flags -n tekton-pipelines --type='merge' -p='{"data":{"disable-affinity-assistant":"true"}}' # for KinD

kubectl create -f resources/minio
kubectl expose deploy/minio --port 9000 --name minio
sleep 1
kubectl wait --for=condition=Available deploy/minio

mc alias set minio http://minio.default.svc:9000 minioadmin minioadmin
mc mb minio/cache
