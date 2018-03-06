if status --is-login
    mkdir -p -m 700 /root/.ssh
    cp /opt/security/id_rsa /root/.ssh/id_rsa
    chmod 600 /root/.ssh/id_rsa
    cp /opt/security/id_rsa.pub /root/.ssh/id_rsa.pub
    chmod 666 /root/.ssh/id_rsa.pub

    set -l GIT_NAME (git config -f /opt/home/.gitconfig --get user.name)
    set -l GIT_EMAIL (git config -f /opt/home/.gitconfig --get user.email)
    set -l GIT_PROXY_HTTPS (git config -f /opt/home/.gitconfig --get https.proxy)
    set -l GIT_PROXY_HTTP (git config -f /opt/home/.gitconfig --get http.proxy)
    git config --global user.name $GIT_NAME
    git config --global user.email $GIT_EMAIL
    if [ $GIT_PROXY_HTTPS ]
        git config --global https.proxy $GIT_PROXY_HTTPS
    end
    if [ $GIT_PROXY_HTTP ]
        git config --global http.proxy $GIT_PROXY_HTTP
    end
    git config --global credential.helper store

    if [ $SANDBOX_REPO_NAME ]
        python3 /opt/dev/repos/$SANDBOX_REPO_NAME/gitauth.py
    end

    cp /opt/security/.git-credentials /root/.git-credentials

    mkdir -p /root/.local/share/fish

    set -x GOPATH /opt/dev/gopath
    set -x REPOS /opt/dev/repos
    set -x GOSRC /opt/dev/gopath/src/github.com/$GIT_NAME

    mkdir -p /opt/home/.local/share/fish
    touch /opt/home/.local/share/fish/fish_history
    ln --symbolic --force \
        /opt/home/.local/share/fish/fish_history \
        /root/.local/share/fish/fish_history

    alias do "doctl -t (cat /opt/security/digital_ocean_token)"
    alias repos "cd $REPOS"
    alias gos "cd $GOSRC"

    set -x PATH $GOPATH/bin /opt/web $PATH

    repos
end
