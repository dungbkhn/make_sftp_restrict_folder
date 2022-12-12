#!/bin/bash
shopt -s dotglob
shopt -s nullglob

syncthing &

cd /home/dungnt/ChangeRemoteInfo
node server.js &
cd /home/dungnt/CreateRemoteLink
node server.js &
cd /home/dungnt/autotox
./autotox &
