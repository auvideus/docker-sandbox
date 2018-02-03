FROM fedora:27

LABEL maintainer "auvideus@protonmail.com"

VOLUME /opt/dev
VOLUME /opt/sdev

RUN groupadd auvideus && useradd -g auvideus -s /bin/fish auvideus

RUN dnf -y install \
    ansible \
    docker \
    docker-compose \
    file \
    fish \
    git \
    hostname \
    man \
    mlocate \
    python2-pip \
    python3-pip \
    wget

RUN pip2 install --upgrade pip

RUN pip3 install --upgrade pip

WORKDIR /opt/web

RUN curl -L -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.7.1/doctl-1.7.1-linux-amd64.tar.gz \
    && tar -zxvf doctl.tar.gz

RUN git config --global credential.helper store \
    && git config --global user.name auvideus \
    && git config --global user.email eric.huneke@protonmail.com

COPY config/.git-credentials /root/.git-credentials
COPY config/config.fish /root/.config/fish/config.fish

CMD ["/bin/bash"]
