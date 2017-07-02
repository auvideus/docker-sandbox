FROM centos:centos7

LABEL maintainer "auvideus@protonmail.com"

RUN yum -y install epel-release \
    && yum -y group install "Development Tools"

VOLUME /opt/dev

RUN yum -y install \
    fish \
    mlocate \
    salt \
    salt-api \
    salt-cloud \
    salt-master \
    salt-minion \
    salt-ssh \
    salt-syndic

RUN groupadd auvideus && useradd -g auvideus -s /bin/fish auvideus

COPY config.fish /root/.config/fish/config.fish
