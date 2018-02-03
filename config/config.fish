mkdir -p -m 700 /root/.ssh
cp /opt/sdev/security/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
cp /opt/sdev/security/id_rsa.pub /root/.ssh/id_rsa.pub
chmod 666 /root/.ssh/id_rsa.pub

set PATH /opt/web $PATH
