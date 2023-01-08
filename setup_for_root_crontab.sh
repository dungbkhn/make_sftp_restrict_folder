#!/bin/bash
shopt -s dotglob
shopt -s nullglob

#setup_for_root_crontab.sh

if [ $# -ne 1 ] ; then
        echo 'need 1 param'
        exit 1
fi

p1=$1
echo $p1

if [ ! -d /home/$p1 ] ; then
        echo 'directory not exists'
        exit 1
fi

rm /home/$p1/mount_ok.txt
rm /home/$p1/mount_not_ok.txt

cd /home/$p1/ChangeRemoteInfo
node server.js &

cd /home/$p1

COUNTER=0

while true;
do
  rs=$(/sbin/fdisk -l | grep "/dev/sda")
  
  if [ "$rs" != "" ] ; then
    echo 'mount first time'
    mount /dev/sda1 /var/res/backup     
    chgrp -R $p1 /var/res/backup
    chown $p1 /var/res/backup
    chmod 755 /var/res/backup
    touch /home/$p1/mount_ok.txt    
    break
  fi
  
  COUNTER=$(( COUNTER + 1 ))
  
  if [ $COUNTER -eq 3 ] ; then
    echo 'mount first time not ok'
    touch /home/$p1/mount_not_ok.txt
    break
  fi
  
  sleep 3
done
