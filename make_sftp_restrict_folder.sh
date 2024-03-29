#!/bin/bash

shopt -s dotglob
shopt -s nullglob

addgroup restriction

useradd -M store

echo -e "123456789\n123456789" | passwd store

usermod -a -G  restriction store

mkdir /var/res

chgrp -R restriction /var/res

mkdir /var/res/share

chgrp -R restriction /var/res/share

chown store /var/res/share

mkdir /var/res/backup

chgrp -R dungnt /var/res/backup

chown dungnt /var/res/backup

if [ ! -f /etc/ssh/sshd_config_backup ] ; then
  cp /etc/ssh/sshd_config /etc/ssh/sshd_config_backup
fi

echo '#Subsystem sftp internal-sftp' >> /etc/ssh/sshd_config
echo 'Match Group restriction' >> /etc/ssh/sshd_config
echo '  ChrootDirectory /var/res' >> /etc/ssh/sshd_config
echo '  ForceCommand internal-sftp' >> /etc/ssh/sshd_config
echo '  AllowTcpForwarding no' >> /etc/ssh/sshd_config
echo '  X11Forwarding no' >> /etc/ssh/sshd_config
echo '  PermitTunnel no' >> /etc/ssh/sshd_config

apt update -y

apt install nodejs npm -y

apt install libtoxcore-dev -y

apt install syncthing -y

