FROM fedora:27

VOLUME /opt/home
VOLUME /opt/dev
VOLUME /opt/security

ARG user=sandbox

RUN groupadd $user && useradd -g $user -s /bin/fish $user

# OS packages
RUN dnf -y install \
    ansible \
    certbot \
    docker \
    docker-compose \
    file \
    fish \
    git \
    go \
    hostname \
    man \
    mlocate \
    python2-pip \
    python3-pip \
    rsync \
    vim \
    wget \
    which

# Python 2 packages
RUN pip2 install --upgrade pip
RUN pip2 install \
    dopy

# Python 3 packages
RUN pip3 install --upgrade pip

# Built software
WORKDIR /opt/web

RUN curl -L -o doctl.tar.gz https://github.com/digitalocean/doctl/releases/download/v1.7.1/doctl-1.7.1-linux-amd64.tar.gz \
    && tar -zxvf doctl.tar.gz

COPY config.fish /root/.config/fish/config.fish

RUN updatedb

CMD ["/usr/bin/fish"]
