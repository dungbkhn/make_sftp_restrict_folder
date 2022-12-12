#!/bin/bash

shopt -s dotglob
shopt -s nullglob

curdir=$(pwd)

echo $curdir

cd ~

rs=$(ip -6 address | grep 'scope global')

if [ "$rs" == "" ] ; then 
	echo "No Internet Access, Abort!!!!"
	exit 1
fi

apt install git -y

git clone https://github.com/dungbkhn/ChangeRemoteInfo.git

cd ./ChangeRemoteInfo

apt install nodejs npm -y

npm install multer express find

chmod 755 ./changepw.sh

cd ~

git clone https://github.com/dungbkhn/CreateRemoteLink.git

cd ./CreateRemoteLink

npm install multer express find

chmod 755 ./getipv6addr.sh

cd ~

git clone https://github.com/dungbkhn/autotox.git

cd ./autotox

apt install libtoxcore-dev -y

make clean

make

echo "-----------------------------"
echo "OK, all coms are installed"
echo "-----------------------------"

cd $curdir

exit 0

