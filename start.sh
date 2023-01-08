#!/bin/bash
shopt -s dotglob
shopt -s nullglob

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

cd /home/$p1
apt install git -y
#chu y thuong armbian da co san git roi
git clone https://github.com/dungbkhn/make_sftp_restrict_folder.git
cd ./make_sftp_restrict_folder
chmod 755 make_sftp_restrict_folder.sh
chmod 755 install_com.sh
sudo -u $p1 ./install_com.sh 
sudo -u root ./make_sftp_restrict_folder.sh