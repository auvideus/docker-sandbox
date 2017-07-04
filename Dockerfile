FROM centos:centos7

LABEL maintainer "auvideus@protonmail.com"

RUN yum -y install epel-release \
    && yum -y group install "Development Tools"

VOLUME /opt/dev

RUN groupadd auvideus && useradd -g auvideus -s /bin/fish auvideus

RUN yum -y install \
    fish \
    mlocate \
    python-pip \
    salt \
    salt-api \
    salt-cloud \
    salt-master \
    salt-minion \
    salt-ssh \
    salt-syndic

RUN pip install --upgrade pip

RUN git config --global credential.helper store \
    && git config --global user.name auvideus \
    && git config --global user.email eric.august.huneke@protonmail.com

COPY config/.git-credentials /root/.git-credentials
COPY config/config.fish /root/.config/fish/config.fish
