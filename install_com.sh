#!/bin/bash

shopt -s dotglob
shopt -s nullglob

curdir=$(pwd)

echo $curdir

cd /home/dungnt

rs=$(ip -6 address | grep 'scope global')

if [ "$rs" == "" ] ; then 
	echo "No Internet Access, Abort!!!!"
	exit 1
fi

rs=$(ip -4 address | grep 'scope global')

if [ "$rs" == "" ]; then
    echo "No IPv4 Network Interface Found, Abort!"
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

sed -i.backup '/127.0.0.1/ s/127.0.0.1/'$text'/' ./.config/syncthing/config.xml

rm -r /home/dungnt/Sync

rm -r -f /home/dungnt/ChangeRemoteInfo

git clone https://github.com/dungbkhn/ChangeRemoteInfo.git

if [ $? -eq 0 ]; then
    echo "Clone https://github.com/dungbkhn/ChangeRemoteInfo.git OK"
else
    echo "Clone https://github.com/dungbkhn/ChangeRemoteInfo.git FAIL"
    rm -r -f /home/dungnt/ChangeRemoteInfo
    cd $curdir
    exit 1
fi

cd /home/dungnt/ChangeRemoteInfo

npm install multer express find

chmod 755 ./changepw.sh

cd /home/dungnt

rm -r -f /home/dungnt/CreateRemoteLink
 
git clone https://github.com/dungbkhn/CreateRemoteLink.git

if [ $? -eq 0 ]; then
    echo "Clone https://github.com/dungbkhn/CreateRemoteLink.git OK"
else
    echo "Clone https://github.com/dungbkhn/CreateRemoteLink.git FAIL"
    rm -r -f /home/dungnt/CreateRemoteLink
    cd $curdir
    exit 1
fi

cd /home/dungnt/CreateRemoteLink

npm install multer express find

chmod 755 ./getipv6addr.sh

cd /home/dungnt

rm -r -f /home/dungnt/autotox

git clone https://github.com/dungbkhn/autotox.git

if [ $? -eq 0 ]; then
    echo "Clone https://github.com/dungbkhn/autotox.git OK"
else
    echo "Clone https://github.com/dungbkhn/autotox.git FAIL"
    rm -r -f /home/dungnt/autotox
    cd $curdir
    exit 1
fi

cd /home/dungnt/autotox

make clean

make

cd $curdir

echo "-----------------------------"
echo "OK, all coms are installed"
echo "-----------------------------"

exit 0

