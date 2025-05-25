FROM quay.io/fedora/fedora:43

COPY content/go1.24.2.linux-amd64.tar.gz /
COPY content/mc /usr/bin
RUN chmod +x /usr/bin/mc
RUN tar xzf /go1.24.2.linux-amd64.tar.gz 
COPY content/bundle.zip /
RUN dnf install -y make git gcc podman zip npm nodejs jq npm nodejs zstd python3
RUN npm install -g swagger2openapi

RUN curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" > /usr/bin/kubectl && chmod +x /usr/bin/kubectl
RUN VERSION=$(curl https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt) \
    curl -L https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/virtctl-${VERSION}-linux-amd64 > /usr/bin/virtctl && \
    chmod +x /usr/bin/virtctl
RUN dnf install -y https://github.com/tektoncd/cli/releases/download/v0.41.0/tektoncd-cli-0.41.0_Linux-64bit.rpm
RUN dnf install -y neovim sshd tmux zsh yq tig procps-ng rbw htop

RUN groupadd -g 1000 dev && \
    useradd -m -u 1000 -g 1000 -s /bin/zsh dev && \
    mkdir -p /home/dev/.ssh && \
    chown dev:dev /home/dev/.ssh && \
    chown -R dev:dev /home/dev && \
    chmod 700 /home/dev/.ssh && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    npm -g install mcp-hub@latest

COPY conf/pam-sshd /etc/pam.d/sshd

USER dev
RUN touch /home/dev/.ssh/authorized_keys && \
    curl -L https://github.com/kylape.keys >> /home/dev/.ssh/authorized_keys && \
    mkdir -p ~/.config && \
    git -C ~/.config clone https://github.com/kylape/neovim-config.git nvim && \
    ln -s /home/dev/.config/nvim/vimrc.vim /home/dev/.vimrc && \
    nvim --headless -c 'Lazy install' -c 'quit' && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    GOROOT=/go GOPATH=/home/dev/go /go/bin/go install golang.org/x/tools/gopls@latest

COPY conf/tmux.conf /home/dev/.tmux.conf
COPY conf/zshrc /home/dev/.zshrc
COPY conf/gitconfig /home/dev/.gitconfig

USER root
CMD ["/usr/bin/sshd", "-D"]
