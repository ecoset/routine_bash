#!/bin/bash

os=/etc/os-release
bashrc=~/.bashrc
check="#MyAlias_v1.0.0"

aliasList() {
    echo "" >> $bashrc
    echo $check >> $bashrc
    echo "" >> $bashrc
    echo "alias _=\"sudo\"" >> $bashrc
    echo "alias ii=\"xdg-open\"" >> $bashrc 
    echo "alias inst=\"sudo $packageManager $installCommand\"" >> $bashrc
    echo "alias search=\"$packageManager $searchCommand\"" >> $bashrc
    echo "alias myip=\"curl ifconfig.co\"" >> $bashrc
}

if ! [ -f $bashrc ]; then
    echo "Error - .bashrc file not found in user directory!"
    exit 1
else
    if ( grep -w $check $bashrc ); then
        echo "Alias already installed"
    else
        if ( grep debian $os ); then
            packageManager="apt"
            installСommand="install"
            searchCommand="search"
            aliasList
        elif ( grep arch $os ); then
            packageManager="pacman"
            installCommand="-S"
            searchCommand="-Ss"
            aliasList
        fi
        source $bashrc
    fi
fi
