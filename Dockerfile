FROM fedora:25

LABEL maintainer "auvideus@protonmail.com"

#RUN yum -y install epel-release \
#    && yum -y group install "Development Tools"

VOLUME /opt/dev
VOLUME /opt/sdev

RUN groupadd auvideus && useradd -g auvideus -s /bin/fish auvideus

RUN dnf -y install \
    ansible \
    fish \
    git \
    hostname \
    man \
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
RUN pip uninstall -y apache-libcloud

RUN git config --global credential.helper store \
    && git config --global user.name auvideus \
    && git config --global user.email eric.august.huneke@protonmail.com

COPY config/salt/do_provider.conf /etc/salt/cloud.providers.d/do_provider.conf
COPY config/salt/do_profiles.conf /etc/salt/cloud.profiles.d/do_profiles.conf

COPY config/.git-credentials /root/.git-credentials
COPY config/config.fish /root/.config/fish/config.fish

CMD ["/bin/bash"]
