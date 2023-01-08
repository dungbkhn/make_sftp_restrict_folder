#!/bin/bash
shopt -s dotglob
shopt -s nullglob

#setup_for_crontab.sh

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

sleep 2

cd /home/$p1/CreateRemoteLink
node server.js &
cd /home/$p1/autotox
#./autotox &
chmod 777 reset_att.sh
./reset_att.sh &

cd /home/$p1

while true;
do
  if [ -f /home/$p1/mount_ok.txt ] ; then
    echo 'syncthing first time'
    syncthing &
    rm -f /home/$p1/mount_ok.txt
    break
  fi
  
  if [ -f /home/$p1/mount_not_ok.txt ] ; then
    echo 'syncthing first time not ok'
    rm -f /home/$p1/mount_not_ok.txt
    break
  fi
  
  sleep 3
done
