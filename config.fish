mkdir -p -m 700 /root/.ssh
cp /opt/security/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
cp /opt/security/id_rsa.pub /root/.ssh/id_rsa.pub
chmod 666 /root/.ssh/id_rsa.pub

cp /opt/home/.gitconfig /root/.gitconfig
cp /opt/security/.git-credentials /root/.git-credentials

set -x GOPATH /opt/dev/gopath
set -x GOBIN /opt/dev/gopath/bin

set PATH $GOPATH/bin /opt/web $PATH

alias do "doctl -t (cat /opt/security/digital_ocean_token)"
