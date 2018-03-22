#!/bin/bash
clear
printf "\033[1m\033[0;32mHello there! I'm a script that will install all \033[0;31m\033[1;30mthe dependencies\033[0;32m. Keep calm and lean back in the chair.\033[0m\n"
printf "\033[0;31mI NEED YOUR ROOT!!! \033[0m\n"
printf "\033[0;31mCurrent directory: $HOME \033[0m\n\n"
printf "\033[0;31mInstalling OpenSSL\033[0m\n"
cd $HOME
if [ -f $HOME/openssl-1.1.0g.tar.gz ]
then
rm -R -f $HOME/openssl-1.1.0g.tar.gz
fi
if [ -d $HOME/temp ]
then
rm -R -f $HOME/temp
fi
#echo "\033[0;31mHere need your sudo\033[0m\n" && sudo apt install checkinstall
wget https://www.openssl.org/source/openssl-1.1.0g.tar.gz
mkdir $HOME/temp && cd $HOME/temp && mv ../openssl-1.1.0g.tar.gz . && tar -xvf ./openssl-1.1.0g.tar.gz && cd ./openssl-1.1.0g && ./config && sudo make install
printf "\033[0;31mInstalling TOR\033[0m\n"
sudo apt install tor
printf "\033[0;31mInstalling Curl\033[0m\n"
sudo apt install curl
