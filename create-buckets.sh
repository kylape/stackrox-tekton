#!/usr/bin/env bash

for bucket in "go-cache" "go-mod-cache" "npm-cache" "scanner-cache" "scanner-mod-cache"; do
    mc mb minio/$bucket
    for f in $(ls "buckets/$bucket"); do
        mc put "./buckets/$bucket/$f" "minio/$bucket/$f"
    done
done
