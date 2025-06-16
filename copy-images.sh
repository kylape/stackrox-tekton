#!/usr/bin/bash

TAG=4.7.4-3

podman login registry.redhat.io

for image in "scanner-db" "scanner-v4-db" "central-db"; do
    skopeo copy docker://registry.redhat.io/advanced-cluster-security/rhacs-$image-rhel8:$TAG docker://kind-registry:5000/stackrox/$image:latest --dest-tls-verify=false
done

