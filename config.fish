if status --is-login
    mkdir -p -m 700 /root/.ssh
    cp /opt/security/id_rsa /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
    cp /opt/security/id_rsa.pub /root/.ssh/id_rsa.pub
    chmod 666 /root/.ssh/id_rsa.pub

    set -l GIT_NAME (git config -f /opt/home/.gitconfig --get user.name)
    set -l GIT_EMAIL (git config -f /opt/home/.gitconfig --get user.email)
    git config --global user.name $GIT_NAME
    git config --global user.email $GIT_EMAIL
    git config --global credential.helper store

    cp /opt/security/.git-credentials /root/.git-credentials

    mkdir -p /root/.local/share/fish

    set -x GOPATH /opt/dev/gopath

    ln --symbolic --force \
        /opt/home/.local/share/fish/fish_history \
        /root/.local/share/fish/fish_history

    alias do "doctl -t (cat /opt/security/digital_ocean_token)"

    set -x PATH $GOPATH/bin /opt/web $PATH
end
