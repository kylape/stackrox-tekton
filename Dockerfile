FROM quay.io/fedora/fedora:43

COPY go1.24.2.linux-amd64.tar.gz /
COPY mc /usr/bin
RUN chmod +x /usr/bin/mc
RUN tar xzf /go1.24.2.linux-amd64.tar.gz 
COPY bundle.zip /
RUN dnf install -y make git gcc podman zip npm nodejs jq npm nodejs zstd
RUN npm install -g swagger2openapi
