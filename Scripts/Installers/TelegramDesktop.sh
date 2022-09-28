#!/bin/bash

#Telegram downloader v1.0.0
os=/etc/os-release
portable=~/Portable
telegram=~/Portable/Telegram
bin=/bin/


if ! [[ -d $portable && -d $telegram ]]; then
    mkdir $portable
    if ! (ls $bin | grep wget); then
        if (grep debian $os); then
            sudo apt update
            sudo apt install wget -y
        elif (grep arch $os); then
            sudo pacman -S wget -y
        else
            echo "Error - this OS is not in the script"
            exit 1
        fi
    fi
    cd ~/
    wget -O telegram.tar.xz https://telegram.org/dl/desktop/linux
    tar -xf ~/telegram.tar.xz
    mv ~/Telegram $portable
    rm -f ~/telegram.tar.xz
    chmod -R 700 $telegram
else
    echo "Telegram already installed"
fi