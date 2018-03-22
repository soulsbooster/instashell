#!/bin/sh
clear
echo "\033[1m \033[0;32mHello there! I'm a script that will install all \033[0;31m\033[1;30mthe dependencies\033[0;32m. Keep calm and lean back in the chair. \033[0m \n"
sudo apt install openssl
#wget https://www.openssl.org/source/openssl-1.1.0g.tar.gz
#tar xvf openssl-1.1.0g.tar.gz
sudo apt install tor
sudo apt install curl
