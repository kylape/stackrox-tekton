FROM quay.io/fedora/fedora:43

COPY go1.24.2.linux-amd64.tar.gz /
RUN tar xzf /go1.24.2.linux-amd64.tar.gz 
RUN dnf install -y make git gcc podman zip npm nodejs jq
COPY bundle.zip /
