FROM quay.io/fedora/fedora:43

COPY content/go1.24.4.linux-arm64.tar.gz /
COPY content/mc /usr/bin
RUN chmod +x /usr/bin/mc
RUN tar xzf /go1.24.4.linux-arm64.tar.gz
COPY content/bundle.zip /
RUN dnf install -y make git gcc podman zip npm nodejs jq npm nodejs zstd python3 gcc-aarch64-linux-gnu
RUN npm install -g swagger2openapi
