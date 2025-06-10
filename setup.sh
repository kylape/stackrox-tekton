#!/bin/bash

kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
kubectl patch configmap feature-flags -n tekton-pipelines --type='merge' -p='{"data":{"disable-affinity-assistant":"true"}}' # for KinD
kubectl -n tekton-pipelines wait --for=condition=Available deploy/tekton-pipelines-webhook
tkn hub install task git-clone
tkn hub install task buildah
kubectl create -f resources/task-fetch-cache.yaml -f resources/task-put-cache.yaml
kubectl create -f resources/pvc-minio.yaml -f resources/deploy-minio.yaml
kubectl expose deploy/minio --port 9000 --name minio
kubectl create -f resources/pipeline.yaml
