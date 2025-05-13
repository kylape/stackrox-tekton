FROM quay.io/fedora/fedora:43

COPY go1.24.2.linux-amd64.tar.gz /
RUN tar xzf /go1.24.2.linux-amd64.tar.gz 
COPY bundle.zip /
RUN dnf install -y make git gcc podman zip npm nodejs jq npm nodejs
RUN npm install -g swagger2openapi
