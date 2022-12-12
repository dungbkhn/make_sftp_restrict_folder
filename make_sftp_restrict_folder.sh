#!/bin/bash

shopt -s dotglob
shopt -s nullglob

addgroup restriction

useradd -M store

echo -e "td123456789\ntd123456789" | passwd store

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

rm -r /home/dungnt/ChangeRemoteInfo

rm -r /home/dungnt/CreateRemoteLink

rm -r /home/dungnt/autotox

apt install nodejs npm -y

apt install libtoxcore-dev -y

apt install syncthing -y

rs=$(ip -4 address | grep 'scope global')

if [ "$rs" == "" ]; then
    echo "No Network Found, Abort!"
    exit 1
fi

# Set comma as delimiter
IFS='/'

#Read the split words into an array based on comma delimiter
read -a strarr <<< "$rs"

bn=$(echo "${strarr[0]}" | xargs)

an=$(echo "${strarr[1]}" | xargs)

#Print the splitted words
text=$bn

# Set comma as delimiter
IFS=' '

#Read the split words into an array based on comma delimiter
read -a strarr <<< "$text"

bn=$(echo "${strarr[0]}" | xargs)

an=$(echo "${strarr[1]}" | xargs)

#Print the splitted words
text=$an

echo $text

timeout 10s syncthing

sed -i.backup '/127.0.0.1/ s/127.0.0.1/'$text'/' /root/.config/syncthing/config.xml

rm -r /home/dungnt/Sync

reboot
