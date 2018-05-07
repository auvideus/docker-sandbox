FROM fedora:27

VOLUME /opt/home
VOLUME /opt/dev
VOLUME /opt/security

ARG user=sandbox

RUN groupadd $user && useradd -g $user -s /bin/fish $user

# OS packages
RUN dnf -y install \
    ansible \
    autoconf \
    bind-utils \
    certbot \
    docker \
    docker-compose \
    dos2unix \
    file \
    findutils \
    fish \
    gcc-c++ \
    git \
    go \
    hostname \
    htop \
    iproute \
    java-9-openjdk-devel \
    man \
    mlocate \
    openssl \
    pandoc \
    procps-ng \
    python2-pip \
    python3-pip \
    redhat-rpm-config \
    rsync \
    ruby \
    ruby-devel \
    vim \
    wget \
    which \
    zlib-devel

# Python 2 packages
RUN pip2 install \
    dopy

# Built software
WORKDIR /opt/web

RUN curl -L -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.7.1/doctl-1.7.1-linux-amd64.tar.gz \
    && tar -zxvf doctl.tar.gz

COPY config.fish /root/.config/fish/config.fish
COPY conf.d/ /root/.config/fish/conf.d/

RUN updatedb

ENV SANDBOX_USER $user
ENV SANDBOX_REPO_NAME ""

EXPOSE 4000

CMD ["/usr/bin/fish", "--login"]
