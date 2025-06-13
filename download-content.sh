#!/usr/bin/bash

mkdir -p content
cd content


if [ $(uname -m) = x86_64 ]; then
    curl https://dl.min.io/client/mc/release/linux-amd64/mc -L > mc
    curl https://go.dev/dl/go1.24.4.linux-amd64.tar.gz -L > go.tar.gz
fi

if [ $(uname -m) = aarch64 ]; then 
    curl https://dl.min.io/client/mc/release/linux-arm64/mc -L > mc
    curl https://go.dev/dl/go1.24.4.linux-arm64.tar.gz -L > go.tar.gz
fi

chmod +x mc

# This assumes the bundle has alread been placed here by hand for now at least
./mc alias set minio http://minio:9000 minioadmin minioadmin
./mc get minio/bundle/bundle.zip .
