FROM fedora:27

LABEL maintainer "auvideus@protonmail.com"

VOLUME /opt/dev
VOLUME /opt/sdev

RUN groupadd auvideus && useradd -g auvideus -s /bin/fish auvideus

RUN dnf -y install \
    ansible \
    docker \
    docker-compose \
    fish \
    git \
    hostname \
    man \
    mlocate \
    python-pip

RUN pip install --upgrade pip

RUN git config --global credential.helper store \
    && git config --global user.name auvideus \
    && git config --global user.email eric.huneke@protonmail.com

COPY config/.git-credentials /root/.git-credentials
COPY config/config.fish /root/.config/fish/config.fish

CMD ["/bin/bash"]
