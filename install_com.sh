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

rm -r ~/ChangeRemoteInfo

git clone https://github.com/dungbkhn/ChangeRemoteInfo.git

if [ $? -eq 0 ]; then
    echo "Clone https://github.com/dungbkhn/ChangeRemoteInfo.git OK"
else
    echo "Clone https://github.com/dungbkhn/ChangeRemoteInfo.git FAIL"
    rm -r ~/ChangeRemoteInfo
    cd $curdir
    exit 1
fi

cd ./ChangeRemoteInfo

apt install nodejs npm -y

npm install multer express find

chmod 755 ./changepw.sh

cd ~

rm -r ~/CreateRemoteLink
 
git clone https://github.com/dungbkhn/CreateRemoteLink.git

if [ $? -eq 0 ]; then
    echo "Clone https://github.com/dungbkhn/CreateRemoteLink.git OK"
else
    echo "Clone https://github.com/dungbkhn/CreateRemoteLink.git FAIL"
    rm -r ~/CreateRemoteLink
    cd $curdir
    exit 1
fi

cd ./CreateRemoteLink

npm install multer express find

chmod 755 ./getipv6addr.sh

cd ~

rm -r ~/autotox

git clone https://github.com/dungbkhn/autotox.git

if [ $? -eq 0 ]; then
    echo "Clone https://github.com/dungbkhn/autotox.git OK"
else
    echo "Clone https://github.com/dungbkhn/autotox.git FAIL"
    rm -r ~/autotox
    cd $curdir
    exit 1
fi

cd ./autotox

apt install libtoxcore-dev -y

make clean

make

echo "-----------------------------"
echo "OK, all coms are installed"
echo "-----------------------------"

cd $curdir

exit 0

